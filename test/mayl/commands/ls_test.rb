# encoding: utf-8
require 'test_helper'

module Mayl
  module Commands
    describe Ls do
      before do
        @locales = [stub(to_s: 'ca'), stub(to_s: 'en')]
        @env     = stub locales: @locales, namespace: 'activerecord'
        @command = Ls.new @env
      end

      it 'prints the current keys inside the namespace' do
        @env.expects(:peek).returns ['models', 'attributes']

        @command.expects(:print).with('models ')
        @command.expects(:print).with('attributes ')

        @command.execute
      end
    end
  end
end
