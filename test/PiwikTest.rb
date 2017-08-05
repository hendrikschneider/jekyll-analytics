require_relative "../lib/analytics/Piwik.rb"
require "test/unit"

class PiwikTest < Test::Unit::TestCase
    def test_init
        assert_raise( ArgumentError ) { Piwik.new( {"url" => "my.piwik.server/path/"}) }
        assert_raise( ArgumentError ) { Piwik.new( {"url" => "my.piwik.server/path", "siteId" => "a"}) }
        assert_instance_of(Piwik, Piwik.new( {"url" => "my.piwik.server/path", "siteId" => "1"}) )
    end

    def test_default_tracking_string
        piwikAnalytics = Piwik.new( {"url" => "my.piwik.server/path", "siteId" => "1"})
        assert_equal(piwikAnalytics.render(), 
        """
    <!-- Piwik -->
    <script type=\"text/javascript\">
    var _paq = _paq || [];
    _paq.push(['trackPageView']);
    _paq.push(['enableLinkTracking']);
    (function() {
    var u=\'//\'+\"my.piwik.server/path\";
    _paq.push(['setTrackerUrl', u+'/piwik.php']);
    _paq.push(['setSiteId', '1']);
    var d=document, g=d.createElement('script'), s=d.getElementsByTagName('script')[0];
    g.type='text/javascript'; g.async=true; g.defer=true; g.src=u+'/piwik.js'; s.parentNode.insertBefore(g,s);
    })();
    </script>
    <!-- End Piwik Code -->
    """)
    end
end
