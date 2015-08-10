class User < ActiveRecord::Base
  
  has_many :wikis, dependent: :update
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


end
