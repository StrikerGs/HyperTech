class ProductPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
     def resolve
      if user.has_role?(:vendedor)
       scope.all
      else
        raise Pundit::NotAuthorizedError
      end
     end
  end
  
  def index?

    user&.has_role?(:vendedor) || user&.has_role?(:admin)

  end

  def show?
    true
  end

  def create?

    user&.has_role?(:vendedor)

  end

  def update?
    user&.id == record.user.id
  end

  def destroy?
    user&.id == record.user.id || user&.has_role?(:admin)
  end
end
