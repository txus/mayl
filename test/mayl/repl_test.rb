require 'test_helper'

module Mayl
  describe Repl do
    before do
      @repl = Mayl::Repl.new('test/support')
    end

    it 'parses and executes commands' do
      @foo = stub
      @foo.expects(:execute)
      @baz = stub
      @baz.expects(:execute)

      $stdin.expects(:gets).times(3).returns("foo bar\n", "baz lol\n", nil)

      @repl.parser.expects(:parse).with('foo bar').returns @foo
      @repl.parser.expects(:parse).with('baz lol').returns @baz

      @repl.start
    end
  end
end

