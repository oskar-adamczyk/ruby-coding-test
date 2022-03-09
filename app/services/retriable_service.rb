# frozen_string_literal: true

class RetriableService
  DEFAULT_MAX_RETRIES = 10

  def initialize(params)
    @params = params
  end

  def self.call(params)
    new(params).call
  end

  def call
    ApplicationRecord.transaction isolation: :serializable do
      perform
    end
  rescue ActiveRecord::SerializationFailure => e
    Rails.logger.warn "SerializationFailure"

    raise_serialization_failure! e if max_retries_reached?

    @retry_attempt ||= 0
    @retry_attempt += 1

    sleep(rand / 100)
    retry
  end

  private

  attr_reader :params

  def max_retries
    DEFAULT_MAX_RETRIES
  end

  def max_retries_reached?
    @retry_attempt == max_retries
  end

  # :nocov:
  def perform
    raise NotImplementedError
  end
  # :nocov:

  def raise_serialization_failure!(error)
    @retry_attempt = nil
    raise error
  end
end
