require "rails_helper"

RSpec.describe TripleBakedCore do
  it 'has a version number' do
    expect(TripleBakedCore::VERSION).to be_present
    puts "Database: #{ENV['PG_TEST_DATABASE']}"
  end
end
