class WorkoutTemplatePolicy < ApplicationPolicy
  class Scope
    attr_reader :user, :scope

    def initialize(user, scope)
      @user = user
      @scope = scope
    end

    def resolve
      return scope.none if user.blank?

      scope.where(user:)
    end
  end

  def index?
    user.present?
  end

  def show?
    owns_record?
  end

  def new?
    create?
  end

  def create?
    user.present?
  end

  def edit?
    update?
  end

  def update?
    owns_record?
  end

  def destroy?
    owns_record?
  end

  private

  def owns_record?
    user.present? && record.user_id == user.id
  end
end
