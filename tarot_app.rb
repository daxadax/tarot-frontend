class TarotApp < Sinatra::Application
  get '/' do
    redirect '/cards'
  end

  get '/cards' do
    spread = build_deck
    set_time_of_reading

    haml :all_cards,
      :layout => 'layouts/reading'.to_sym,
      :locals => {
        :cards => spread.cards.shuffle,
        :moon => moon_presenter_for_spread,
        :planetary_influence => planetary_influence_for_spread
      }
  end

  get '/about' do
    haml :about, :layout => 'layouts/about'.to_sym
  end

  post '/card_info/:card_id' do
    # expires 500, :public, :must_revalidate
    haml 'partials/card_info'.to_sym, {
      layout: false,
      locals: {
        card: get_card(params[:card_id])
      }
    }
  end

  get '/card_for_spread/:card_id' do
    card = get_card(params[:card_id])
    display_card card, false
  end

  private

  def set_time_of_reading
    @time_of_reading = Time.now.utc
  end

  def time_of_reading
    @time_of_reading
  end

  def get_card(id)
    # add moon_presenter to card cache
    # invalidate based on #time_of_reading
    card_cache.fetch(id)
  end

  def build_deck(input = nil)
    input ||= {
      :quantity => 7,
      :cards => nil # specified_cards
    }
    Tarot::UseCases::GetCards.new(input).call
  end

  def moon_presenter_for_spread
    input = {time_of_reading: time_of_reading}
    result = Tarot::UseCases::GetMoonInfo.new(input).call
    Presenters::MoonPresenter.new(result.moon)
  end

  def planetary_influence_for_spread
    input = {time_of_reading: time_of_reading}
    result = Tarot::UseCases::GetPlanetaryInfluence.new(input).call
    presenter = Presenters::PlanetaryInfluencePresenter
    presenter.new(result.planetary_influence)
  end

  def static_correspondences
    @static_correspondences ||= fetch_static_correspondences
  end

  def specified_cards
    return nil unless params[:specified_cards]
    JSON.parse(params[:specified_cards]).map(&:to_s)
  end

  def fetch_static_correspondences
    Tarot::UseCases::GetStaticCorrespondences.new.call
  end

  def card_cache
    @cache ||= CardCache.new(static_correspondences)
  end
end

helpers do
  def display_card(card, layout = nil)
    haml :card, :layout => layout,
    :locals => {
      :card => card
    }
  end

  def display_card_back_design
    path = "/images/decks/rider_waite/backside.png"
    "<img src=#{path}>"
  end

  def display_symbol(symbol)
    source = "src=/images/symbols/#{symbol}.png"
    title = "title=#{symbol}"
    css_class = "class='symbol-#{symbol}'"

    "<img #{source} #{title} #{css_class}>"
  end

  def link_to(url,text=url,opts={})
    attributes = ""
    opts.each { |key,value| attributes << key.to_s << "=\"" << value << "\" "}
    "<a href=\"#{url}\" #{attributes}>#{text}</a>"
  end
end
