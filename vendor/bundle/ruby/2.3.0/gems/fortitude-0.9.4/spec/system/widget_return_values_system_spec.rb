describe "Fortitude widget return values", :type => :system do
  describe "#to_html" do
    it "should return the rendered text" do
      wc = widget_class do
        needs :name

        def content
          h1 "hello, #{name}"
          div {
            p "you are awesome, #{name}"
          }
        end
      end

      expect(wc.new(:name => 'wendy').to_html).to eq(
        %{<h1>hello, wendy</h1><div><p>you are awesome, wendy</p></div>})
    end
  end

  describe "#widget" do
    it "should return whatever the widget returns" do
      inner = widget_class_with_content do
        text "inner"
        :this_is_inner_rv
      end

      outer = widget_class do
        attr_accessor :inner
        def content
          rv = widget inner
          text "inner rv: #{rv.inspect}"
        end
      end

      outer_instance = outer.new
      inner_instance = inner.new
      outer_instance.inner = inner_instance

      expect(render(outer_instance)).to eq("innerinner rv: :this_is_inner_rv")
    end

    it "should return whatever the widget returns, even if there are around_content methods that return something different" do
      inner = widget_class do
        def content
          text "inner"
          :this_is_inner_rv
        end

        def around1
          yield
          :around1_rv
        end

        around_content :around1
      end

      outer = widget_class do
        attr_accessor :inner
        def content
          rv = widget inner
          text "inner rv: #{rv.inspect}"
        end
      end

      outer_instance = outer.new
      inner_instance = inner.new
      outer_instance.inner = inner_instance

      expect(render(outer_instance)).to eq("innerinner rv: :this_is_inner_rv")
    end
  end

  describe "#render_to" do
    it "should return whatever #content returns" do
      wc = widget_class_with_content do
        text "foo"
        :widget_rv
      end

      widget = wc.new
      rendering_context = rc
      actual_rv = widget.render_to(rendering_context)
      expect(actual_rv).to eq(:widget_rv)
    end

    it "should return whatever #content returns, even if there's an around_content that returns something different" do
      wc = widget_class do
        def content
          text "foo"
          :widget_rv
        end

        def around1
          yield
          :around1_rv
        end

        around_content :around1
      end

      widget = wc.new
      rendering_context = rc
      actual_rv = widget.render_to(rendering_context)
      expect(actual_rv).to eq(:widget_rv)
    end
  end
end
