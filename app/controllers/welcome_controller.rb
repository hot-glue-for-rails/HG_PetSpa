class WelcomeController < ApplicationController
  before_action :authenticate_human!

  def index
    redirect_to dashboard_pets_path
  end
end
