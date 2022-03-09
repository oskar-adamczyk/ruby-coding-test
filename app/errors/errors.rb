# frozen_string_literal: true

module Errors
  class BaseError < StandardError; end

  class NotFound < BaseError; end

  class UnprocessableEntity < BaseError
    def initialize(entity:)
      raise ArgumentError, "Entity does not contain errors" if entity.errors.empty?

      @entity = entity
      super
    end

    attr_reader :entity
  end
end
