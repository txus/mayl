require 'test_helper'

module Mayl
  describe Env do
    before do
      @locales = [stub(peek: [:baz]), stub(peek: [:bar])]
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

    it 'peeks in the locales' do
      @env.peek.must_equal [:baz, :bar]
    end

    it 'autocompletes from a key' do
      @env.autocomplete('ba').must_equal [:baz, :bar]
    end
  end
end

