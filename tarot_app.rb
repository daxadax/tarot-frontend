require 'tarot'
require 'sass'
require 'json'
require 'minidown'

class TarotApp < Sinatra::Application
  DECKS = ["rider_waite", "the_herbal_tarot"]
  SPREADS = [:three_card, :ennegram]
  BADGE_TYPES = [:trumps, :wands, :pentacles, :cups, :swords, :reversed]
  BADGE_THRESHOLD = 50

  get '/' do
    all = get_spread

    haml :reading_config, :layout => 'layouts/reading_config'.to_sym,
                :locals => {:cards => all.cards}
  end

  get '/reading' do
    spread = get_spread

    haml spread_template,
      :layout => 'layouts/reading'.to_sym,
      :locals => {
        :cards    => spread.cards,
        :badges   => build_badges(spread.average)
      }
  end

  post '/card_info' do
    # expires 500, :public, :must_revalidate

    haml 'partials/card_info'.to_sym, {
      :layout => false,
      :locals => {:card => card}
    }
  end

  get '/deck_info/:deck' do
    deck = params[:deck]
    text_for_deck = File.read("info/decks/#{deck}")
    image = "<img src='/images/decks/#{deck}/major/01.jpg' />"

    haml 'partials/deck_info'.to_sym, {
      :layout => false,
      :locals => {
        :text => Minidown.render(text_for_deck),
        :image => image
      }
    }
  end

  get '/spread_info/:spread' do
    File.read("info/spreads/#{params[:spread]}")
  end

  private

  def spread_template
    "spreads/#{used_spread}".to_sym
  end

  def used_spread
    return :all unless params[:spread]

    params[:spread].to_sym
  end

  def used_deck
    params[:deck].to_sym
  end

  def get_spread
    input = {
      :used_spread  => used_spread,
      :cards        => specified_cards
    }

    Tarot::UseCases::DealForSpread.new(input).call
  end

  def mark_as_reading
    @reading = true
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

  def data_for(card)
    {
      :id => card.id,
      :name => card.display_name,
      :element => card.element,
      :domain => card.domain,
      :reversed => card.is_reversed,
      :associations => card.associations,
      :image => image_path(card)
    }
  end

  def image_path(card, deck = nil)
    deck = deck || used_deck

    reversed  = ("class='reversed'" if card.is_reversed) || ''
    path      = "/images/decks/#{deck}/#{card.arcana}/#{card.id}.jpg"

    "<img src=#{path} #{reversed} />"
  end

  def link_to(url,text=url,opts={})
    attributes = ""
    opts.each { |key,value| attributes << key.to_s << "=\"" << value << "\" "}
    "<a href=\"#{url}\" #{attributes}>#{text}</a>"
  end

  def render_badges(badges)
    render :haml, 'badges/index'.to_sym,  :locals => {:badges => badges}
  end

  def deck_names
    @deck_names ||= TarotApp::DECKS.map do |deck|
      format deck
    end
  end

  def format(sym)
    sym.to_s.split('_').each(&:capitalize!).join(' ')
  end

end
