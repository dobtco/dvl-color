class Views::LocalizationSystemSpec::ReadjustBase < Fortitude::Widgets::Html5
  translation_base 'some.other.base'

  def content
    text "awesome is: #{t(".awesome", :number => 127)}"
  end
end
