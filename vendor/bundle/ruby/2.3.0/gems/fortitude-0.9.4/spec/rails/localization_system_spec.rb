describe "basic Rails support", :type => :rails do
  uses_rails_with_template :localization_system_spec

  it "should allow you to provide localized content methods" do
    expect_match("content_method?locale=en", /wassup\? this is english/mi)
    expect_match("content_method?locale=fr", /bienvenue, les mecs/mi)
    expect_match("content_method?locale=pt", /i don&#(39|x27);t know that language/mi)
  end

  it "should let you translate strings with I18n.t" do
    expect_match("i18n_t?locale=en", /a house is: house/)
    expect_match("i18n_t?locale=fr", /a house is: maison/)
  end

  it "should let you translate strings with just t" do
    expect_match("t?locale=en", /a house is: house/)
    expect_match("t?locale=fr", /a house is: maison/)
  end

  it "should support dot-notation for I18n translation naming" do
    expect_match("dot_notation?locale=en", /awesome is: awesome!/)
    expect_match("dot_notation?locale=fr", /awesome is: formidable!/)
  end

  it "should let you translate strings with Fortitude translation support" do
    expect_match("native_support?locale=en", /not translated; also awesome 127!; also not translated/i)
    expect_match("native_support?locale=fr", /not translated; encore formidable 127!; also not translated/i)
  end

  it "should let you readjust the translation base" do
    expect_match("readjust_base?locale=en", /SUPA-awesome 127!/)
    expect_match("readjust_base?locale=fr", /TOUS formidable, 127!/)
  end

  it "should not escape explicitly-HTML translations" do
    expect_match("explicit_html", /one: foo<bar>, two: bar<baz>, one again: foo<bar>, two again: bar<baz>/i)
  end
end
