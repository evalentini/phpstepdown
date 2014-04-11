class DropreasonsController < ApplicationController
  # GET /dropreasons
  # GET /dropreasons.json
  def index
    @curpg = :admintools
    @dropreasons = Dropreason.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @dropreasons }
    end
  end

  # GET /dropreasons/1
  # GET /dropreasons/1.json
  def show
    @curpg = :admintools
    @dropreason = Dropreason.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @dropreason }
    end
  end

  # GET /dropreasons/new
  # GET /dropreasons/new.json
  def new
    @curpg = :admintools
    @dropreason = Dropreason.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @dropreason }
    end
  end

  # GET /dropreasons/1/edit
  def edit
    @curpg = :admintools
    @dropreason = Dropreason.find(params[:id])
  end

  # POST /dropreasons
  # POST /dropreasons.json
  def create
    @curpg = :admintools
    @dropreason = Dropreason.new(params[:dropreason])

    respond_to do |format|
      if @dropreason.save
        format.html { redirect_to :action => "index" }
        format.json { render json: @dropreason, status: :created, location: @dropreason }
      else
        format.html { render action: "new" }
        format.json { render json: @dropreason.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /dropreasons/1
  # PUT /dropreasons/1.json
  def update
    @curpg = :admintools
    @dropreason = Dropreason.find(params[:id])

    respond_to do |format|
      if @dropreason.update_attributes(params[:dropreason])
        format.html { redirect_to :action => "index" }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @dropreason.errors, status: :unprocessable_entity }
      end
    end
  end
  
  
  def hide
    @curpg = :admintools
    @dropreason = Dropreason.find(params[:id])
    @dropreason.update_attributes(:ishidden=>true)
    redirect_to :controller => "dropreasons", :action => "index"
  end
  
  def unhide
    @curpg = :admintools
    @dropreason = Dropreason.find(params[:id])
    @dropreason.update_attributes(:ishidden=>false)
    redirect_to :controller => "dropreasons", :action => "index"
  end

  # DELETE /dropreasons/1
  # DELETE /dropreasons/1.json
  def destroy
 #   @dropreason = Dropreason.find(params[:id])
 #   @dropreason.destroy
 #
 #   respond_to do |format|
 #     format.html { redirect_to dropreasons_url }
 #    format.json { head :no_content }
 #   end
  end
end
