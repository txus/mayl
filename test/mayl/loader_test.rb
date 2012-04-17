require 'test_helper'

module Mayl
  describe Loader do
    it 'loads YAML files inside a path' do
      locales = Loader.load('test/support')
      locales.map(&:name).sort.must_equal [:ca, :en, :es]
    end
  end
end
