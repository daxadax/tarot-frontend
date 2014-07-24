require 'tarot'
require 'sass'

class TarotApp < Sinatra::Application

  DEFAULT_DECK    = :rider_waite
  DEFAULT_SPREAD  = :enneagram

  get '/' do
    haml :index
  end

  get '/reading' do
    mark_as_reading

    spread = get_spread
    haml spread_template, :locals => {
      :cards    => spread.cards,
      :count    => spread.count,
      :average  => spread.average
    }
  end

  get '/card_info' do
    haml :card_info, :locals => {
      :card => params[:card]
    }
  end

  private

  def spread_template
    "spreads/#{used_spread}".to_sym
  end

  def used_spread
    return DEFAULT_SPREAD unless params[:used_spread]

    params[:used_spread].to_sym
  end

  def used_deck
    return DEFAULT_DECK unless params[:used_deck]

    params[:used_deck].to_sym
  end

  def get_spread
    Tarot::UseCases::BuildSpread.new(used_spread).call
  end

  def mark_as_reading
    @reading = true
  end

end

helpers do

  def data_for(card)
    {
      :element      => card.element,
      :domain       => card.domain,
      :reversed     => card.is_reversed,
      :associations => card.associations
    }
  end

  def image_path(card)
    reversed  = ("class = 'reversed'" if card.is_reversed) || ''
    path      = "/images/#{used_deck}/#{card.arcana}/#{card.id}.jpg"

    "<img src=#{path} #{reversed} />"
  end

end