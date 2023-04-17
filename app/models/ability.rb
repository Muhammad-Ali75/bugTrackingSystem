# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    user ||=User.new
    # Manager
    if user.user_type == "0"
      can [:read, :edit, :destroy], Project, user_id: user.id
      can [:create], Project
    end

    # QA
    if user.user_type == "1"
      can [:read], Project, user_projects: { user_id: user.id }
      can [:create], Ticket, project: { user_projects: { user_id: user.id } }
      can [:edit, :destroy], Ticket, user_id: user.id
    end

    # Developer
    if user.user_type == "2"
      can [:read], Project, user_projects: { user_id: user.id }
      can [:read], Ticket, project: { user_projects: { user_id: user.id } }
      can [:edit], Ticket, developer_id: user.id
    end

  end
end
