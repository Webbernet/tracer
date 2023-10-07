module Tracer
  class AuditLog < ApplicationRecord
    belongs_to :auditable, polymorphic: true
    belongs_to :user, polymorphic: true, optional: true
  end
end
