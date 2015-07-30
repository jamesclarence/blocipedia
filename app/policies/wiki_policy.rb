class WikiPolicy < ApplicationPolicy
  def destroy?
    user.admin? || user.premium?
  end
end