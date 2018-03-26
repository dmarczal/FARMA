class Admin::ResearchesController < Admin::AdminApplicationController

  def index
    @researches = Admin::Research.all
  end

  def new
    @research = Admin::Research.new
  end

  def create
    @research = Admin::Research.new(research_params)
    if @research.save
      redirect_to admin_research_path, flash: { success: ' Pesquisa criada com sucesso.' }
    else
      flash.now[:error] = 'Existem dados incorretos.'
      render :new
    end
  end

  private

  def research_params
    strip_params params.require(:admin_research).permit(:title, :ref, :abstract, :link, :kind)
  end
end
