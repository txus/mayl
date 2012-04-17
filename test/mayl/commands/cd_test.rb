# encoding: utf-8
require 'test_helper'
require 'ostruct'

module Mayl
  module Commands
    describe Cd do
      before do
        @locales = [stub(to_s: 'ca'), stub(to_s: 'en')]
        @env = OpenStruct.new(locales: @locales, namespace: 'activerecord.models')
      end

      it 'enters a directory' do
        @command = Cd.new @env, 'post.attributes'
        @command.execute
        @env.namespace.must_equal 'activerecord.models.post.attributes'
      end

      it 'goes down one level' do
        @command = Cd.new @env, '..'
        @command.execute
        @env.namespace.must_equal 'activerecord'
      end

      it 'goes to the root level' do
        @command = Cd.new @env, '.'
        @command.execute
        @env.namespace.must_equal ''
      end
    end
  end
end
