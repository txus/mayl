# encoding: utf-8
require 'test_helper'

module Mayl
  module Commands
    describe Get do
      before do
        @locales = [stub(to_s: 'ca'), stub(to_s: 'en')]
        @env     = stub locales: @locales, namespace: 'activerecord'
        @command = Get.new @env, 'models.post'
      end

      it 'shows the user the values for a key in each locale' do
        @locales.first.expects(:get).with('activerecord.models.post').returns('Article')
        @locales.last.expects(:get).with('activerecord.models.post').returns('Post')

        @command.expects(:print).with("  ca: Article\n")
        @command.expects(:print).with("  en: Post\n")

        @command.execute 
      end
    end
  end
end
