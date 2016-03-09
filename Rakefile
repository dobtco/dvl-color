require 'bundler/setup'
require 'palat'
require_relative './spec/spec_helper'

task :generate_preview do
  require 'fortitude'

  class PreviewView < Fortitude::Widget
    doctype :html5
    use_instance_variables_for_assigns true
    format_output false
    start_and_end_comments false
    extra_assigns :use

    def content
      rawtext "<!doctype html>"

      html {
        head {
          title 'Color Test'
          script(src: 'https://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js')
          script %{
            $(document).on('keydown', function(e){
              if (e.keyCode == 192) $('.debug').toggle();
              if (e.keyCode == 70) $('.input').toggle();
            });
          }.html_safe

          style %{
            body {
              margin: 0;
              font-size: 1.125rem;
              line-height: 2rem;
              font-family: sans-serif;
              font-weight: 400;
              -webkit-font-smoothing: antialiased;
              -moz-osx-font-smoothing: grayscale;
            }

            h2 {
              margin: 5px 0;
              font-size: 4.29rem;
              line-height: 5rem;
              font-family: serif;
              font-weight: 100;
            }

            * {
              box-sizing: border-box;
            }

            .color_test_section {
              width: 25%;
              padding: 25px;
              display: inline-block;
            }

            .input {
              margin: 0 0 1rem;
              padding: 0.5rem 1rem;
              width: 100%;
              border-radius: 4px;
              border-style: solid;
              border-width: 1px;
            }

            .error_bubble {
              margin-top: 0.5rem;
              padding: 0.5rem 1rem;
              border-radius: 4px;
            }

            .debug {
              margin-top: 10px;
              font-size: 13px;
            }
          }.squish.html_safe
        }

        body {
          test_color_array.each do |color|
            render_section(color)
          end
        }
      }
    end

    def render_section(color)
      generator = Palat::Generator.new(color)

      div(class: 'color_test_section', style: "background-color: #{generator.background_color.to_hex}") {
        h2('Header', style: "color: #{generator.base_color.to_hex}")
        label {
          span 'Text ', style: "color: #{generator.base_color.to_hex}"
          abbr '*', style: "color: #{generator.error_color.to_hex}"
        }
        div(
          'This is my input', class: 'input',
          style: "border-color: rgba(#{generator.base_color.to_hex},0.6);
                  background-color: #{generator.input_background.to_hex};
                  color: #{generator.input_color.to_hex};"
        )
        div(
          'This is my input', class: 'input error_input error_input_focus',
          style: "display: none;
                  border-color: #{generator.error_color.to_hex};
                  background-color: #{generator.input_background_focus.to_hex};
                  color: #{generator.input_color.to_hex};"
        )
        div(
          'Error!', class: 'error_bubble',
          style: "background-color: #{generator.error_bubble_background.to_hex};
                  color: #{generator.error_bubble_color.to_hex};"
        )

        div(
          generator.to_debug_s.html_safe, class: 'debug',
          style: "color: #{generator.base_color.to_hex}; display: none;"
        )
      }
    end
  end

  html = PreviewView.new.to_html

  File.write('./index.html', html)
end
