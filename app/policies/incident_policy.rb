class IncidentPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def create?
    record.flat.rentals.last.user == user
  end
end
