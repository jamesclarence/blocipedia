class Wiki < ActiveRecord::Base
  belongs_to :users
  has_many :collaborators
  has_many :users, through: :collaborators
  before_create :default_wiki_public
  
  default_scope { order(title: :asc) }
  # scope :ordered, { order(created_at: :desc) }

  def default_wiki_public
    if self.public.nil?
      self.public = true
    end
  end
end
