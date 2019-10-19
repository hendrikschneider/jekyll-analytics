require_relative "../lib/analytics/Matomo.rb"
require "test/unit"

class MatomoTest < Test::Unit::TestCase
    def test_init
        assert_raise( ArgumentError ) { Matomo.new( {"url" => "my.matomo.server/path/"}) }
        assert_raise( ArgumentError ) { Matomo.new( {"url" => "my.matomo.server/path", "siteId" => "a"}) }
        assert_instance_of(Matomo, Matomo.new( {"url" => "my.matomo.server/path", "siteId" => "1"}) )
    end

    def test_default_tracking_string
        matomoAnalytics = Matomo.new( {"url" => "my.matomo.server/path", "siteId" => "1"})
        assert_equal(matomoAnalytics.render(),
        """
    <!-- Matomo -->

    <!-- Matomo Image Tracker -->
      <img src=\"my.matomo.server/path?idsite=1&amp;rec=1\" style=\"border:0\" alt=\"\" />
    <!-- End Matomo -->


    <script type=\"text/javascript\">
      var _paq = _paq || [];
      _paq.push(['trackPageView']);
      _paq.push(['enableLinkTracking']);
      (function() {
        var u=\'//\'+\"my.matomo.server/path\";
        _paq.push(['setTrackerUrl', u+'/piwik.php']);
        _paq.push(['setSiteId', '1']);
        var d=document, g=d.createElement('script'), s=d.getElementsByTagName('script')[0];
        g.type='text/javascript'; g.async=true; g.defer=true; g.src=u+'/piwik.js'; s.parentNode.insertBefore(g,s);
      })();
    </script>
    <!-- End Matomo Code -->
    """)
    end
end
