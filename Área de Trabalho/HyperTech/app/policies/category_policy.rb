class CategoryPolicy < ApplicationPolicy
  class Scope < Scope
    # NOTE: Be explicit about which records you allow access to!
    def resolve
      if user.has_role?(:admin)
      scope.all
      else
        raise Pundit::NotAuthorizedError
      end
    end
  end

  def index?

    user&.has_role?(:admin)

  end

  def show?

    user&.has_role?(:admin)

  end

  def create?

    user&.has_role?(:admin)

  end

  def update?

    user&.has_role?(:admin)

  end

  def destroy?

    user&.has_role?(:admin)

  end
end
