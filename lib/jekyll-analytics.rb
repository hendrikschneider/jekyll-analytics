Dir[File.dirname(__FILE__) + '/analytics/*.rb'].each {|file| require file[0..-4] }

CONFIG_KEY = "jekyll_analytics"

def inject(site)
  if ENV['JEKYLL_ENV'] and site.site.config.has_key? CONFIG_KEY
    site.site.config[CONFIG_KEY].keys().each{ |a|
      analyzerClass = Module.const_get(a)
      config = site.site.config[CONFIG_KEY][a]
      analytics_object = analyzerClass.new(config)
      site.output = site.output.gsub(/(?=<\/head>)/i, analytics_object.render())
    }
  end
end

Jekyll::Hooks.register :pages, :post_render do |page|
  inject(page)
end

Jekyll::Hooks.register :posts, :post_render do |post|
  inject(post)
end

Jekyll::Hooks.register :site, :post_render do |site|
  #puts site.config
  #inject(site)
end
