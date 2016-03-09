![palat logo](https://dobt-captured.s3.amazonaws.com/ajb/palat_logo.png)

[![RubyGem][gem]](http://rubygems.org/gems/palat)

Generate beautiful, accessible color schemes from a single background color. Used in [Screendoor](https://www.dobt.co/screendoor/) to allow our users to customize their [public-facing forms](https://dobt.forms.fm).

[View some examples &rarr;](https://dobtco.github.io/palat)

## Usage

#### 1. Install the gem
```ruby
gem 'palat'
```

#### 2. Generate a color scheme
```ruby
generator = Palat::Generator.new('#fff') # white background
generator.to_h # prints a bunch of variables
```

[gem]: https://img.shields.io/gem/v/palat.svg

## License

MIT
