# encoding: utf-8
require 'test_helper'

module Mayl
  module Commands
    describe Edit do
      before do
        @locales = [stub(name: 'ca'), stub(name: 'en')]
        @env     = stub locales: @locales, namespace: '', last_value: 'activerecord.models.post'
        @command = Edit.new @env, 'en', 'Entry'
      end

      it 'edits the last key getted or setted' do
        @locales.last.expects(:set).with('activerecord.models.post', 'Entry')
        @command.execute
      end
    end
  end
end
