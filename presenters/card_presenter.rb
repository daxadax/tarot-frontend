class CardPresenter
  def initialize(card)
    @card = card
  end

  def id
    card.id
  end

  def arcana
    card.arcana
  end

  def suit
    card.suit
  end

  def element
    card.element
  end

  def display_name
    card.display_name
  end

  def elemental_associations
    card.domain.join(', ')
  end

  def general_associations
    card.associations.general.join(', ')
  end

  def golden_dawn_associations
    card.associations.golden_dawn.join(', ')
  end

  def reversed?
    card.is_reversed
  end

  def image_path
    klass  = ("class='reversed'" if reversed?) || ''
    path = "/images/decks/rider_waite/#{arcana}/#{id}.jpg"

    "<img src=#{path} #{klass} />"
  end

  def element_image_path
    "<img src=/images/elements/#{element}.png/>"
  end

  private

  def card
    @card
  end

end
