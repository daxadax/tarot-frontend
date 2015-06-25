module Presenters
  class PlanetaryInfluencePresenter < Presenter
    def initialize(influence)
      @influence = influence
    end

    def title_for(influence)
      title = format_symbol(influence)
      return title if self.send(influence).size > 1
      title.chop
    end

    def ruling_planets
      influence.ruling_planets
    end

    def ruling_signs
      influence.ruling_signs
    end

    def decan
      influence.decan_planet
    end

    def daily
      influence.daily_planet
    end

    def yearly
      influence.yearly_planet
    end

    def cyclic
      influence.cyclic_planet
    end

    private

    def influence
      @influence
    end
  end
end
