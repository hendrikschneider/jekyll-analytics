[![Build Status](https://travis-ci.org/hendrikschneider/jekyll-analytics.svg?branch=master)](https://travis-ci.org/hendrikschneider/jekyll-analytics)
![](http://ruby-gem-downloads-badge.herokuapp.com/jekyll-analytics?type=total)

# Jekyll::analytics
Webanalytics for Jekyll. 

There are many tutorials online to add analytics to jekyll by extending the template. Jekyll-analytics is here to take care of this. Just install the plugin, configure it and you are done :)

Jekyll-analytics: Webanalytics made easy.

Supported:
  - [Google Analytics](https://analytics.google.com/analytics/web/)
  - [Piwik](https://piwik.org/)
  - [mPulse](https://www.soasta.com/performance-monitoring/)

## Installation

Add this to your `Gemfile`:

```
gem 'jekyll-analytics'
```
Then execute
```
$ bundle
```
Or install it yourself
```
gem install jekyll-analytics
```

## Configuration
Edit `_config.yml` to use the plugin:
```
gems:
  - jekyll-analytics
```

Configure the plugin in `_config.yml` by adding:

```yml
jekyll_analytics: 
  GoogleAnalytics:          # Add, if you want to track with Google Analytics
    id: UA-123-456          # Required - replace with your tracking id
    anonymizeIp: false      # Optional - Default: false - set to true for anonymized tracking

  Piwik:                    # Add, if you want to track with Piwik
    url: piwik.example.com  # Required - url to piwik installation without trailing /
    siteId: "1234"          # Required - replace with your piwik site id (Write id as string)

  MPulse:                   # Add if you want to track performance with mPulse
    apikey: XXXXX-YYYYY-ZZZZZ-AAAAA-23456   # Required - replace with your mPulse API key
```

## Usage
Tracking will be disabled in development mode. To enable production mode set enviroment variable JEKYLL_ENV=production.
Github pages automatically sets JEKYLL_ENV to production.
For testing use
```
$ JEKYLL_ENV=production jekyll serve
```

## Contributing

1. Fork it ( https://github.com/hendrikschneider/jekyll-analytics/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

How to add support for a new tracker:
1. Create new tracker class in lib/analytics/YourTracker.rb
  ```
  #initialize and render must be implemented!
  class YourTracker
    def initialize(config)
      #validate config
    end

    def render
      return "Tracking code to insert into html > head"
    end
  end
```
2. Update README.md
