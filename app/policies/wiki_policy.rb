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
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      if user.role == 'admin' or user.role == 'premium'
        scope.all
      else 
        scope.where(:public => true)
      end
    end
  end
end