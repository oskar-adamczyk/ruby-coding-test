# frozen_string_literal: true

class BeValidIncludingDatabase < RSpec::Rails::Matchers::BeValid
  def matches?(actual)
    super(actual) && valid_on_database?
  end

  private

  def valid_on_database?
    @actual.save validate: false
  rescue ActiveRecord::StatementInvalid
    false
  end
end

def be_valid_including_database(*args)
  BeValidIncludingDatabase.new(*args)
end
