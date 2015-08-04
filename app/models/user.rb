class User < ActiveRecord::Base
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :confirmable

  before_create :default_user_role_standard

  def standard?
    role == 'standard'
  end

  def premium?
    role == 'premium'
  end

  def admin?
    role == 'admin'
  end

  private

  def default_user_role_standard
    self.role ||= 'standard'
  end

  def premium_to_standard
    current_user.update_attributes(:role => 'standard')
  end
end
