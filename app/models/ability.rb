class Ability
  include CanCan::Ability

  def initialize(user)
    return unless user  
    case user.role.to_sym
    when :super_admin
      can :manage, :all
    when :manager
      can :read, Client
      can :assign_supervisor, Client
      cannot :read, Document
    when :supervisor
      can :read, Client, assigned_to_id: user.id
      can :assign_data_entry, Client, assigned_to_id: user.id
      cannot :upload, Document
    when :data_entry_operator
      can :read, Client, assigned_to_id: user.id
      can :update, Document, client: { assigned_to_id: user.id }
    when :client
      can :create, Document
      can :read, Document, client_id: user.id
    end
  end
end
