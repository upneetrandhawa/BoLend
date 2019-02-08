class WelcomeController < ApplicationController
  def index
    if logged_in?
      redirect_to items_path
    end
  end
end
