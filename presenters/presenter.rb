module Presenters
  class Presenter
    def format_symbol(sym)
      sym.to_s.split('_').each(&:capitalize!).join(' ')
    end
  end
end
