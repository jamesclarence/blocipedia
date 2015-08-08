class WikiPolicy < ApplicationPolicy
  
  def index?
    false
  end

  def create?
    user.present?
  end

  def new?
    user.present?
  end

  def update?
    false
  end

  def edit?
    user.present?
  end

  def destroy?
    false
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