dvl-color
=======

[![RubyGem][gem]](http://rubygems.org/gems/dvl-color)

Generate beautiful, accessible color schemes. Used in [Screendoor](https://www.dobt.co/screendoor/) to allow our users to customize their [public-facing forms](https://dobt.forms.fm).

[View some examples &rarr;](dobtco.github.io/dvl-color)

## Usage

#### 1. Install the gem
```ruby
gem 'dvl-color'
```

#### 2. Generate a color scheme
```ruby
generator = Dvl::Color::Generator.new('#fff') # white background
generator.to_h # prints a bunch of variables
```

[gem]: https://img.shields.io/gem/v/dvl-color.svg

## License

MIT
