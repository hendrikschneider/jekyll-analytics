class CloudflareWebAnalytics
    #source: https://support.cloudflare.com/hc/en-us/articles/360052685432-Cloudflare-Web-Analytics
    SETUP_CODE = """
    <!-- Cloudflare Web Analytics -->
    <script defer
    src='https://static.cloudflareinsights.com/beacon.min.js'
    data-cf-beacon='{\"token\": \"%{cf_beacon_token}\"}'></script>
    <!-- End Cloudflare Web Analytics -->
    """

    # Cloudflare Web Analytics site tokens are alphanumeric strings.
    CLOUDFLARE_SITE_TOKEN_RE = /^[a-zA-Z0-9]+$/

    def initialize(config)
        if !(CLOUDFLARE_SITE_TOKEN_RE.match(config['cf_beacon_token']))
            raise ArgumentError, 'Invalid Cloudflare Web Analytics token. Must be alphanumeric string.'
        end

        @config = Hash[config.map{ |k, v| [k.to_sym, v.to_s] }]
    end

    def render
      return SETUP_CODE % @config
    end
end