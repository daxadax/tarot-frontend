class MoonPresenter
  def initialize(moon)
    @moon = moon
  end

  def phase
    moon.phase
  end

  def active_elements
    moon.active_elements
  end

  def percent_illuminated
    (moon.illumination * 100).floor
  end

  def waxing?
    moon.is_waxing
  end

  def waning?
    moon.is_waning
  end

  def image_path
    image = get_image
    "/images/luna/#{image}.png"
  end

  private

  def get_image
    return '0' if phase == :new
    return '13' if phase == :full
    number = percent_illuminated.to_f / 8 
    
    return number.ceil if waxing?
    26 - number.floor
  end

  def moon
    @moon
  end
end
