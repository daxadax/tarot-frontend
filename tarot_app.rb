class TarotApp < Sinatra::Application
  get '/' do
    redirect '/cards'
  end

  get '/cards' do
    spread = build_deck

    haml :all_cards,
      :locals => {
        :cards => spread.cards.shuffle,
        :moon => MoonPresenter.new(spread.moon)
      }
  end

  post '/card_info' do
    # expires 500, :public, :must_revalidate
    haml 'partials/card_info'.to_sym, {
      :layout => false,
      :locals => {:card => get_card(params[:card_id]) }
    }
  end

  get '/card_for_spread/:card_id' do
    card = get_card(params[:card_id])
    display_card card, false
  end

  private

  def get_card(id)
    input = { :card_id => id }
    result = Tarot::UseCases::GetCard.new(input).call

    CardPresenter.new(result.card)
  end

  def build_deck(input = nil)
    input ||= {
      :quantity => nil,
      :cards => nil # specified_cards
    }

    Tarot::UseCases::GetCards.new(input).call
  end

  def specified_cards
    return nil unless params[:specified_cards]
    JSON.parse(params[:specified_cards]).map(&:to_s)
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
    "<img src=#{path} />"
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

  def format(sym)
    sym.to_s.split('_').each(&:capitalize!).join(' ')
  end

end
