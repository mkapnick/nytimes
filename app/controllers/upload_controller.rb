class UploadController < ApplicationController

	def index
    	 respond_to do |format|
      		format.html 
    	end
 	end

    def upload
 	  uploaded_io = params[:file]     
      offer_chain = OfferChain.new :approved => "false",
                                   :date => Time.now.strftime("%m/%d/%Y %H:%M")

	  File.open(Rails.root.join('public', 'files', uploaded_io.original_filename), 'w') do |file|
      file.write(uploaded_io.read.force_encoding("utf-8"))
      excel_file = Nytfile.create :upload => file
      offer_chain.nytfiles << excel_file
      file.close
	end

     offer_chain.save	
	 render :text => "File Uploaded Successfully"
    end 
end
