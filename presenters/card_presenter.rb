module Presenters
  class CardPresenter < Presenter
    def initialize(card, static_correspondences)
      @card = card
      @static_correspondences = static_correspondences
    end

    def id
      card.id
    end

    def display_name
      card.display_name
    end

    def arcana
      card.arcana
    end

    def display_rank
      return id if major?
      display_name.split.first
    end

    def elements
      card.elements
    end

    def suit
      card.suit
    end

    def astrological_signs
      card.astrological_signs
    end

    def golden_dawn_correspondence
      gdc = card.correspondence.golden_dawn
      gdc.empty? ? nil : gdc
    end

    def rank_correspondence
      rank = arcana.to_s + id.split('_').last
      static_correspondences.rank[rank.to_sym]
    end

    def major?
      card.is_major
    end

    def minor?
      card.is_minor
    end

    def court?
      card.is_court_card
    end

    def reversed?
      false
    end

    def image_path
      klass  = ("class='reversed'" if reversed?) || ''
      path = "/images/decks/rider_waite/#{arcana}/#{id}.jpg"

      "<img src=#{path} #{klass} />"
    end

    private

    def card
      @card
    end

    def static_correspondences
      @static_correspondences
    end
  end
end
