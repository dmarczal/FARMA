class Teacher::TipsController < Teacher::ApplicationController
  include FindModels

  before_action :find_tip, except: [:new, :create]
  before_action :find_question, only: [:new, :create]

  def show
    @tips = @question.tips_to_show(tips_count: cookies["count_responses_#{@question.id}"].to_i)
    @tip = @question.tips.find params[:id]
  end

  def new
    @tip = @question.tips.new
    @title_form = "Nova Dica"
  end

  def create
    @tip = @question.tips.new(tips_params)
    if @tip.save
      flash.now[:notice] = "Dica criada."
    else
      flash.now[:error] = "Existem dados incorretos."
      render :new
    end
  end

  def edit
    @title_form = "Editar Dica"
  end

  def update
    if @tip.update(tips_params)
      flash.now[:notice] = "Dica editada."
    else
      flash.now[:error] = "Existem dados incorretos."
      render :edit
    end
  end

  def destroy
    @tip.destroy

    redirect_to teacher_lo_exercise_path(@lo, @exercise)
  end

  private
    def tips_params
      params.require(:tip).permit(:content, :number_of_tries)
    end

    def find_tip
      find_question
      @tip = @question.tips.find(params[:id])
    end
end
