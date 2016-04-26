class Teacher::TipsController < Teacher::DashboardController
  include FindModels

  before_action :find_tip, except: [:new, :create]
  before_action :find_question, only: [:new, :create]

  def new
    @tip = @question.tips.new
  end

  def create
    @tip = @question.tips.new(tips_params)
    if @tip.save
      redirect_to teacher_lo_exercise_path(@lo, @exercise)
    else
      flash.now[:error] = "Existem dados incorretos."
      render :new
    end
  end

  def update
    if @tip.update(tips_params)
      redirect_to teacher_lo_exercise_path(@lo, @exercise)
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
      params.require(:tip).permit(:content)
    end

    def find_tip
      find_question
      @tip = @question.tips.find(params[:id])
    end
end
