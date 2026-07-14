class Umami
  DEFAULT_SOURCE = "https://cloud.umami.is/script.js"

  ATTRIBUTE_MAP = {
    "website_id"     => "data-website-id",
    "host"           => "data-host-url",
    "domains"        => "data-domains",
    "auto_track"     => "data-auto-track",
    "tag"            => "data-tag",
    "do_not_track"   => "data-do-not-track",
    "exclude_search" => "data-exclude-search",
    "exclude_hash"   => "data-exclude-hash",
    "performance"    => "data-performance"
  }.freeze

  def initialize(config)
    @config = config || {}
  end

  def render()
    source = @config["source"] || DEFAULT_SOURCE
    attributes = %W[defer src=\"#{source}\"]
    ATTRIBUTE_MAP.each do |key, attr|
      value = @config[key]
      attributes << "#{attr}=\"#{value}\"" unless value.nil?
    end
    "<script #{attributes.join(' ')}></script>"
  end
end
