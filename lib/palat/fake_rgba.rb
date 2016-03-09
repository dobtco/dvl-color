class Palat::FakeRgba
  def self.calculate(background, foreground, alpha)
    bg = background.rgb
    fg = foreground.rgb

    r = (fg.r * alpha) + (bg.r * (1 - alpha))
    g = (fg.g * alpha) + (bg.g * (1 - alpha))
    b = (fg.b * alpha) + (bg.b * (1 - alpha))

    Chroma::Color.new(Chroma::ColorModes::Rgb.new(r, g,  b), :hex)
  end
end
