require_relative 'Analytics'

class GoogleAnalytics < Analytics
    #source: https://developers.google.com/analytics/devguides/collection/analyticsjs/
    SETUP_CODE = """
    <!-- Google Analytics -->
    <script>
    (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
    (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
    m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
    })(window,document,'script','https://www.google-analytics.com/analytics.js','ga');

    %s
    </script>
    <!-- End Google Analytics -->
    """

    ID_REGEX = /^UA-\d+-\d+$/    

    INITIALIZE_CODE = "ga('create', '%s', 'auto');"
    PAGEVIEW_CODE = "ga('send', 'pageview');"
    ANONYMIZE_IP_CODE = "ga('set', 'anonymizeIp', %s);"
    
    @@commands = nil
    
    def initialize(config)
        if !(ID_REGEX.match(config["id"]))
            raise ArgumentError, 'Invalid Google analytics key. Id must look like UA-XXXXXX-Y'
        end

        @@commands = []
        @@commands.push(INITIALIZE_CODE % config["id"])
        @@commands.push(PAGEVIEW_CODE)
        self._get_other_commands(config)
    end

    def render()
        return SETUP_CODE % @@commands.join("\n\t")
    end

    def _get_other_commands(config)
        @@commands.push(ANONYMIZE_IP_CODE % config.fetch(:anonymizeIp, false))
    end

end