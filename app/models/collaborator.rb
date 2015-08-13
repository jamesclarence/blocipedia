class Collaborator < ActiveRecord::Base
  belongs_to :wikis
  belongs_to :users
  # accepts_nested_attributes_for :wikis, :users
end
