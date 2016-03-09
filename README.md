dvl-color
=======

[![RubyGem][gem]](http://rubygems.org/gems/dvl-color)

Add random, unique "pretty" ids to your ActiveRecord models.

## Usage

#### 1. Install the gem
```ruby
gem 'dvl-color'
```

#### 2. Generate a color scheme
```ruby
generator = Dvl::Color::Generator.new('#fff') # white background
generator.to_h
```

[gem]: https://img.shields.io/gem/v/dvl-color.svg
