class GoogleAnalytics4
    #source: https://developers.google.com/analytics/devguides/collection/analyticsjs/
    SETUP_CODE = """
    <!-- Global site tag (gtag.js) - Google Analytics -->
    <script async src=\"https://www.googletagmanager.com/gtag/js?id=%{measurement_id}\"></script>
    <script>
        window.dataLayer = window.dataLayer || [];
        function gtag(){dataLayer.push(arguments);}
        gtag('js', new Date());

        gtag('config', '%{measurement_id}');
    </script>
    """

    VALID_G_ID_RE = /\A^G-[a-zA-z\d]+\z/
    VALID_UA_ID_RE = /\A(?i)(UA|YT|MO).+$\z/

   def initialize(config)
        if (VALID_UA_ID_RE.match(config["measurement_id"]))
            # The user has used an incompatible ID.
            raise ArgumentError, 'Use a Measurement ID beginning with "G-". IDs starting with "UA" (or "YT", or "MO") are not compatible with Google Analytics 4.'
        end

        if !(VALID_G_ID_RE.match(config["measurement_id"]))
            # The user has used a malformed ID.
            raise ArgumentError, 'A Google Analytics 4 Measurement ID must begin with "G-".'
        end

        @config = Hash[config.map{ |k, v| [k.to_sym, v.to_s] }]
    end

    def render()
        return SETUP_CODE % @config
    end
end