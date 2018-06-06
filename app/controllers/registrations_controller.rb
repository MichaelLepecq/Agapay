class RegistrationsController < Devise::RegistrationsController

  protected

  def update_resource(resource, params)

    if params[:current_password].present?
      params.delete(:current_password)
      resource.update(params)
    else
      params.delete(:current_password)
      resource.update_without_password(params)
    end
  end
end
