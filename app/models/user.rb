class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
  :recoverable, :rememberable, :trackable, :validatable
  devise :omniauthable, omniauth_providers: %i[facebook]

  has_many :user_categories
  has_many :user_charities
  has_many :categories, through: :user_categories
  has_many :charities, through: :user_charities
  has_many :donations

  mount_uploader :photo, PhotoUploader



  #validates :first_name, presence: true
  #validates :last_name, presence: true
  def self.find_for_facebook_oauth(auth)
    user_params = auth.slice(:provider, :uid)
    user_params.merge! auth.info.slice(:email, :first_name, :last_name)
    user_params[:facebook_picture_url] = auth.info.image
    user_params[:token] = auth.credentials.token
    user_params[:token_expiry] = Time.at(auth.credentials.expires_at)
    user_params = user_params.to_h

    user = User.find_by(provider: auth.provider, uid: auth.uid)
    user ||= User.find_by(email: auth.info.email) # User did a regular sign up in the past.
    if user
      user.update(user_params)
    else

      user = User.new(user_params)
      raise
      user.password = Devise.friendly_token[0,20]  # Fake password for validation
      user.save
    end

    return user
  end


  def has_category_as_preference(category)
    self.categories.include?(category)
  end

  def photo_file_name
    self.photo.filename
  end


end
