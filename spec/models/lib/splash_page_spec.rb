require 'rails_helper'

describe SplashPage do
  it 'should create a template from parameters' do
    index_template = SplashPage.template wifi_params
    expect(index_template).to eq "#{SplashPage.path_prefix}ividata/index"
  end

  it 'should create a template from parameters with a page' do
    index_template = SplashPage.template wifi_params.merge(page: 'test_page')
    expect(index_template).to eq "#{SplashPage.path_prefix}ividata/test_page"
  end
end
