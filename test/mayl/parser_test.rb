# encoding: utf-8
require 'test_helper'

module Mayl
  describe Parser do
    before do
      @env = stub
      @parser = Parser.new(@env)
    end

    it 'parses commands' do
      command = @parser.parse "set key"
      command.must_be_kind_of Commands::Set
      command.key.must_equal 'key'
    end
  end
end
