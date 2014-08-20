class TarotApp
  class Badges

    def initialize(average)
      @average = average
    end

    def build
      badges = BADGE_TYPES.map do |type|
        build_badge_for type
      end.compact

      return [no_badges_html] if badges.empty?
      badges
    end

    private

    def build_badge_for(type)
      button_text = standard_button_text_for type
      button_text = 'Reversed Fortunes' if type == :reversed

      standard_badges_html(type, button_text) if display_badge?(type)
    end

    def display_badge?(type)
      average.public_send(type) > BADGE_THRESHOLD
    end

    def standard_button_text_for(type)
      "Predominance of #{type.capitalize}"
    end

    def standard_badges_html(type, button_text)
      "<div class='#{type}-button'>#{button_text}</div>"\
      "<div class='#{type}-info hidden'>
        #{info_partial_for(type)}
      </div>"
    end

    def no_badges_html
      "<div class='no-badges-button'>Mixed Bag</div>"\
      "<div class='no-badges-info hidden'>
        #{info_partial_for('no_badges')}
      </div>"
    end

    def info_partial_for(type)
      File.read("info/badges/#{type}")
    end

    def average
      @average
    end

  end
end