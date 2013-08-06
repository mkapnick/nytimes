# encoding: utf-8
class UploadController < ApplicationController

    /-------------------------------------------------------------
    -
    -
    -
    --------------------------------------------------------------/
    @alert1 = false
    @alert2 = false
    @alert3 = false
    @alert4 = false 

	def index
    	 respond_to do |format|
      		format.html 
    	end
 	end

    /-------------------------------------------------------------
    -
    -
    -
    --------------------------------------------------------------/
    def upload
 	uploaded_io = params[:file] 
      if uploaded_io != nil      
          offer_chain = OfferChain.new :approved => "false",
                                       :date => Time.now.strftime("%m/%d/%Y %H:%M")
    	  offer_chain.save
          File.open(Rails.root.join('public', 'files', uploaded_io.original_filename), 'w') do |file|
              file.write(uploaded_io.read.force_encoding("utf-8"))
              nytfile = offer_chain.nytfiles.create(:upload => file)
              nytfile.name = uploaded_io.original_filename
              #offer_chain.nytfiles.name => uploaded_io.original_filename
              offer_chain.nytfiles << nytfile
              file.close
	        end

         offer_chain.save
         @alert1 = true
         render "index.html.erb"	
          
    else
         render :text =>"No File"
    end 

    end

    /-------------------------------------------------------------
    -
    -
    -
    --------------------------------------------------------------/
    def execute_python
        plato = Rails.root.join('public', 'scripts', 'plato_offers.sh')
        excel = Rails.root.join('public', 'files', 'test.xls')

        begin 
            if system("bash #{Rails.root}/public/scripts/plato_offers.sh #{excel}")
                @alert1= true
                @alert2 = true
                render "index.html.erb" 
            end
        rescue Exception 
            render :text => "ERROR running plato_offers.sh"
        end
    end


    def update_svn_repo 
        directory = params[:textBox2]
        if system ("cd #{Rails.root}/public/offer_chains_svn_2/core_owner && mkdir #{directory} && cd #{directory} && touch rollback.sql && touch upgrade.sql")
            if system("cd #{Rails.root}/public/scripts && cat ./offers.auto.sql > #{Rails.root}/public/offer_chains_svn_2/core_owner/#{directory}/upgrade.sql ")
                @alert1 = true
                @alert2 = true
                @alert3 = true
                render "index.html.erb"
            else
                render :text => "Could not copy contents into upgrade.sql"
            end
        end
    end

    
    /-------------------------------------------------------------
    -
    -
    -
    --------------------------------------------------------------/

    def download_excel_file
        file_name = Nytfile.order('created_at DESC').first.name
        render :file => "#{Rails.root}/public/files/#{file_name}"
    end


    /-------------------------------------------------------------
    -
    -
    -
    --------------------------------------------------------------/
    def download_yaml_file
        render :file => "#{Rails.root}/public/scripts/offers.auto.yaml"
    end


    /-------------------------------------------------------------
    -
    -
    -
    --------------------------------------------------------------/
    def download_sql_file
        render :file => "#{Rails.root}/public/scripts/offers.auto.sql"
    end

    /-------------------------------------------------------------
    -
    -
    -
    --------------------------------------------------------------/
    def inject_into_db
        begin 
            value = system("sqlplus core_owner/ecdvo1@ECDV7 @offers.auto.sql") 
            value2 = system("sqlplus core_owner/ecdvo1@ECDV6 @offers.auto.sql") 
            #system("sqlplus core_owner/ecdvo1@ECDV7 @/Users/205463/nytimes/public/scripts/simple_query.sql")
            @alert1= true
            @alert2 = true
            @alert3 = true
            @alert4 = true
            render "index.html.erb" 
        rescue Exception
            render :text => "Build Failed"
        end
    end

    /-------------------------------------------------------------
    -
    -
    -
    --------------------------------------------------------------/
    def generate_jira_ticket 
        project = projectHelper(params[:project])
        project_name = projectHelper2(params[:project])
        issue_type = issueTypeHelper(params[:issue_type])
        summary = params[:summary]
        description = params[:description]
        username = params[:usernameTag]
        password = params[:passwordTag]
        db_service_type = serviceTypeHelper (params[:serviceType])
        host_env = hostEnvHelper (params[:host_env])
        priority = priorityHelper (params[:priority])


    if db_service_type != "None" && host_env != "None"
        #curl = 
    else
        curl = "curl -D- -u \"#{username}\":\"#{password}\" -X POST --data \'{\"fields\": { \"project\": { \"key\": \"#{project}\",\"name\": \"#{project_name}\"}, \"summary\": \"#{summary}.\",\"description\": \"#{description}\",\"issuetype\": {\"name\": \"#{issue_type}\"}}}\'  -H \"Content-Type: application/json\" https://jira.em.nytimes.com/rest/api/2/issue/"
    end
        
    system(curl)
        
    end

   /-------------------------------------------------------------
    -
    -
    -
    --------------------------------------------------------------/
    def projectHelper(projectId)
        
        case projectId
        when 1
            return "PMOM"
        when 2
            return "ORA"
        when 3 
            return "SY"
        when 4
            return "INFRASVC"
        else 
            render :text => "Error: Make sure necessary fields are filled out when generating a JIRA ticket"
        end
    end

      def projectHelper2(projectId)
        
        case projectId
        when 1
            return "Pay Model Sartre"
        when 2
            return "Databases: Oracle"
        when 3 
            return "Systems Operations"
        when 4
            return "Infra - Services"
        else 
            render :text => "Error: Make sure necessary fields are filled out when generating a JIRA ticket"
        end
    end
   
   /-------------------------------------------------------------
    -
    -
    -
    --------------------------------------------------------------/
    def issueTypeHelper(issueId)
    
         case issueId
         when 1
              return "Service Request "
         when 2
              return "Story"
         when 3 
              return "Bug"
         else 
            render :text => "Error: Make sure necessary fields are filled out when generating a JIRA ticket"
        end
    end

   /-------------------------------------------------------------
    -
    -
    -
    --------------------------------------------------------------/

    def priorityHelper(priorityId)
        case priorityId 
        when 1
            return "None"
        when 2
            return "Blocker"
        when 3 
            return "Critical"
        when 4
            return "Major"
        when 5 
            return "Minor"
        else 
            render :text => "Error: Make sure necessary fields are filled out when generating a JIRA ticket"
        end
    end

   /-------------------------------------------------------------
    -
    -
    -
    --------------------------------------------------------------/
    def serviceTypeHelper(stypeId)

        case stypeId
        when 1
            return "None"
        when 2
            return "Deploy a Migration"
        when 3
            return "Backup Existing Database"
        when 4
            return "Setup new Database"
        else 
            render :text => "Error: Make sure necessary fields are filled out when generating a JIRA ticket"
        end
    end

   /-------------------------------------------------------------
    -
    -
    -
    --------------------------------------------------------------/
    def hostEnvHelper(hostEnvId)
        case hostEnvId
        when 1
            return "None"
        when 2
            return "Development"
        when 3
            return "Staging"
        when 4 
            return "Production"
        else 
            render :text => "Error: Make sure necessary fields are filled out when generating a JIRA ticket"
        end
    end
end
