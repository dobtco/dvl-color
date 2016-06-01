require 'source/why/example_page'

module Views
  module Why
    class Index < Views::Why::ExamplePage
      def example_body
        standard_text_row {
          bang_intro
          examples_setup

          link_to_next_example
        }
      end

      def bang_intro
        p %{There is exactly one overwhelming reason to use Fortitude:}

        emphatic_pullquote %{It allows you to write vastly better-factored views.}

        p %{With Fortitude, you can turn this:}

        erb <<-EOS
<div class="container main outermost" id="main-container">
  <div class="row primary">
    <div class="col-sm-7">
      <figure class="source">
        <figcaption>example_code_1.rb</figcaption>
        <pre class="ruby">
[ 1, 2, 3 ].map { |x| x * 2 } # =&gt; [ 2, 4, 6 ]
</pre>
      </figure>

      <%= render :partial => '/shared/buttons/icon_button', :locals => {
        :target => conditional_refresh_url(:user => @user),
        :icon_name => 'refresh',
        :tooltip_html => "<p>Refresh this page</p>"
      } %>
    </div>
  </div>
</div>
EOS

        p %{Into this:}

        fortitude <<-EOS
simple_page {
  ruby "example_code_1.rb", "[ 1, 2, 3 ].map { |x| x * 2 } # => [ 2, 4, 6 ]"

  icon_button(:refresh, conditional_refresh_url(:user => @user)) {
    p "Refresh this page"
  }
}
EOS

        p {
          text %{…and that’s just the beginning. With Fortitude, you can }
          strong "refactor your views into the methods that are right for your application"
          text ". This means:"
        }

        ul {
          li "You’ll be able to enhance, modify, and debug views much faster."
          li %{You’ll build new views faster — and this pace will accelerate as
your codebase grows, not decelerate.}
          li "You’ll have fewer bugs in your views, and spend less time debugging them."
          li {
            text "You’ll "
            em "enjoy"
            text " building views much more."
          }
        }
      end

      def examples_setup
        p %{Fortitude expresses your views using a Ruby DSL that models HTML;
this allows you to bring all the power of Ruby to bear on your views.
The difference this makes in the long run is enormous.}

        p %{It’s easiest to explain by example.
Follow the link below, and you’ll see #{number_of_examples.humanize}
examples of using Fortitude to refactor common view problems into clear, concise,
powerful code.}
      end
    end
  end
end
