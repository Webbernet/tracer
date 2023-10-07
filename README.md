# Tracer: Model Event Auditing with Notifications

`Tracer` is a Rails engine designed to log significant events related to your models and offers the added capability of sending notifications for these events.

## Installation

1. **Add the gem to your application's Gemfile**:

    ```ruby
    gem 'tracer', path: 'path/to/local/gem'
    ```

2. **Install the gem**:

    ```bash
    bundle install
    ```

3. **Run the migrations**:

    ```bash
    rails tracer:install:migrations
    ```

4. **Migrate the database**:

    ```bash
    rails db:migrate
    ```

5. **Setup Configuration**: Create an initializer in `config/initializers/tracer.rb`:

    ```ruby
    Tracer.configure do |config|
        config.events =
            YAML.load_file(Rails.root.join('config', 'tracer_events.yml'))
        config.notification_handler = 'YourNotificationHandlerClass'
    end
    ```

    Here, `YourNotificationHandlerClass` should be a class in your main application responsible for sending notifications. This class must implement a `.call` method.

## Configuration

-   **Events & Descriptions**: Define these in a YML file, for instance, `config/tracer_events.yml`:

    ```yaml
    ModelName:
        event_name:
            description: "Description of the event."
    ```

    Example:

    ```yaml
    User:
        account_created:
            description: "A new user account was created."
    ```

## Usage

To log an event related to a specific model, use the `Tracer::Trace` service:

```ruby
Tracer::Recorder.call(
    model: @user,
    event_name: 'account_created',
    metadata: { additional_info: 'Some data' },
    trigger_user: current_user
)
```

Upon calling this service, the event gets logged. If there are registered notifications for this event, it will be passed to the `notification_handler` class for further processing.

## Notifications

1. **Setup your `Notification` entries**:

    Register which events should notify specific email addresses. For instance, to notify `admin@example.com` when a `User` has an `account_created` event:

    ```ruby
    Tracer::AuditNotification.create(
        auditable_type: 'User',
        event_name: 'account_created',
        email_address: 'admin@example.com'
    )
    ```

2. **Implement your `notification_handler` class**:

    This class is responsible for handling and dispatching the notifications. It must have a `.call` method:

    ```ruby
    class YourNotificationHandlerClass
        def self.call(
            email, model, metadata, user, event_name, description
        ); end
    end
    ```

    The method provides all the details necessary for sending a comprehensive notification. How you format and send the notification is up to your implementation.
