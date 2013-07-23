class NytfilesController < ApplicationController
  # GET /nytfiles
  # GET /nytfiles.json
  def index
    @nytfiles = Nytfile.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @nytfiles }
    end
  end

  # GET /nytfiles/1
  # GET /nytfiles/1.json
  def show
    @nytfile = Nytfile.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @nytfile }
    end
  end

  # GET /nytfiles/new
  # GET /nytfiles/new.json
  def new
    @nytfile = Nytfile.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @nytfile }
    end
  end

  # GET /nytfiles/1/edit
  def edit
    @nytfile = Nytfile.find(params[:id])
  end

  # POST /nytfiles
  # POST /nytfiles.json
  def create
    @nytfile = Nytfile.new(params[:nytfile])

    respond_to do |format|
      if @nytfile.save
        format.html { redirect_to @nytfile, notice: 'Nytfile was successfully created.' }
        format.json { render json: @nytfile, status: :created, location: @nytfile }
      else
        format.html { render action: "new" }
        format.json { render json: @nytfile.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /nytfiles/1
  # PUT /nytfiles/1.json
  def update
    @nytfile = Nytfile.find(params[:id])

    respond_to do |format|
      if @nytfile.update_attributes(params[:nytfile])
        format.html { redirect_to @nytfile, notice: 'Nytfile was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @nytfile.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /nytfiles/1
  # DELETE /nytfiles/1.json
  def destroy
    @nytfile = Nytfile.find(params[:id])
    @nytfile.destroy

    respond_to do |format|
      format.html { redirect_to nytfiles_url }
      format.json { head :no_content }
    end
  end
end
