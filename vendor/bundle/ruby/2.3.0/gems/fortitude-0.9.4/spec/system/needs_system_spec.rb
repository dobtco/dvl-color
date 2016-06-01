describe "Fortitude needs", :type => :system do
  def required
    Fortitude::Widget::REQUIRED_NEED
  end

  it "should return the current needs from .needs, with or without arguments" do
    parent = widget_class
    child = widget_class(:superclass => parent)

    expect(parent.needs).to eq({ })
    expect(parent.needs(:foo)).to eq(:foo => required)
    expect(parent.needs(:bar => 'def_bar')).to eq(:foo => required, :bar => 'def_bar')

    expect(child.needs).to eq(:foo => required, :bar => 'def_bar')
    expect(child.needs(:bar)).to eq(:foo => required, :bar => required)
    expect(child.needs(:baz => 'def_baz')).to eq(:foo => required, :bar => required, :baz => 'def_baz')
  end

  it "should not rebuild 'needs' at all unless you actually use a widget" do
    notifications = [ ]
    ActiveSupport::Notifications.subscribe("fortitude.rebuilding") do |*args|
      notifications << args
    end

    wc1 = widget_class do
      def content
        p "hello, world"
      end
    end

    wc2 = widget_class do
      needs :foo, :bar, :baz

      def content
        p "foo: #{foo}, bar: #{bar}"
      end
    end

    wc3 = widget_class do
      needs :foo, :bar

      def content
        p "foo: #{foo}"
      end
    end

    expect(notifications).to eq([ ])
  end

  it "should raise an exception if you try to modify a 'needs' default value" do
    wc = widget_class do
      needs :foo, :bar => [ 'a', 'b' ]

      def content
        bar << foo
        text "bar: #{bar.join(",")}"
      end
    end

    expect { render(wc.new(:foo => 'c')) }.to raise_error
  end

  it "should allow you to override a 'needs' method, and use #super" do
    klass = widget_class do
      needs :foo

      def foo
        "xx" + super + "yy"
      end

      def content
        p "foo is: #{foo}"
      end
    end

    expect(render(klass.new(:foo => 'aaa'))).to eq("<p>foo is: xxaaayy</p>")
  end

  describe "shadowing" do
    it "should shadow tags with needs, not the other way around" do
      klass = widget_class do
        needs :p, :div => 'whatever'

        def content
          text "p is: #{p}, div is: #{div}"
        end
      end

      expect(render(klass.new(:p => 'aaa'))).to eq("p is: aaa, div is: whatever")
    end

    it "should still allow access to tags using tag_*" do
      klass = widget_class do
        needs :p, :div => 'whatever'

        def content
          tag_p "this is a p"
          tag_div "this is a div"
          text "p is: #{p}, div is: #{div}"
        end
      end

      expect(render(klass.new(:p => 'bbb'))).to eq("<p>this is a p</p><div>this is a div</div>p is: bbb, div is: whatever")
    end

    it "should still allow access to text, comment, rawtext, and javascript using tag_*" do
      klass = widget_class do
        needs :text => 'foo', :comment => 'bar', :rawtext => 'baz', :javascript => 'quux'

        def content
          tag_text "text is: #{text}"
          tag_comment "comment is: #{comment}"
          tag_rawtext "rawtext is: #{rawtext}"
          tag_javascript "javascript is: #{javascript}"
        end
      end

      expect(render(klass)).to eq(%{text is: foo<!-- comment is: bar -->rawtext is: baz<script>javascript is: quux</script>})
    end

    it "should raise an error if you pass a block to a 'needs' method and debugging is on" do
      klass = widget_class do
        debug true
        needs :p

        def content
          p { text "this is not run" }
          text "p is: #{p}"
        end
      end

      expect { render(klass.new(:p => 'aaa')) }.to raise_error(Fortitude::Errors::BlockPassedToNeedMethod)
    end

    it "should not raise an error if you pass a block to a 'needs' method and debugging is off" do
      klass = widget_class do
        needs :p

        def content
          p { text "this is not run" }
          text "p is: #{p}"
        end
      end

      expect(render(klass.new(:p => 'aaa'))).to eq("p is: aaa")
    end
  end

  describe "names" do
    BAD_METHOD_NAMES = [ " ", "0123", "0foo", "?baz", "!yo", "!", "?", "abc??" ]

    BAD_METHOD_NAMES.each do |bad_method_name|
      it "should fail if you try to use a name for a need that's not a valid method name, like #{bad_method_name.inspect}" do
        expect { widget_class { needs bad_method_name } }.to raise_error(ArgumentError)
        expect { widget_class { needs bad_method_name.to_sym } }.to raise_error(ArgumentError)
      end

      it "should ignore any extra assigns that aren't valid method names, like #{bad_method_name.inspect}" do
        wc = widget_class do
          extra_assigns :use

          def content
            rawtext assigns.to_hash.inspect
          end
        end

        expect(render(wc.new(bad_method_name => "foobar", :foo => 'bar'))).to eq("{:foo=>\"bar\"}")
      end
    end

    VALID_METHOD_NAMES = [ "o01239014", "______", "_", "foo?", "bar!", "_0123" ]

    VALID_METHOD_NAMES.each do |valid_method_name|
      it "should allow you to use corner-case names for a need, like #{valid_method_name.inspect}" do
        wc = widget_class do
          needs valid_method_name.to_sym

          attr_accessor :method_name

          def content
            eval("p \"value: \#{#{method_name}}\"")
          end
        end

        i = wc.new(valid_method_name => "foo")
        i.method_name = valid_method_name

        expect(render(i)).to eq("<p>value: foo</p>")
      end

      it "should allow you to pass corner-case names for an extra assign, like #{valid_method_name.inspect}" do
        wc = widget_class do
          extra_assigns :use

          attr_accessor :method_name

          def content
            eval("p \"value: \#{#{method_name}}\"")
          end
        end

        i = wc.new(valid_method_name => "foo")
        i.method_name = valid_method_name

        expect(render(i)).to eq("<p>value: foo</p>")
      end
    end
  end

  describe "inheritance" do
    it "should require needs from all superclasses" do
      grandparent = widget_class { needs :foo }
      parent = widget_class(:superclass => grandparent) { needs :bar }
      child = widget_class(:superclass => parent) do
        needs :baz
        def content
          text "foo: #{foo}, bar: #{bar}, baz: #{baz}"
        end
      end

      expect { child.new }.to raise_error(Fortitude::Errors::MissingNeed)
      expect { child.new(:foo => 'f') }.to raise_error(Fortitude::Errors::MissingNeed)
      expect { child.new(:foo => 'f', :bar => 'b') }.to raise_error(Fortitude::Errors::MissingNeed)
      expect(render(child.new(:foo => 'f', :bar => 'b', :baz => 'z'))).to eq("foo: f, bar: b, baz: z")

      expect(grandparent.needs).to eq({ :foo => required })
      expect(parent.needs).to eq({ :foo => required, :bar => required })
      expect(child.needs).to eq({ :foo => required, :bar => required, :baz => required })
    end

    it "should let you add needs later, and it should apply to both that class and any subclasses" do
      parent = widget_class_with_content { text "parent" }
      child = widget_class(:superclass => parent) do
        needs :bar
        def content
          super
          text "; child: bar: #{bar}"
        end
      end

      expect(render(parent)).to eq("parent")
      expect(render(child.new(:bar => "the_bar"))).to eq("parent; child: bar: the_bar")
      expect(parent.needs).to eq({ })
      expect(child.needs).to eq({ :bar => required })

      parent.class_eval { needs :foo }
      child.class_eval do
        def content
          super
          text "; child: bar: #{bar}; foo: #{foo}"
        end
      end

      expect { parent.new }.to raise_error(Fortitude::Errors::MissingNeed)
      expect { child.new(:bar => 'the_bar') }.to raise_error(Fortitude::Errors::MissingNeed)

      expect(render(parent.new(:foo => "the_foo"))).to eq("parent")
      expect(render(child.new(:foo => "the_foo", :bar => "the_bar"))).to eq("parent; child: bar: the_bar; foo: the_foo")

      expect(parent.needs).to eq(:foo => required)
      expect(child.needs).to eq(:foo => required, :bar => required)
    end
  end

  describe "defaults" do
    it "should allow supplying defaults, and allow overriding them" do
      c = widget_class do
        needs :foo, :bar => 'def_bar', :baz => 'def_baz'
        def content
          text "foo: #{foo}, bar: #{bar}, baz: #{baz}"
        end
      end

      expect { c.new }.to raise_error(Fortitude::Errors::MissingNeed)
      expect(render(c.new(:foo => 'the_foo'))).to eq("foo: the_foo, bar: def_bar, baz: def_baz")
      expect(render(c.new(:foo => 'the_foo', :baz => 'the_baz'))).to eq("foo: the_foo, bar: def_bar, baz: the_baz")

      expect(c.needs).to eq(:foo => required, :bar => 'def_bar', :baz => 'def_baz')
    end

    it "should inherit defaults properly" do
      parent = widget_class do
        needs :foo, :bar => 'def_bar', :baz => 'def_baz'
        def content
          text "foo: #{foo}, bar: #{bar}, baz: #{baz}"
        end
      end

      child = widget_class(:superclass => parent) do
        needs :baz => 'child_def_baz', :quux => 'child_quux'
        def content
          super
          text "; baz: #{baz}, quux: #{quux}"
        end
      end

      expect(render(parent.new(:foo => 'the_foo'))).to eq('foo: the_foo, bar: def_bar, baz: def_baz')
      expect { child.new }.to raise_error(Fortitude::Errors::MissingNeed)
      expect(render(child.new(:foo => 'the_foo'))).to eq('foo: the_foo, bar: def_bar, baz: child_def_baz; baz: child_def_baz, quux: child_quux')

      expect(parent.needs).to eq(:foo => required, :bar => 'def_bar', :baz => 'def_baz')
      expect(child.needs).to eq(:foo => required, :bar => 'def_bar', :baz => 'child_def_baz', :quux => 'child_quux')
    end

    it "should allow overriding a default with a requirement" do
      parent = widget_class do
        needs :foo, :bar => 'def_bar'
      end

      child = widget_class(:superclass => parent) do
        needs :bar
        def content
          text "foo: #{foo}, bar: #{bar}"
        end
      end

      expect { child.new(:foo => 'the_foo') }.to raise_error(Fortitude::Errors::MissingNeed)
      expect(render(child.new(:foo => 'the_foo', :bar => 'the_bar'))).to eq('foo: the_foo, bar: the_bar')

      expect(parent.needs).to eq(:foo => required, :bar => 'def_bar')
      expect(child.needs).to eq(:foo => required, :bar => required)
    end

    it "should allow overriding a requirement with a default" do
      parent = widget_class do
        needs :foo, :bar
      end

      child = widget_class(:superclass => parent) do
        needs :foo => 'def_foo', :bar => 'def_bar'
        def content
          text "foo: #{foo}, bar: #{bar}"
        end
      end

      expect(render(child.new)).to eq('foo: def_foo, bar: def_bar')
      expect(render(child.new(:bar => 'the_bar'))).to eq('foo: def_foo, bar: the_bar')

      expect(parent.needs).to eq(:foo => required, :bar => required)
      expect(child.needs).to eq(:foo => 'def_foo', :bar => 'def_bar')
    end
  end

  describe "extra assigns" do
    it "should, by default, ignore assigns it doesn't need" do
      c = widget_class do
        needs :foo
        def content
          bar_value = begin
            bar
          rescue => e
            e.class.name
          end

          text "foo: #{foo}, bar: #{bar_value}"
        end
      end

      expect(render(c.new(:foo => 'the_foo', :bar => 'the_bar'))).to eq('foo: the_foo, bar: NameError')
    end

    it "should ignore assigns it doesn't need, if told to" do
      c = widget_class do
        extra_assigns :ignore
        needs :foo
        def content
          bar_value = begin
            bar
          rescue => e
            e.class.name
          end

          text "foo: #{foo}, bar: #{bar_value}"
        end
      end

      expect(render(c.new(:foo => 'the_foo', :bar => 'the_bar'))).to eq('foo: the_foo, bar: NameError')
    end

    it "should fail if passed assigns it doesn't need, if asked to" do
      c = widget_class do
        extra_assigns :error
        needs :foo
        def content
          text "foo: #{foo}"
        end
      end

      expect { c.new(:foo => 'the_foo', :bar => 'the_bar') }.to raise_error(Fortitude::Errors::ExtraAssigns, /bar/i)
      expect(render(c.new(:foo => 'the_foo'))).to eq("foo: the_foo")
    end

    it "should use extra assigns it doesn't need, if asked to" do
      c = widget_class do
        extra_assigns :use
        needs :foo
        def content
          bar_value = begin
            bar
          rescue => e
            e.class.name
          end

          text "foo: #{foo}; bar: #{bar_value}"
        end
      end

      expect(render(c.new(:foo => 'the_foo'))).to eq('foo: the_foo; bar: NameError')
      expect(render(c.new(:foo => 'the_foo', :bar => 'the_bar'))).to eq('foo: the_foo; bar: the_bar')
    end
  end
end
