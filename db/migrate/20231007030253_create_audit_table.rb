class CreateAuditTable < ActiveRecord::Migration[7.0]
  def change
    create_table :tracer_audit_logs do |t|
      t.references :user, polymorphic: true, index: true, null: true
      t.references :auditable, polymorphic: true, index: true
      t.boolean :system_event, default: false, null: false
      t.string :event_name
      t.jsonb :metadata, default: {}
      t.timestamps
    end
  end
end
