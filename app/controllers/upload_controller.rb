class UploadController < ApplicationController

	def index
    	 respond_to do |format|
      		format.html
    	end
 	end
  
  	def uploadFile
    	post = DataFile.save(params[:upload])
    	render :text => "File has been uploaded successfully"
  	end
end
