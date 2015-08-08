class Wiki < ActiveRecord::Base
  belongs_to :user
  before_create :default_wiki_public
  
  scope :public_visible_to, -> (wiki) { wiki ? all : where(public: true) }
  scope :private_visible_to, -> (wiki) { wiki ? all : where(public: false) }

  def default_wiki_public
    self.public ||= true
  end
end
