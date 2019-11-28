class IncidentPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def new?
    true
  end

  def create?
    true
    # record.flat.rentals.last.user == user
  end
end
