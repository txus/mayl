require 'test_helper'

module Mayl
  describe Env do
    before do
      @locales = [stub, stub]
      Loader.expects(:load).with('my/path').returns @locales
      @env = Mayl::Env.new('my/path')
    end

    it 'is a container for locales' do
      @env.locales.must_equal @locales
    end

    it 'commits changes to disk' do
      @locales.each do |locale|
        locale.expects(:commit)
      end

      @env.commit
    end
  end
end

