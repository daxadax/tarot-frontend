class CardCache
  def initialize(static_correspondences)
    @cache = {}
    @static_correspondences = static_correspondences
  end

  def fetch(id)
    @cache[id] ||= get_card_from_use_case(:card_id => id)
  end

  private

  def get_card_from_use_case(input)
    result = Tarot::UseCases::GetCard.new(input).call
    card = CardPresenter.new(result.card, @static_correspondences)
    @cache[card.id] = card
    card
  end
end
