class Views::HelpersIncludeAllOffSystemSpec::IncludeAllOff < Fortitude::Widgets::Html5
  def content
    text "excitedly: "

    result = begin
      excitedly("awesome")
    rescue => e
      e.class.name
    end

    text result
    text "; "

    text "uncertainly: "
    result = begin
      uncertainly("cool")
    rescue => e
      e.class.name
    end

    text result
  end
end
