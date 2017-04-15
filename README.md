# Jekyll::analytics
Web analytics for your jekyll site. 
Supported:
  - Google Analytics

## Installation

Add to your `Gemfile`:

```
gem 'jekyll-analytics'
```

Add to your `_config.yml`:

```yml

gems:
  - jekyll-analytics
```

## Configuration
Add to your `_config.yml`:

```yml
jekyll_analytics: {
  ga: {
    id: UA-XXX-YYY,   #Replace UA-XXX-YYY with your google analytics key
    anonymizeIp: false #optional. Set to true if IPs should be anonymized
  }
}
```
## Contributing

1. Fork it ( https://github.com/hendrik91/jekyll_analytics/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
