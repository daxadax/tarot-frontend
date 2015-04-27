class MoonPresenter
  def initialize(moon)
    @moon = moon
  end

  def age
    moon.age
  end

  def phase
    moon.phase
  end

  def image_path
    age = (moon.age % 27).to_i
    "/images/luna/#{age}.png"
  end

  def percent_illuminated
    (moon.illumination * 100).round
  end

  private

  def moon
    @moon
  end
end
