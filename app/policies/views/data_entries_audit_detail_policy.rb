class Views::DataEntriesAuditDetailPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      # Need to test current person etc ...
      # only admin gets to see all
      scope.where("event != 'create'")
    end
  end
end
