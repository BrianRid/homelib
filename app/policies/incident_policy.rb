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

  def show?
    true
  end

  def update?
    true
  end
  def delete?
    true if (record.status == "En cours" || user == record.flat.rental.last.user)
  end


end
