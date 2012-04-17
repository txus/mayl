require 'test_helper'

module Mayl
  describe Locale do
    before do
      hash = { 'ca' => { 'activerecord' => { 'models' => { 'post' => 'Article' } } } }
      @locale = Locale.new('some/ca.yml', hash)
    end

    it 'gets a key' do
      @locale.get('activerecord.models.post').must_equal 'Article'
    end

    it 'sets and retrieves a given key' do
      @locale.set('activerecord.models.comment', 'Comentari')
      @locale.get('activerecord.models.comment').must_equal 'Comentari'
    end

    describe '#commit' do
      it 'does not commit if there are no changes' do
        @locale.commit.must_equal false
      end
    end

    it 'saves changes to disk' do
      @locale.set('activerecord.whatever', 'foo')
      YAML.expects(:dump).with({
        'ca' => {
          'activerecord' => {
            'models' => {
              'post' => 'Article'
            },

            'whatever' => 'foo'
          }
        }
      }).returns dumped_contents = stub

      File.expects(:open).with('some/ca.yml', 'w').yields file = stub
      file.expects(:write).with dumped_contents

      @locale.commit
    end
  end
end
