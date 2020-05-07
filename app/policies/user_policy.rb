class UserPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def update?
    record == user
  end

  def big_boys?
    true
  end

  def impersonate?
    user.admin
  end

  def stop_impersonating?
    user.admin
  end
end
