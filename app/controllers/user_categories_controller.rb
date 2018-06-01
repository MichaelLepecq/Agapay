class UserCategoriesController < ApplicationController

  def update
    @category = Category.find(params[:id])
    if current_user.has_category_as_preference(@category)
      UserCategory.find_by(user: current_user, category: @category).destroy
    else
      @user_category = UserCategory.new
      @user_category.category = @category
      @user_category.user = current_user
      @user_category.save
    end
  end
end
