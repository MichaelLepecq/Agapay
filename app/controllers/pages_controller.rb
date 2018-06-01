class PagesController < ApplicationController
  skip_before_action :authenticate_user!, only: [:home]
  def home
    # landing page
  end

end
