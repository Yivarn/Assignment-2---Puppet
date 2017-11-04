require 'spec_helper'
describe 'packages' do
  context 'with default values for all parameters' do
    it { should contain_class('packages') }
  end
end
