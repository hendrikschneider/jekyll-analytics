require_relative 'analytics/GoogleAnalytics'

def inject(site)
  if ENV['JEKYLL_ENV']
    config = site.site.config["jekyll_analytics"]["ga"]
    analytics_object = GoogleAnalytics.new(config)
    site.output = site.output.gsub(/(?=<\/head>)/i, analytics_object.render())
  end
end


Jekyll::Hooks.register :pages, :post_render do |page|
  inject(page)
end

Jekyll::Hooks.register :post, :post_render do |post|
  inject(post)
end

Jekyll::Hooks.register :site, :post_render do |site|
  #puts site.config
  #inject(site)
end