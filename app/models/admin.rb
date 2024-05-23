class Admin < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :omniauthable, omniauth_providers: %i[github]

  def self.from_omniauth(auth)
    Admin.where(email: auth.info.email).first
  end
end
