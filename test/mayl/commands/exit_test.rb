require 'test_helper'

module Mayl
  module Commands
    describe Exit do
      before do
        @command = Exit.new(stub)
      end

      it 'exits the program' do
        @command.expects(:exit).with(0)
        @command.execute
      end
    end
  end
end
