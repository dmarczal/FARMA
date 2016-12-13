class Admin::ResearchesController < ApplicationController
  before_action :set_admin_research, only: [:show, :edit, :update, :destroy]

  layout 'layouts/admin/application'

  # GET /admin/researches
  # GET /admin/researches.json
  def index
    @admin_researches = Admin::Research.all
  end

  # GET /admin/researches/1
  # GET /admin/researches/1.json
  def show
  end

  # GET /admin/researches/new
  def new
    @admin_research = Admin::Research.new
  end

  # GET /admin/researches/1/edit
  def edit
  end

  # POST /admin/researches
  # POST /admin/researches.json
  def create
    @admin_research = Admin::Research.new(admin_research_params)

    respond_to do |format|
      if @admin_research.save
        format.html { redirect_to @admin_research, notice: 'Research was successfully created.' }
        format.json { render :show, status: :created, location: @admin_research }
      else
        format.html { render :new }
        format.json { render json: @admin_research.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/researches/1
  # PATCH/PUT /admin/researches/1.json
  def update
    respond_to do |format|
      if @admin_research.update(admin_research_params)
        format.html { redirect_to @admin_research, notice: 'Research was successfully updated.' }
        format.json { render :show, status: :ok, location: @admin_research }
      else
        format.html { render :edit }
        format.json { render json: @admin_research.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/researches/1
  # DELETE /admin/researches/1.json
  def destroy
    @admin_research.destroy
    respond_to do |format|
      format.html { redirect_to admin_researches_url, notice: 'Research was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin_research
      @admin_research = Admin::Research.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def admin_research_params
      params.require(:admin_research).permit(:title, :ref, :abstract, :link, :kind)
    end
end
