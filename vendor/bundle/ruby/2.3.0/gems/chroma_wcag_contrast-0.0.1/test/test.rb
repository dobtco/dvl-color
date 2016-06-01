require 'bundler/setup'
require 'minitest/autorun'
require 'chroma'
require 'chroma_wcag_contrast'

class WCAGColorContrastTest < MiniTest::Unit::TestCase
  def test_ratios
    assert_in_delta 2.849, ChromaWcagContrast.ratio(Chroma.paint('999'), Chroma.paint('ffffff'))
    assert_in_delta 1.425, ChromaWcagContrast.ratio(Chroma.paint('d8d8d8'), Chroma.paint('fff'))
    assert_in_delta 1.956, ChromaWcagContrast.ratio(Chroma.paint('eee'), Chroma.paint('AAABBB'))
  end
end
