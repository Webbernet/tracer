module Tracer
  class Recorder
    def self.call(*args)
      new(*args).send(:log_event)
    end

    def initialize(
      model:, event_name:, metadata: {}, trigger_user: nil, system_event: false
    )
      @model = model
      @event_name = event_name
      @metadata = metadata
      @user = trigger_user
      @system_event = system_event
      @model_name = model.class.name
    end

    def log_event
      validate_user_and_system_event!
      validate_event!
      create_log
      send_notify
    end

    private

    def validate_user_and_system_event!
      if @user.nil? && !@system_event
        raise "Validation Error: If there's no user provided, system_event must be set to true"
      end

      if @system_event && !@user.nil?
        raise 'Validation Error: If user is provided, system event must be false'
      end
    end

    def validate_event!
      unless Tracer.configuration.events.dig(@model_name, @event_name)
        raise "Invalid event '#{@event_name}' for model '#{@model_name}'"
      end
    end

    def create_log
      AuditLog.create!(
        user: @user,
        auditable: @model,
        event_name: @event_name,
        metadata: @metadata,
        system_event: @system_event
      )
    end

    def send_notify
      description =
        Tracer.configuration.events.dig(@model_name, @event_name, 'description')
      auditable_type = @model.class.to_s
      notifications =
        AuditNotification.where(
          event_name: @event_name, auditable_type: auditable_type
        )
      notifications.each do |notification|
        handler_class = Tracer.configuration.notification_handler.constantize
        handler_class.call(
          notification_payload(notification.email_address, description)
        )
      end
    end

    private

    def notification_payload(email_address, description)
      {
        email_address: email_address,
        model: @model,
        metadata: @metadata,
        trigger_user: @user,
        event_name: @event_name,
        description: description
      }
    end
  end
end
