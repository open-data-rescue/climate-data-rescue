class Blog::PostPolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    return true if @user.admin?

    false
  end

  def update?
    return true if @user.admin?

    false
  end

  def destroy?
    return true if @user.admin?

    false
  end

  class Scope < Scope
    def resolve
      Rails.logger.debug "*********** POST SCOPE"
      scope.all
    end
  end
end
