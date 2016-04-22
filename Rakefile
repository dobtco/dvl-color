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

      html(lang: 'en') {
        head {
          title 'Palat'
          meta(name: 'description', content: 'A Ruby gem that generates beautiful, accessible color schemes.')
          meta(name: 'viewport', content: 'width=device-width')
          meta('http-equiv': 'X-UA-Compatible', content: 'IE=edge')
          meta('charset': 'utf-8')
          link(rel: 'stylesheet', href: 'https://fonts.googleapis.com/css?family=Monda:400,700')
          style %{
            body {
              margin: 1em 5%;
              font-size: 100%;
              line-height: 1.5;
              font-family: 'Monda', 'HelveticaNeue', sans-serif;
              font-weight: normal;
              -webkit-font-smoothing: antialiased;
              -moz-osx-font-smoothing: grayscale;
              background-color: #200457;
              background-image: -webkit-radial-gradient(top left farthest-corner, rgba(217,59,46,0.5) 0%, rgba(217,59,46,0) 90%),
                    -webkit-radial-gradient(top right farthest-corner, rgba(46,68,217,0.4) 0%, rgba(46,68,217,0) 85%),
                    -webkit-linear-gradient(rgba(32,4,87,0),rgb(32,4,87) 500px);
              background-image: radial-gradient(farthest-corner at top left, rgba(217,59,46,0.5) 0%, rgba(217,59,46,0) 90%),
                    radial-gradient(farthest-corner at top right, rgba(46,68,217,0.4) 0%, rgba(46,68,217,0) 85%),
                    linear-gradient(rgba(32,4,87,0),rgb(32,4,87) 500px);

            }

            @-webkit-keyframes press {
              from {
                background-color: rgba(255,255,255,0.8);
                color: rgba(0,0,0,0.5);
              }
            }

            @keyframes press {
              from {
                background-color: rgba(255,255,255,0.8);
                color: rgba(0,0,0,0.5);
              }
            }

            .keycodes_wrapper {
              margin: 0 auto 1.5em;
              font-size: 2em;
              color: #fff;
              text-align: center;
              mix-blend-mode: overlay;
            }

            .keycode {
              display: inline-block;
              margin: 0 0.75em;
            }

            .keycode strong {
              font-weight: normal;
              display: inline-block;
              width: 4rem;
              height: 4rem;
              line-height: 1.5rem;
              padding: 1.25rem 0;
              text-align: center;
              background: rgba(255,255,255,0.05);
              border: 1px solid #fff;
              box-shadow: 0 0.125em 0 rgba(255,255,255,0.9);
              border-radius: 0.25em;
              margin-bottom: 0.5em;
            }

            .keycode.is_pressed strong {
              -webkit-animation: press 0.4s cubic-bezier(0.455, 0.03, 0.515, 0.955);
              animation: press 0.4s cubic-bezier(0.455, 0.03, 0.515, 0.955);
            }

            .keycode span {
              font-size: 0.875rem;
              opacity: 0.9;
              display: block;
            }

            h2 {
              margin: 0 0 1.5rem;
              font-size: 3rem;
              line-height: 5rem;
              font-weight: bold;
              text-align: center;
            }

            .label {
              margin-bottom: 0.5rem;
            }

            code {
              font-family: monospace;
              font-size: 1.25em;
            }

            * {
              box-sizing: border-box;
            }

            .logo img {
              display: block;
              max-width: 50%;
              margin: 0 auto;
            }

            .header {
              padding: 2rem 0;
            }

            .header p,
            .footer {
              color: #fff;
              max-width: 40rem;
              margin: 2.5em auto 1.5em;
              text-align: center;
              margin-bottom: 1.5em;
            }

            .footer {
              font-size: 0.75em;
              clear: left;
              display: table;
            }

            .footer a,
            .footer a:hover,
            .footer a:focus,
            .footer a:active {
              color: #fff;
            }

            .color_test_section_wrapper {
              margin: 1em 0;
              border-radius: 4px;
              box-shadow: inset 0 0 0 1px rgba(0,0,0,0.15);
              transition: -ms-transform 500ms cubic-bezier(0.23, 1, 0.32, 1);
              transition: -webkit-transform 500ms cubic-bezier(0.23, 1, 0.32, 1);
              transition: transform 500ms cubic-bezier(0.23, 1, 0.32, 1);
            }

            .color_test_section_wrapper:hover {
              -ms-transform: scale(1.03);
              -webkit-transform: scale(1.03);
              transform: scale(1.03);
            }

            .color_test_section {
              padding: 2em;
            }

            .color_test_swatch {
              background: rgba(255,255,255,0.6);
              padding: 0.25em 2em;
              font-size: 0.875em;
              border-top-left-radius: 4px;
              border-top-right-radius: 4px;
              text-align: center;
              margin: 1px;
            }

            .input {
              margin: 0 0 1rem;
              padding: 0.5rem 1rem;
              width: 100%;
              border-radius: 4px;
              border-style: solid;
              border-width: 1px;
              white-space: nowrap;
              overflow: hidden;
              text-overflow: ellipsis;
            }

            .error_bubble {
              margin-top: 0.5rem;
              padding: 0.5rem 1rem;
              border-radius: 4px;
            }

            .debug {
              margin-top: 1.5rem;
              font-size: 0.75rem;
              padding: 1rem;
              height: 40em;
              border-radius: 4px;
            }

            .debug strong {
              margin-top: 1rem;
              display: block;
            }

            .debug strong:first-of-type {
              margin: 0;
            }

            @media screen and (min-width: 850px) {
              body {
                font-size: 125%;
              }
              .color_test_section_wrapper {
                float: left;
                width: 46%;
                margin: 2%;
              }
            }

            @media screen and (min-width: 1600px) {
              .color_test_section_wrapper {
                width: 22%;
                margin: 1.5%;
              }
            }

            @media screen and (min-width: 1800px) {
              body {
                font-size: 150%;
              }
            }
          }.squish.html_safe
        }

        body {

          div(class: 'header') {
            a(href: 'https://github.com/dobtco/palat',
              title: 'Fork Palat on Github',
              class: 'logo') {
              img(src: 'logo.png',
                  alt: 'Palat')
            }

            p 'A Ruby gem that generates beautiful, accessible color schemes from a single background&nbsp;color.'.html_safe

            p 'Designed to meet WCAG 2.0 Level AA contrast ratio guidelines.'
          }

          div(class: 'keycodes_wrapper') {
            div(class: 'keycode keycode_tilde') {
              strong '~'
              span 'Toggle variables'
            }

            div(class: 'keycode keycode_e') {
              strong 'e'
              span 'Toggle error state'
            }
          }

          test_color_array.each do |color|
            render_section(color)
          end

          div(class: 'footer') {
            p "Made by <a href='https://www.dobt.co'>The Department of Better Technology.</a>".html_safe
            p { a 'Fork Palat on Github', href: 'https://www.github.com/dobtco/palat/' }
          }
        }

        script(src: 'https://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js')
        script %{
          $(document).on('keydown', function(e){
            if (e.keyCode == 192) {
              $('.debug').toggle();
              $('.keycode_tilde').addClass('is_pressed').on('animationend webkitAnimationEnd MSAnimationEnd oAnimationEnd', function() {
                $('.keycode_tilde').removeClass('is_pressed');
              });
            }
            if (e.keyCode == 69) {
              $('.input').toggle();
              $('.keycode_e').addClass('is_pressed').on('animationend webkitAnimationEnd MSAnimationEnd oAnimationEnd', function() {
                $('.keycode_e').removeClass('is_pressed');
              });
            }
          });
        }.html_safe
      }
    end

    def render_section(color)
      generator = Palat::Generator.new(color)

      div(class: 'color_test_section_wrapper', style: "background-color: #{generator.background_color.to_hex}") {

        div(class: 'color_test_swatch') {
          code generator.background_color.to_hex
        }

        div(class: 'color_test_section') {
          h2('Header', style: "color: #{generator.base_color.to_hex}")
          div(class: 'label') {
            span 'Label ', style: "color: #{generator.base_color.to_hex}"
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
            style: "display: none;
                    color: #{generator.base_color.to_hex};
                    background-color: #{generator.input_background.to_hex}"
          )
        }
      }
    end
  end

  html = PreviewView.new.to_html

  File.write('./index.html', html)
end
