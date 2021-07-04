[![Build Status](https://travis-ci.org/hendrikschneider/jekyll-analytics.svg?branch=master)](https://travis-ci.org/hendrikschneider/jekyll-analytics)
![](http://ruby-gem-downloads-badge.herokuapp.com/jekyll-analytics?type=total)
[![Maintainability](https://api.codeclimate.com/v1/badges/a07904b989dcb7e4e477/maintainability)](https://codeclimate.com/github/hendrikschneider/jekyll-analytics/maintainability)

# Jekyll::analytics
Webanalytics for Jekyll.

There are many tutorials online to add analytics to Jekyll by extending the template. Jekyll-analytics is here to take care of this. Just install the plugin, configure it and you are done :)

Jekyll-analytics: Webanalytics made easy.

Supported:
  - [Google Analytics](https://analytics.google.com/analytics/web/)
  - [Matomo](https://matomo.org/)
  - [Piwik](https://piwik.org/)
  - [mPulse](https://www.soasta.com/performance-monitoring/)
  - [Plausible](https://plausible.io)

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
plugins:
  - jekyll-analytics
```

Configure the plugin in `_config.yml` by adding:

```yml
jekyll_analytics:
  GoogleAnalytics:          # Add, if you want to track with Google Analytics
    id: UA-123-456          # Required - replace with your tracking id
    anonymizeIp: false      # Optional - Default: false - set to true for anonymized tracking

  Matomo:                   # Add, if you want to track with Matomo (former Piwik Analytics)
    url: matomo.example.com # Required - url to Matomo installation without trailing /
    siteId: "1234"          # Required - replace with your Matomo site id (Write id as string)

  Piwik:                    # Add, if you want to track with Piwik
    url: piwik.example.com  # Required - url to Piwik installation without trailing /
    siteId: "1234"          # Required - replace with your Piwik site id (Write id as string)

  MPulse:                   # Add if you want to track performance with mPulse
    apikey: XXXXX-YYYYY-ZZZZZ-AAAAA-23456   # Required - replace with your mPulse API key

  Plausible:
    domain: 'example.com'   # The domain configured in plausible
    source: 'https://plausible.example.com/js/plausible.js' # The source URL of the javascript,
    host: 'https://plausible.example.com' # The base URL of the plausible host, only needed for embed_tracker
    404_tracking: true      # Enable 404 error tracking. Also requires changes to your webserver and 404.md
                            # See https://plausible.io/docs/404-error-pages-tracking for other set up required
    embed_tracker: true     # embed the tracking code instead of loading the javascript; this removes one
                            # call from page loading and circumvents adblockers; this uses `host` to generate
                            # the correct callback destination

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
