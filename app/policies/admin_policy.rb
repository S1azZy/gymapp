class AdminPolicy < ApplicationPolicy
  def access?
    user&.admin? || false
  end
end
