class Ability
  include CanCan::Ability
  #defines what a user can or can not access/modify
  def initialize(user)
    can :manage, User
    can :manage, Album
    can :manage, Photo
    can :manage, Transcription
    can :manage, Entity
    can :manage, Asset
    can :manage, Annotation
    can :manage, AssetCollection
    can :manage, Field
    can :manage, Template
    can :manage, CollectionGroup
  end
end
