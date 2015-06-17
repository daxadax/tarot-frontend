require 'spec_helper'

class PlanetaryInfluencePresenterSpec < TarotSpec
  let(:options) do 
    {
      :ruling_planets => [:sol, :luna],
      :ruling_signs => [:leo, :cancer],
      :decan_planet => :mercury,
      :daily_planet => :venus,
      :yearly_planet => :saturn,
      :cyclic_planet => :mars
    }
  end
  let(:data) { OpenStruct.new(options) }
  let(:presenter) { PlanetaryInfluencePresenter.new(data) }

  it 'gives access to ruling_planets' do 
    assert_equal [:sol, :luna], presenter.ruling_planets
  end

  it 'gives access to ruling_signs' do
    assert_equal [:leo, :cancer], presenter.ruling_signs
  end

  it 'gives access to decan planet' do 
    assert_equal :mercury, presenter.decan
  end

  it 'gives access to daily planet' do
    assert_equal :venus, presenter.daily
  end

  it 'gives access to yearly planet' do 
    assert_equal :saturn, presenter.yearly
  end

  it 'gives access to cyclic planet' do
    assert_equal :mars, presenter.cyclic
  end
end
