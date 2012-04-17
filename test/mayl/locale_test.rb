require 'test_helper'

module Mayl
  describe Locale do
    before do
      hash = { 'ca' => { 'activerecord' => { 'models' => { 'post' => 'Article' } } } }
      @locale = Locale.new(:ca, hash)
    end

    it 'wraps a YAML hash' do
      @locale.activerecord.models.post.must_equal 'Article'
    end

    it 'sets a given key' do
      @locale.set('activerecord.models.comment', 'Comentari')
      @locale.activerecord.models.comment.must_equal 'Comentari'
    end

    it 'gets a given key' do
      @locale.get('activerecord.models.post').must_equal 'Article'
    end
  end
end
