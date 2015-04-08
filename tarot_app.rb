require 'tarot'
require 'sass'
require 'json'
require 'minidown'

class TarotApp < Sinatra::Application
  DECKS = ["rider_waite"]
  BADGE_TYPES = [:trumps, :wands, :pentacles, :cups, :swords, :reversed]
  BADGE_THRESHOLD = 50

  get '/' do
    redirect '/cards'
  end

  get '/cards' do
    spread = get_spread

    haml :all_cards,
      :locals => {
        :cards => spread.cards.shuffle,
        :badges => [] #build_badges(spread.average)
      }
  end

  post '/card_info' do
    # expires 500, :public, :must_revalidate
    id = params[:id]

    haml 'partials/card_info'.to_sym, {
      :layout => false,
      :locals => {:card => get_card(id) }
    }
  end

  get '/card_for_spread/:card_id' do
    card = get_card(params[:card_id])
    display_card card, false
  end

  private

  def used_deck
    return :rider_waite
  end

  def get_card(id)
    input = {
      :quantity => 1,
      :cards => [id]
    }

    get_spread(input).cards.first
  end

  def get_spread(input = nil)
    input ||= {
      :quantity => nil,
      :cards => specified_cards
    }

    Tarot::UseCases::GetCards.new(input).call
  end

  def specified_cards
    return nil unless params[:specified_cards]
    JSON.parse(params[:specified_cards]).map(&:to_s)
  end

  def card
    params[:card]
  end

  def build_badges(average)
    Badges.new(average).build
  end

end

helpers do

  def display_card(card, layout = nil)
    haml :card, :layout => layout,
    :locals => {
      :card => card
    }
  end

  def display_element_icon(element)
    path = "/images/elements/#{element}.png"

    "<img src=#{path}/>"
  end

  def data_for(card)
    {
      :id => card.id,
      :name => card.display_name,
      :element => card.element,
      :domain => card.domain,
      :reversed => card.is_reversed,
      :general_associations => card.associations.general,
      :golden_dawn_associations => card.associations.golden_dawn,
      :image => image_path(card)
    }.to_json
  end

  def card_back(deck = nil)
    deck = deck || used_deck
    path = "/images/decks/#{deck}/backside.png"

    "<img src=#{path} />"
  end

  def image_path(card, deck = nil)
    deck = deck || used_deck

    reversed  = ("class='reversed'" if card.is_reversed) || ''
    path = "/images/decks/#{deck}/#{card.arcana}/#{card.id}.jpg"

    "<img src=#{path} #{reversed} />"
  end

  def link_to(url,text=url,opts={})
    attributes = ""
    opts.each { |key,value| attributes << key.to_s << "=\"" << value << "\" "}
    "<a href=\"#{url}\" #{attributes}>#{text}</a>"
  end

  def display_associations(associations)
    return associations if associations.is_a? String
    associations.join(', ')
  end

  def render_badges(badges)
    render :haml, 'badges/index'.to_sym,  :locals => {:badges => badges}
  end

  def format(sym)
    sym.to_s.split('_').each(&:capitalize!).join(' ')
  end

end
