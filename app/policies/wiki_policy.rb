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
end