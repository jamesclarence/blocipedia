class Wiki < ActiveRecord::Base
  belongs_to :user
  before_create :default_wiki_public
  after_update if: :private_to_public_wiki?
  
  scope :public_visible_to, -> (wiki) { wiki ? all : where(public: true) }
  scope :private_visible_to, -> (wiki) { wiki ? all : where(public: false) }
  
  # When a Private User downgrades to Standard, private wikis associated with that User 
  # change to public 
  def private_to_public_wiki
    wiki.update_attributes(public: true)
  end

  def default_wiki_public
    self.public ||= true
  end
end
