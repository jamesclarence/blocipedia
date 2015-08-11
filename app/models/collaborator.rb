class Collaborator < ActiveRecord::Base
  belongs_to :wikis
  belongs_to :users
end
