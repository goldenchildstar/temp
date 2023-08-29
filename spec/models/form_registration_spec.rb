require 'rails_helper'

describe FormRegistration do
  it 'should be able to persist data' do
    expect(FormRegistration).to respond_to :save
  end
end
