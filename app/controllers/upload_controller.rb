# encoding: utf-8
require 'json'

class UploadController < ApplicationController
    /-------------------------------------------------------------
    - renders upload.html.erb
    -
    -
    --------------------------------------------------------------/

	def index
    	 respond_to do |format|
      		format.html 
    	end
 	end

    /-------------------------------------------------------------
    - Uploads excel file onto the server, also creates the 
    - necessary relationships in our database. Creates a new 
    - offer chain as well as new tickets
    -
    -
    --------------------------------------------------------------/
    def upload
 	uploaded_io = params[:file] 
      if uploaded_io != nil      
          offer_chain = OfferChain.new :approved => "false",
                                       :date => Time.now.strftime("%m/%d/%Y %H:%M")
    	  offer_chain.save

          stagingTicket = offer_chain.tickets.create :description => ""
          stagingTicket.summary = ""
          stagingTicket.save

          productionTicket = offer_chain.tickets.create :description => ""
          productionTicket.summary = ""
          productionTicket.save

          execute_file = nil

          File.open(Rails.root.join('public', 'files', uploaded_io.original_filename), 'w') do |file|
              file.write(uploaded_io.read.force_encoding("utf-8"))
              nytfile = offer_chain.nytfiles.create(:upload => file)
              nytfile.name = uploaded_io.original_filename
              offer_chain.nytfiles << nytfile
              offer_chain.tickets << stagingTicket
              offer_chain.tickets << productionTicket
              execute_file = file
              file.close
	        end

         offer_chain.save
         @alert1 = true
         @alert1_check = true
         @alert2 = true
         @svnDirectoryNotOk = false
         execute_python	(execute_file)
    end 
    end

    /-------------------------------------------------------------
    - Executes plato_offers.sh which creates both .yaml and .sql files
    -
    -
    --------------------------------------------------------------/
    def execute_python(file)
        plato = Rails.root.join('public', 'scripts', 'plato_offers.sh') 
            if logAndSystem("bash #{Rails.root}/public/scripts/plato_offers.sh #{file.path} #{Rails.root}/public/scripts")
                @alert1 = true
                @alert1_check = true
                @alert2 = true
                @alert2_check = true
                @alert3 = true
                @svnDirectoryNotOk = false
                render "index.html.erb" and return
            
           else
            @alert_file_not_good = true
            render "index.html.erb" and return
        end
    end

     /-------------------------------------------------------------
    - Updates the subversion repository. Creates a new directory
    - and also creates upgrade.sql and rollback.sql files 
    -
    -
    --------------------------------------------------------------/

    def update_svn_repo 
        directory = params[:textBox2]

        if logAndSystem ("cd #{Rails.root}/public/offer_chains_svn_2/core_owner && mkdir #{directory} && cd #{directory} && touch rollback.sql && touch upgrade.sql")
            if logAndSystem("cd #{Rails.root}/public/scripts && cat ./offers.auto.sql > #{Rails.root}/public/offer_chains_svn_2/core_owner/#{directory}/upgrade.sql ")
                @alert1 = true
                @alert1_check = true
                @alert2 = true
                @alert2_check = true
                @alert3 = true
                @alert3_check = true
                @alert4 = true
                @svnDirectoryNotOk = false

                ok = true
                OfferChain.order('created_at DESC').first.tickets.each do |x|
                    if ok
                        x.summary = "Please deploy #{directory}"
                        x.description = "Please deploy: https://svn.prvt.nytimes.com/svn/db/trunk/oracle/migrations/EC/core_owner/#{directory}"
                        OfferChain.order('created_at DESC').first.tickets << x
                        ok = false
                
                    else
                        x.summary = "Please deploy #{directory} "
                        x.description = "Please deploy: https://svn.prvt.nytimes.com/svn/db/trunk/oracle/migrations/EC/core_owner/#{directory}"
                        OfferChain.order('created_at DESC').first.tickets << x
                     end
                end 

                ecst = false
                ecst2 = false

                if params[:ECST] 
                    ecst = true
                end

                if params[:ECST2]
                    ecst2 = true
                end

                inject_into_db(ecst, ecst2)
            else
                render :text => "Could not copy contents into upgrade.sql"
            end
        else
            @alert1 = true
            @alert1_check = true
            @alert2 = true
            @alert2_check = true
            @alert3 = true
            @svnDirectoryNotOk = true and render "index.html.erb"
        end
    end

    
    /-------------------------------------------------------------
    - Retrieves the latest excel file held on the server
    -
    -
    --------------------------------------------------------------/

    def download_excel_file
        file_name = Nytfile.order('created_at DESC').first.name
        render :file => "#{Rails.root}/public/files/#{file_name}"
    end


    /-------------------------------------------------------------
    - Retrieves the latest yaml file held on the server
    -
    -
    --------------------------------------------------------------/
    def download_yaml_file
        render :file => "#{Rails.root}/public/scripts/offers.auto.yaml"
    end


    /-------------------------------------------------------------
    - Retrieves the latest sql file held on the server
    -
    -
    --------------------------------------------------------------/
    def download_sql_file
        render :file => "#{Rails.root}/public/scripts/offers.auto.sql"
    end

    /-------------------------------------------------------------
    - Connects via sqlplus to the NYT databases, specifically
    - boxes ECST and ECST2, injects the newly generated offers.auto.sql
    - file into each database
    -
    -
    --------------------------------------------------------------/
    def inject_into_db(ecst, ecst2)
        begin 
            if(ecst)
                logAndSystem("echo exit | sqlplus core_owner/ecdvo1@ECST @offers.auto.sql") 
                @alert4_ecst_check = true
            end
            if(ecst2)
                logAndSystem("echo exit | sqlplus core_owner/ecdvo1@ECST2 @offers.auto.sql")
                @alert4_ecst2_check = true 
            end
                @alert1 = true
                @alert1_check = true
                @alert2 = true
                @alert2_check = true
                @alert3 = true
                @alert3_check = true
                @alert4 = true
                @alert4_check = true
                @alert5 = true
            render "index.html.erb" 
        rescue Exception
            render :text => "Build Failed"
        end
    end

    /-------------------------------------------------------------
    - Talks to the JIRA API to generate both a staging and
    - production ticket for the user
    -
    -
    --------------------------------------------------------------/
    def generate_jira_ticket 

	Rails.logger.info("Very beginning")

        /getting parameters from upload.html.erb/

        project = projectHelper(params[:project])
        project_name = projectHelper2(params[:project])
        issue_type = issueTypeHelper(params[:issue_type])
        summary = params[:summary]
        description = params[:description]
        username = params[:usernameTag]
        password = params[:passwordTag]
        db_service_type = serviceTypeHelper (params[:serviceType])
        priority = priorityHelper (params[:priority])
        staging_ticket_json = ""
        production_ticket_json = ""
        pmom_key =""
    
        / generate PMOM Ticket /

        begin 
            pmom_key = params[:PMOMTag]

            / generate staging and production tickets /

            ok=true
            OfferChain.order('created_at DESC').first.tickets.each do |x|
                if ok
                    x.summary.concat(" to ECST")
                    index =  x.description.index("https")
                    x.description = "Please deploy " + URI.escape(x.description[index, x.description.length])
                    x.description.concat(" to ECST")
		
                    staging_curl = "curl -s -k -u \"#{username}\":\"#{password}\" -X POST --data \'{\"fields\": { \"project\": { \"key\": \"#{project}\",\"name\": \"#{project_name}\"}, \"summary\": \"#{x.summary}\",\"description\": \"#{x.description}\",\"issuetype\": {\"name\": \"#{issue_type}\"}}}\' -H \"Content-Type: application/json\" https://jira.em.nytimes.com/rest/api/2/issue/"
	            
			Rails.logger.info("Staging curl: " + staging_curl)
			staging_ticket_json = `#{staging_curl}`
                    ok = false

			Rails.logger.info("Staging ticket json: " + staging_ticket_json)
                else
                    x.summary.concat(" to ECPR")
                    index =  x.description.index("https")
                    x.description = "Please deploy " + URI.escape(x.description[index, x.description.length])
                    x.description.concat(" to ECPR")
                    production_ticket_json = `curl -s -k -u \"#{username}\":\"#{password}\" -X POST --data \'{\"fields\": { \"project\": { \"key\": \"#{project}\",\"name\": \"#{project_name}\"}, \"summary\": \"#{x.summary}.\",\"description\": \"#{x.description}\",\"issuetype\": {\"name\": \"#{issue_type}\"}}}\'  -H \"Content-Type: application/json\" https://jira.em.nytimes.com/rest/api/2/issue/`
                end
                OfferChain.order('created_at DESC').first.tickets.where(:id => x.offer_chain_id) << x
            end

            / Create Links between Tickets /

            create_links_between_stg_prod_and_pmom_tickets(staging_ticket_json, production_ticket_json,username,password,pmom_key)

            @alert1 = true
            @alert1_check = true
            @alert2 = true
            @alert2_check = true
            @alert3 = true
            @alert3_check = true
            @alert4 = true
            @alert4_check = true
            @alert5 = true
            @alert5_check = true
            render "index.html.erb" and return 
        rescue Exception => e
	    Rails.logger.error("Failed due to: " + e.message)
            @alert1 = true
            @alert1_check = true
            @alert2 = true
            @alert2_check = true
            @alert3 = true
            @alert3_check = true
            @alert4 = true
            @alert4_check = true
            @alert5 = true
            @jira_ticket_failed = true 
            render "index.html.erb" and return
        end
    end

    /-------------------------------------------------------------
    - Creates relationships between Staging, Production, and PMOM
    - tickets that were previously generated (relates to, blocks, 
    - blocked by, etc)
    -
    -
    --------------------------------------------------------------/
    def create_links_between_stg_prod_and_pmom_tickets(stg_json, prd_json, username,password,pmom_key)
 
        stg_json = JSON.parse(stg_json)
        prd_json = JSON.parse(prd_json)

        stg_id = stg_json["id"]
        prd_id = prd_json["id"]

        stg_key = stg_json["key"]
        prd_key = prd_json["key"]
 
        relationship_stg = "is blocked by"
        relationship_prd = "blocks"
        relationship_both = "relates to"

        stg_summary = ""
        prd_summary = ""

        ok=true

	Rails.logger.info("Before DB call")

        OfferChain.order('created_at DESC').first.tickets.each do |x|
            if ok
                stg_summary = x.summary
                ok = false
             else
                prd_summary = x.summary
            end
        end

	Rails.logger.info("Before CURLs")

        / staging / 
        logAndSystem("curl -s -k -u \"#{username}\":\"#{password}\" -X POST --data \'{\"relationship\": \"#{relationship_stg}\", \"object\": { \"url\":\"https://jira.em.nytimes.com/browse/#{prd_key}\", \"title\":\"#{prd_key}\", \"summary\":\" #{prd_summary} \"}}\' -H \"Content-Type: application/json\" https://jira.em.nytimes.com/rest/api/2/issue/#{stg_key}/remotelink ")
        

	logAndSystem("curl -s -k -u \"#{username}\":\"#{password}\" -X POST --data \'{\"relationship\": \"#{relationship_both}\", \"object\": { \"url\":\"https://jira.em.nytimes.com/browse/#{pmom_key}\", \"title\":\"#{pmom_key}\",\"summary\":\"#{Nytfile.last.name}\"}}\' -H \"Content-Type: application/json\" https://jira.em.nytimes.com/rest/api/2/issue/#{stg_key}/remotelink ")
        
        / production / 
        logAndSystem("curl -s -k -u \"#{username}\":\"#{password}\" -X POST --data \'{\"relationship\": \"#{relationship_prd}\", \"object\": { \"url\":\"https://jira.em.nytimes.com/browse/#{stg_key}\", \"title\":\"#{stg_key}\",\"summary\:\"#{stg_summary} \"}}\' -H \"Content-Type: application/json\" https://jira.em.nytimes.com/rest/api/2/issue/#{prd_key}/remotelink ")
        logAndSystem("curl -s -k -u \"#{username}\":\"#{password}\" -X POST --data \'{\"relationship\": \"#{relationship_both}\", \"object\": { \"url\":\"https://jira.em.nytimes.com/browse/#{pmom_key}\", \"title\":\"#{pmom_key}\",\"summary\":\"#{Nytfile.last.name}\"}}\' -H \"Content-Type: application/json\" https://jira.em.nytimes.com/rest/api/2/issue/#{prd_key}/remotelink ")

        / pmom /
        logAndSystem("curl -s -k -u \"#{username}\":\"#{password}\" -X POST --data \'{\"relationship\": \"#{relationship_both}\", \"object\": { \"url\":\"https://jira.em.nytimes.com/browse/#{stg_key}\", \"title\":\"#{stg_key}\",\"summary\":\"#{stg_summary} \"}}\' -H \"Content-Type: application/json\" https://jira.em.nytimes.com/rest/api/2/issue/#{pmom_key}/remotelink ")
        logAndSystem("curl -s -k -u \"#{username}\":\"#{password}\" -X POST --data \'{\"relationship\": \"#{relationship_both}\", \"object\": { \"url\":\"https://jira.em.nytimes.com/browse/#{prd_key}\", \"title\":\"#{prd_key}\",\"summary\":\"#{prd_summary} \"}}\' -H \"Content-Type: application/json\" https://jira.em.nytimes.com/rest/api/2/issue/#{pmom_key}/remotelink ")
end


	def logAndSystem(command)
		Rails.logger.debug(command)
		system(command)
	end
    /-------------------------------------------------------------
    -
    -
    -
    --------------------------------------------------------------/

    def projectHelper(projectId)

        case projectId
            when "1"
                return "ORA" 
            when "2"
                return "PMOM"
            when "3"
                return "SY"
            when "4"
                return "INFRASVC"
            
        end
    end

    /-------------------------------------------------------------
    -
    -
    -
    --------------------------------------------------------------/
      def projectHelper2(projectId)
        
        case projectId
        when "1"
            return "Databases: Oracle"
        when "2"
            return "Pay Model Sartre"
        when "3" 
            return "Systems Operations"
        when "4"
            return "Infra - Services"
        end
    end
   
   /-------------------------------------------------------------
    -
    -
    -
    --------------------------------------------------------------/
    def issueTypeHelper(issueId)
    
         case issueId
         when "1"
              return "Service Request"
         when "2"
              return "Story"
         when "3" 
              return "Bug"
        end
    end

   /-------------------------------------------------------------
    -
    -
    -
    --------------------------------------------------------------/

    def priorityHelper(priorityId)
        case priorityId 
        when "1"
            return "Minor"
        when "2"
            return "Blocker"
        when "3" 
            return "Critical"
        when "4"
            return "Major"
        when "5" 
            return "Trivial" 
        end
           
    end

   /-------------------------------------------------------------
    -
    -
    -
    --------------------------------------------------------------/
    def serviceTypeHelper(stypeId)

        case stypeId
        when "1"
            return "Deploy a Migration"
        when "2"
            return "None"
        when "3"
            return "Backup Existing Database"
        when "4"
            return "Setup new Database"
        end
    end

   /-------------------------------------------------------------
    -
    -
    -
    --------------------------------------------------------------/
    def hostEnvHelper(hostEnvId)
        case hostEnvId
        when "1"
            return "None"
        when "2"
            return "Development"
        when "3"
            return "Staging"
        when "4" 
            return "Production"
        end
    end
end

