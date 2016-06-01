describe "Rails layout support", :type => :rails do
  uses_rails_with_template :layouts_system_spec

  it "should let you use a widget in an ERb layout, and render in the right order" do
    data = get("widget_inside_erb_layout")
    data.should match(/default_layout_erb/i)
    data.should match(/this is widget_inside_erb_layout/i)
    data.should match(/pre_layout order: \[:widget_inside_erb_layout, :layout_pre\]/i)
    data.should match(/post_layout order: \[:widget_inside_erb_layout, :layout_pre, :layout_post\]/i)
    data.should match(/order inside widget: \[:widget_inside_erb_layout\]/i)
    data.should match(/pre_layout foo: foo_from_widget_inside_erb_layout/i)
    data.should match(/post_layout foo: foo_from_widget_inside_erb_layout/i)
  end

  it "should let you use a widget as a layout with an ERb view, and render in the right order" do
    data = get("erb_inside_widget_layout")
    data.should match(/widget_layout/i)
    data.should match(/this is erb_inside_widget_layout/i)
    data.should match(/pre_layout order: \[:erb_inside_widget_layout, :widget_layout_pre\]/i)
    data.should match(/post_layout order: \[:erb_inside_widget_layout, :widget_layout_pre, :widget_layout_post\]/i)
    data.should match(/order inside erb: \[:erb_inside_widget_layout\]/i)
    data.should match(/pre_layout foo: foo_from_erb_inside_widget_layout/i)
    data.should match(/post_layout foo: foo_from_erb_inside_widget_layout/i)
  end

  it "should let you use a widget as a layout with a widget view, and render in the right order" do
    data = get("widget_inside_widget_layout")
    data.should match(/widget_layout/i)
    data.should match(/this is widget_inside_widget_layout/i)
    data.should match(/pre_layout order: \[:widget_inside_widget_layout, :widget_layout_pre\]/i)
    data.should match(/post_layout order: \[:widget_inside_widget_layout, :widget_layout_pre, :widget_layout_post\]/i)
    data.should match(/order inside widget: \[:widget_inside_widget_layout\]/i)
    data.should match(/pre_layout foo: foo_from_widget_inside_widget_layout/i)
    data.should match(/post_layout foo: foo_from_widget_inside_widget_layout/i)
  end

  it "should use a layout with render :widget by default" do
    data = get("render_widget")
    data.should match(/default_layout_erb/i)
    data.should match(/this is the_render_widget/i)
  end

  it "should let you turn off the layout with render :widget" do
    unless rails_server.rails_version =~ /^3\.[01]\./
      # Rails 3.0 and 3.1 simply don't pass the ":layout => false" option specified in the controller through to
      # the renderer we add using ::ActionController.add_renderer. There's really nothing we can do about this,
      # so we let this one particular case fail; it seems like a bug in Rails, not in our code.
      data = get("render_widget_without_layout")
      data.should_not match(/default_layout_erb/i)
      data.should match(/this is the_render_widget/i)
    end
  end

  it "should let you pick an alternate layout for render :widget" do
    data = get("render_widget_with_alt_layout")
    data.should match(/alternate_layout_erb/i)
    data.should match(/this is the_render_widget/i)
  end

  it "should let you explicitly yield to the view" do
    data = get("yield_from_widget_explicitly")
    data.should match(/explicit_yield_layout/i)
    data.should match(/this is yield_from_widget_explicitly/i)
  end
end
