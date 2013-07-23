class OfferChainsController < ApplicationController
  # GET /offer_chains
  # GET /offer_chains.json
  def index
    @offer_chains = OfferChain.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @offer_chains }
    end
  end

  # GET /offer_chains/1
  # GET /offer_chains/1.json
  def show
    @offer_chain = OfferChain.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @offer_chain }
    end
  end

  # GET /offer_chains/new
  # GET /offer_chains/new.json
  def new
    @offer_chain = OfferChain.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @offer_chain }
    end
  end

  # GET /offer_chains/1/edit
  def edit
    @offer_chain = OfferChain.find(params[:id])
  end

  # POST /offer_chains
  # POST /offer_chains.json
  def create
    @offer_chain = OfferChain.new(params[:offer_chain])

    respond_to do |format|
      if @offer_chain.save
        format.html { redirect_to @offer_chain, notice: 'Offer chain was successfully created.' }
        format.json { render json: @offer_chain, status: :created, location: @offer_chain }
      else
        format.html { render action: "new" }
        format.json { render json: @offer_chain.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /offer_chains/1
  # PUT /offer_chains/1.json
  def update
    @offer_chain = OfferChain.find(params[:id])

    respond_to do |format|
      if @offer_chain.update_attributes(params[:offer_chain])
        format.html { redirect_to @offer_chain, notice: 'Offer chain was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @offer_chain.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /offer_chains/1
  # DELETE /offer_chains/1.json
  def destroy
    @offer_chain = OfferChain.find(params[:id])
    @offer_chain.destroy

    respond_to do |format|
      format.html { redirect_to offer_chains_url }
      format.json { head :no_content }
    end
  end
end
