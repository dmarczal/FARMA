# frozen_string_literal: true

# your comment
class Admin::ResearchesController < Admin::AdminApplicationController
  def index
    @researches = Admin::Research.order :title
  end

  def new
    @research = Admin::Research.new
  end

  def create
    @research = Admin::Research.new(research_params)
    if @research.save
      redirect_to admin_researches_path, flash: { success:
        'Pesquisa criada com sucesso.' }
    else
      flash.now[:error] = 'Existem dados incorretos.'
      render :new
    end
  end

  def edit
    @research = Admin::Research.find(params[:id])
  end

  def destroy
    @research = Admin::Research.find(params[:id])
    @research.destroy
    redirect_to admin_researches_path, flash: { success:
      'Pesquisa removida com sucesso.' }
  end

  def update
    @research = Admin::Research.find(params[:id])
    if @research.update_attributes(research_params)
      redirect_to admin_research_path, flash: { success:
        'Pesquisa atualizada com sucesso.' }
    else
      flash.now[:error] = 'Existem dados incorretos.'
      render :edit
    end
  end

  def show
    @research = Admin::Research.find(params[:id])
  end

  private

  def research_params
    strip_params params.require(:admin_research).permit(
      :title,
      :ref,
      :abstract,
      :link,
      :research_category_id
    )
  end
end
