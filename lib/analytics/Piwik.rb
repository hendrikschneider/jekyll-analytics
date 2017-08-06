class Piwik
    SETUP_CODE = """
    <!-- Piwik -->
    <script type=\"text/javascript\">
    var _paq = _paq || [];
    _paq.push(['trackPageView']);
    _paq.push(['enableLinkTracking']);
    (function() {
    var u='//'+\"%{url}\";
    _paq.push(['setTrackerUrl', u+'/piwik.php']);
    _paq.push(['setSiteId', '%{siteId}']);
    var d=document, g=d.createElement('script'), s=d.getElementsByTagName('script')[0];
    g.type='text/javascript'; g.async=true; g.defer=true; g.src=u+'/piwik.js'; s.parentNode.insertBefore(g,s);
    })();
    </script>
    <!-- End Piwik Code -->
    """


    # domain name (characters separated by a dot), optional port, optional URI path, no slash
    DOMAINPATH_RE = /^(([^.\/?#@:]+\.)*[^.\/?#@:]+)+(:[0-9]+)?(\/[^\/?#@:]+)*$/

    # numeric ID
    SITEID_RE = /^\d+$/

    def initialize(config)
        
        if !(DOMAINPATH_RE.match(config['url']))
            raise ArgumentError, 'Invalid url. Must be a domain name, optionally followed by an URI path, no trailing slash (e.g. piwik.example.com or my.piwik.server/path)'
        end

        if !(SITEID_RE.match(config['siteId']))
            raise ArgumentError, 'Invalid site id. Must be a number.'
        end
        
        @config = Hash[config.map{ |k, v| [k.to_sym, v.to_s] }]

    end

    def render
        return SETUP_CODE % @config
    end
end
