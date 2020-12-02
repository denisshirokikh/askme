class UsersController < ApplicationController

  def show
    @time = Time.now
    @hello = "Пока, лунатикам!"
  end

end
