class TopicPolicy < ApplicationPolicy
  def update?
    user.present? && (user.admin?)
  end

  def edit?
    update?
  end

  def destroy?
    update?
  end
end