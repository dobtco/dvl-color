class Palat::Generator
  DARK_BACKGROUND_CUTOFF = 120

  attr_accessor :background_color,
                :input_color,
                :input_background,
                :input_background_focus,
                :dropdown_background,
                :dropdown_color

  # @param background_color [Chroma::Color or String]
  def initialize(background_color)
    self.background_color = background_color

    unless background_color.is_a?(Chroma::Color)
      self.background_color = Chroma.paint(background_color)
    end

    self.input_background, self.input_background_focus, self.input_color = generate_input_colors
    self.dropdown_background, self.dropdown_color = generate_dropdown_colors
  end

  def to_h
    {
      backgroundColor: background_color.to_hex,
      baseColor: base_color.to_hex,
      errorColor: error_color.to_hex,
      errorBubbleBackground: error_bubble_background.to_hex,
      errorBubbleColor: error_bubble_color.to_hex,
      inputBackground: input_background.to_hex,
      inputBackgroundFocus: input_background_focus.to_hex,
      inputColor: input_color.to_hex,
      dropdownBackground: dropdown_background.to_hex,
      dropdownColor: dropdown_color.to_hex
    }
  end

  def to_scss
    ''.tap do |str|
      to_h.each do |k, v|
        str << "$#{k}:#{v};"
      end
    end
  end

  def to_debug_s
    str = []

    to_h.each do |k, v|
      str << "#{k}: #{v}"
    end

    str << "Background brightness: #{background_color.brightness}"

    str << "Ratio: #{contrast(background_color, base_color).round(2)}"
    str << "Error Ratio: #{contrast(background_color, error_color).round(2)}"
    str << "Error Bubble Ratio: #{contrast(error_bubble_background, error_bubble_color).round(2)}"
    str << "Input ratio: #{contrast(input_background, input_color).round(2)}"
    str << "Error satur: #{error_color.hsl.s.round(2)}"
    str << "Conservative light: #{conservative_background_light?}"
    str << "Conservative dark: #{conservative_background_dark?}"

    str.join("<br>")
  end

  def conservative_background_dark?
    background_color.brightness < 52
  end

  def conservative_background_light?
    background_color.brightness > 229
  end

  def target_contrast_ratio
    if conservative_background_dark?
      13
    elsif conservative_background_light?
      10
    else
      7
    end
  end

  def base_color
    @base_color ||= begin
      text = background_color.dup

      # If the background is dark, we lighten it.
      # If the background is light, we darken it.
      amt = if background_color.brightness < DARK_BACKGROUND_CUTOFF # Dark
              1
            else
              -1
            end

      target = target_contrast_ratio

      while contrast(background_color, text) < target
        new_text = text.lighten(amt)

        # prevent infinite loop
        break if text == new_text

        text = new_text
      end

      # If the background is a conservative color, use a conservative
      # (desaturated) text color.

      if conservative_background_dark? || conservative_background_light?
        hsl = text.hsl
        hsl.s = hsl.s * 0.15
        text = Chroma.paint(hsl)
      end

      text
    end
  end

  def error_color
    @error_color ||= begin
      error = background_color.dup

      # Spin the color wheel until we land on "red"
      amt = if error.hsl.h > 180
              15
            else
              -15
            end

      while !red?(error)
        error = error.spin(amt)
      end

      # White
      if background_color == white
        error = Chroma.paint('d95b76')
      # Black
      elsif background_color == black
        error = Chroma.paint('d95b76')
      # Grayscale
      elsif error.hsl.s == 0
        error = error.saturate(100)
      # Otherwise, ensure saturation is at least 0.4, or else it's not really red...
      elsif error.hsl.s < 0.4
        hsl = error.hsl
        hsl.s = 0.4
        error = Chroma.paint(hsl)
      elsif conservative_background_light?
        hsl = error.hsl
        hsl.l = hsl.l - 0.4
        error = Chroma.paint(hsl)
      end

      amt = if background_color.brightness < 100
              2
            else
              -2
            end

      while contrast(error, background_color) < 2.5
        new_error = error.lighten(amt)
        break if error == new_error
        error = new_error
      end

      error
    end
  end

  def error_bubble_background
    if error_color.brightness > 200
      white
    else
      error_color
    end
  end

  def error_bubble_color
    if error_bubble_background == white
      background_color
    else
      white
    end
  end

  def generate_dropdown_colors
    if background_color.brightness < DARK_BACKGROUND_CUTOFF
      [base_color, background_color]
    else
      [background_color, base_color]
    end
  end

  def black
    Chroma.paint('#000')
  end

  def white
    Chroma.paint('#fff')
  end

  private

  def generate_input_colors
    input_background = Palat::FakeRgba.calculate(background_color, white, 0.4)
    input_background_focus = Palat::FakeRgba.calculate(background_color, white, 0.7)
    input_color = base_color

    if contrast(input_background, input_color) > 6
      [input_background, input_background_focus, input_color]
    else
      alpha = 0.2
      input_background = Palat::FakeRgba.calculate(background_color, black, alpha)
      input_background_focus = Palat::FakeRgba.calculate(background_color, black, alpha + 0.4)

      while contrast(input_background, input_color) < 6
        alpha += 0.01
        break if alpha == 1
        input_background = Palat::FakeRgba.calculate(background_color, black, alpha)
        input_background_focus = Palat::FakeRgba.calculate(background_color, black, alpha + 0.4)
      end

      [input_background, input_background_focus, input_color]
    end
  end

  def red?(color)
    color.hsl.h > 355 ||
    color.hsl.h < 10
  end

  def contrast(c1, c2)
    ChromaWcagContrast.ratio(c1, c2)
  end
end
