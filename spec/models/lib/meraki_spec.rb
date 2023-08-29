require 'rails_helper'

describe Meraki do
  it 'should produce a authorization url from parameters' do
    auth_url =  Meraki.authorization_url meraki_params
    expect(auth_url).to eq valid_meraki_authorization_url
  end
end
