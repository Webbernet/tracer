module Tracer
  class Configuration
    attr_accessor :events, :notification_handler

    def initialize
      @events = {}
      @notification_handler = nil
    end

    def load_yml(file_path)
      if File.exist?(file_path)
        yaml_content = YAML.load_file(file_path)
        @events = yaml_content['events'] || {}
      else
        raise "YAML configuration file not found at #{file_path}"
      end
    end
  end
end
