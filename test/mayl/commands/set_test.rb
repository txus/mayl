require 'test_helper'

module Mayl
  module Commands
    describe Set do
      before do
        @locales = [stub(to_s: 'ca'), stub(to_s: 'en')]
        @env     = stub locales: @locales, namespace: 'activerecord'
        @command = Set.new @env, 'models.post'
      end

      it 'lets the user enter a value for the key in each of the locales' do
        @command.expects(:gets).twice.returns('Article', 'Post') # User interaction

        @locales.first.expects(:set).with('activerecord.models.post', 'Article')
        @locales.last.expects(:set).with('activerecord.models.post', 'Post')

        @command.execute 
      end
    end
  end
end
