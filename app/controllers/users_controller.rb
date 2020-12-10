class UsersController < ApplicationController

  before_action :load_user, except: [:index, :create, :new]

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      redirect_to root_url, notice: 'Пользователь успешно зарегистрирован!'
    else
      render 'new'
    end
  end

  def update
    @user = User.find params[:id]

    if @user.update
      redirect_to user_path(@user), notice: 'Данные обновлены!'
    else
      render 'edit'
    end
  end

  def edit
  end

  def show
    @questions = @user.questions.order(created_at: :desc)

    # @questions_count = @questions.size
    # @pending = @questions.map(&:answer).count(nil)
    # @answered = @questions_count - @pending


    @new_question = @user.questions.build
  end

  private
  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation,
                                  :name, :username, :avatar_url)
  end

  def load_user
    @user ||= User.find params[:id]
  end
end
