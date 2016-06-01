class Views::Layouts::WidgetLayout < Fortitude::Widgets::Html5
  def content
    html do
      head do
        title "widget_layout"
      end
      body do
        $order << :widget_layout_pre

        p "pre_layout foo: #{shared_variables[:foo]}"
        p "pre_layout order: #{$order.inspect}"

        yield

        $order << :widget_layout_post

        p "post_layout foo: #{shared_variables[:foo]}"
        p "post_layout order: #{$order.inspect}"
      end
    end
  end
end
