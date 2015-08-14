class User < ActiveRecord::Base
  
  has_many :wikis, through: :collaborators
  has_many :collaborators
  after_update :publicize_wikis_if_standard
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

  def publicize_wikis_if_standard
    if standard?
      wikis.each do |wiki|
        wiki.public = true
        wiki.save
      end
    end
  end
  
  private

  def default_user_role_standard
    self.role ||= 'standard'
  end


end
