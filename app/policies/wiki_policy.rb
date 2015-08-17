class WikiPolicy < ApplicationPolicy
  
  def index?
    false
  end

  def show?
    record.public? || user.present?
  end

  def create?
    show?
  end

  def new?
    show?
  end

  def update?
    show?
  end

  def edit?
    show?
  end

  def destroy?
    user.admin? or user.premium?
  end

  class Scope
    attr_reader :user, :scope # :wiki,

    def initialize(user, scope) # wiki,
      @user = user
      # @wiki = wiki
      @scope = scope
    end

    def resolve
       wikis = []
       if user.role == 'admin'
         wikis = scope.all # if the user is an admin, show them all the wikis
       elsif user.role == 'premium'
         all_wikis = scope.all
         all_wikis.each do |wiki|
           if wiki || wiki.user == user || wiki.collaborated_users.include?(user) # || wiki.public? 
             wikis << wiki # if the user is premium, only show them public wikis, or that private wikis they created, or private wikis they are a collaborator on
           end
         end
       else # this is the lowly standard user
         all_wikis = scope.all
         all_wikis.each do |wiki|
           if wiki.public? || wiki.collaborated_users.include?(user)
             wikis << wiki # only show standard users public wikis and private wikis they are a collaborator on
           end
         end
       end
       wikis # return the wikis array we've built up
     end
   end

    # def resolve
    #   if user.role == 'admin' or user.role == 'premium'
    #     scope.all
    #   else 
    #     scope.where(:public => true)
    #   end
    # end
end