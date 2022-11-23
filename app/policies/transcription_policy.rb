class TranscriptionPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      # Need to test current person etc ...
      # only admin gets to see all
      scope.all
    end
  end
end
