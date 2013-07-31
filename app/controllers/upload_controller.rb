class UploadController < ApplicationController

	def index
    	 respond_to do |format|
      		format.html 
    	end
 	end

    def upload
 	uploaded_io = params[:file] 
      if uploaded_io != nil      
          offer_chain = OfferChain.new :approved => "false",
                                       :date => Time.now.strftime("%m/%d/%Y %H:%M")
    	 
          File.open(Rails.root.join('public', 'files', uploaded_io.original_filename), 'w') do |file|
              file.write(uploaded_io.read.force_encoding("utf-8"))
              excel_file = Nytfile.create :upload => file
              offer_chain.nytfiles << excel_file
              file.close
	        end

         offer_chain.save
         render :text => "File Uploaded "	
          
    else
         render :text =>"No File"
    end 

end

    def execute_python
        plato = Rails.root.join('public', 'scripts', 'plato_offers.sh')
        excel = Rails.root.join('public', 'files', 'test.xls')

        begin 
            value = system("bash /Users/205463/nytimes/public/scripts/plato_offers.sh #{excel}")
            if(value)
                flash.alert = true
                render "index.html.erb"
            else
                flash.alert = false
                render 
            end
        rescue Exception 
            render :text => "ERROR running plato_offers.sh"
        end
    end

    def download_yaml_file
        render :file => "#{Rails.root}/public/scripts/offers.auto.yaml"
    end

    def download_sql_file
        render :file => "#{Rails.root}/public/scripts/offers.auto.sql"
    end


end
