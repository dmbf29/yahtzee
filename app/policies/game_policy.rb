class GamePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      user.games
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
end
