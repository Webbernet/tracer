class CreateAuditNotifications < ActiveRecord::Migration[7.0]
  def change
    create_table :tracer_audit_notifications do |t|
      t.string :email_address, null: false
      t.string :event_name, null: false
      t.string :auditable_type, null: false

      t.timestamps
    end

    add_index :notifications, %i[email_address event_name], unique: true
    add_index :notifications, %i[auditable_type event_name], unique: true
  end
end
