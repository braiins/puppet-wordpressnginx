require 'spec_helper'
describe 'wordpressnginx' do

  context 'with defaults for all parameters' do
    it { should contain_class('wordpressnginx') }
  end
end
