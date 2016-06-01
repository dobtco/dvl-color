module ChromaWcagContrast
  class << self
    # http://www.w3.org/TR/2008/REC-WCAG20-20081211/#contrast-ratiodef
    # @param color1 [Chroma::Color]
    # @param color2 [Chroma::Color]
    # @return [Float]
    def ratio(color1, color2)
      high = luminance(color1)
      low = luminance(color2)

      if low > high
        high, low = low, high
      end

      (high + 0.05) / (low + 0.05)
    end

    private

    # http://www.w3.org/TR/2008/REC-WCAG20-20081211/#relativeluminancedef
    # @param color [Chroma::Color]
    # @return Float
    def luminance(color)
      new_vals = color.rgb.to_a[0..2].map { |x| x.to_f / 255 }.map do |x|
        if x < 0.03928
          x / 12.92
        else
          ((x + 0.055) / 1.055)**2.4
        end
      end

      (0.2126 * new_vals[0]) + (0.7152 * new_vals[1]) + (0.0722 * new_vals[2])
    end
  end
end
