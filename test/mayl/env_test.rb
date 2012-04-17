require 'test_helper'

module Mayl
  describe Env do
    it 'is a container for locales' do
      Loader.expects(:load).with('my/path').returns [1,2]
      @env = Mayl::Env.new('my/path')
      @env.locales.must_equal [1,2]
    end
  end
end

