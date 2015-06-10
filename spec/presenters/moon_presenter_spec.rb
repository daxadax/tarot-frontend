require 'spec_helper'

class MoonPresenterSpec < TarotSpec
  let(:options) do
    {
      :phase => phase,
      :illumination => illumination,
      :is_waxing => is_waxing,
      :is_waning => is_waning,
      :active_elements => active_elements
    }
  end
  let(:moon) { OpenStruct.new(options) }
  let(:phase) { :new }
  let(:active_elements) { [:earth] }
  let(:illumination) { 0 }
  let(:is_waxing) { false }
  let(:is_waning) { false }
  
  let(:presenter) { MoonPresenter.new(moon) }

  it 'gives access to phase' do 
    assert_equal phase, presenter.phase 
  end

  it 'gives access to active elements' do
    assert_equal active_elements, presenter.active_elements
  end

  it 'gives access to percent_illuminated' do 
    assert_equal illumination * 100, presenter.percent_illuminated
  end

  it 'gives access to is_waxing' do 
    assert_equal is_waxing, presenter.waxing?
  end

  it 'gives access to is_waning' do 
    assert_equal is_waning, presenter.waning?
  end

  describe 'image_path' do 
    it 'returns the correct image path' do
      assert_equal '/images/luna/0.png', presenter.image_path
    end

    describe '23% waxing'do
      let(:phase) { :crescent }
      let(:illumination) { 0.23 }
      let(:is_waxing) { true }
    
      it 'returns the correct image path' do
        assert_equal '/images/luna/3.png', presenter.image_path
      end
    end

    describe '23% waning' do
      let(:phase) { :balsamic }
      let(:illumination) { 0.23 }
      let(:is_waning) { true }
    
      it 'returns the correct image path' do 
        assert_equal '/images/luna/24.png', presenter.image_path
      end
    end
  end
end
