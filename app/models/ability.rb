class Ability
  include CanCan::Ability
  #defines what a user can or can not access/modify
  def initialize(user)
    can :manage, User
    can :manage, Transcription
    can :manage, FieldGroup
    can :manage, Page
    can :manage, Annotation
    can :manage, PageType
    can :manage, Field
    can :manage, Ledger
  end
end
