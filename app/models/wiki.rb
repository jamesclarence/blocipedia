class Wiki < ActiveRecord::Base
  belongs_to :user
  before_create :default_wiki_public
  
  scope :public_visible_to, -> (wiki) { wiki ? all : where(public: true) }
  scope :private_visible_to, -> (wiki) { wiki ? all : where(public: false) }

  if current_user.role == 'admin' || current_user.role == 'premium'
    wiki.public_visible_to.private_visible_to
  else
    wiki.public_visible_to
  end

  def default_wiki_public
    self.public ||= true
  end
end
