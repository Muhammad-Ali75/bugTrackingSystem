# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new
    # Manager
    if user.user_type == 'manager'
      can %i[read edit destroy], Project, user_id: user.id
      can [:create], Project
      can [:read], Ticket

    end

    # QA
    if user.user_type == 'QA'
      can [:read], Project, user_projects: { user_id: user.id }
      can [:create], Ticket
      can %i[read edit destroy], Ticket, user_id: user.id
    end

    # Developer
    return unless user.user_type == 'Developer'

    can [:read], Project, user_projects: { user_id: user.id }
    can [:read], Ticket, project: { user_projects: { user_id: user.id } }
    can [:edit], Ticket do |ticket|
      ticket.developer.nil? || ticket.developer_id == user.id
    end
  end
end
