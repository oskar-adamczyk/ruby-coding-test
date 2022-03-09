# frozen_string_literal: true

class BeInvalidIncludingDatabase < RSpec::Rails::Matchers::BeValid
  def matches?(actual)
    !super(actual) && invalid_on_database?
  end

  private

  def invalid_on_database?
    !@actual.save(validate: false)
  rescue ActiveRecord::StatementInvalid
    true
  end
end

def be_invalid_including_database(*args)
  BeInvalidIncludingDatabase.new(*args)
end
