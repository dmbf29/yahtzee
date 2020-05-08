class GamePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def create?
    true
  end

  def show?
    true
  end

  def order?
    true
  end

  def finish?
    record.users.include?(user)
  end

  def cursor_place?
    true
  end
end
