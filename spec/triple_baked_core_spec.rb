require "rails_helper"

RSpec.describe TripleBakedCore do
  it 'has a version number' do
    expect(TripleBakedCore::VERSION).to be_present
  end
end
