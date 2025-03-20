require "rails_helper"

RSpec.describe TbCore do
  it 'has a version number' do
    expect(TbCore::VERSION).to be_present
    puts "Database: #{ENV['PG_TEST_DATABASE']}"
  end
end
