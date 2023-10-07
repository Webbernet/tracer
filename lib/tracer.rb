require 'tracer/version'
require 'tracer/engine'

module Tracer
  class << self
    attr_writer :configuration

    def configuration
      @configuration ||= Configuration.new
    end

    def configure
      yield(configuration)
    end
  end
end
