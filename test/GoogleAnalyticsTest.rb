require_relative "../lib/analytics/GoogleAnalytics.rb"
require "test/unit"

class TestGoogleAnalytics < Test::Unit::TestCase
    def test_init
        assert_raise( ArgumentError ) { GoogleAnalytics.new( {"id" => "123-456"} ) }
        assert_instance_of(GoogleAnalytics, GoogleAnalytics.new( {"id" => "UA-123-456"} ))
    end

    def test_default_tracking_string
        googleAnalytics = GoogleAnalytics.new( {"id" => "UA-123-456"} )
        assert_equal(googleAnalytics.render(), 
        """
    <!-- Google Analytics -->
    <script>
    (function(i,s,o,g,r,a,m){i['GoogleAnalyticsObject']=r;i[r]=i[r]||function(){
    (i[r].q=i[r].q||[]).push(arguments)},i[r].l=1*new Date();a=s.createElement(o),
    m=s.getElementsByTagName(o)[0];a.async=1;a.src=g;m.parentNode.insertBefore(a,m)
    })(window,document,'script','https://www.google-analytics.com/analytics.js','ga');

    ga('create', 'UA-123-456', 'auto');
\tga('send', 'pageview');
\tga('set', 'anonymizeIp', false);
    </script>
    <!-- End Google Analytics -->
    """)
    end

    def test_anonymize_true
        googleAnalytics = GoogleAnalytics.new( {"id" => "UA-123-456", "anonymizeIp" => true} )
        assert_match(/\('set', 'anonymizeIp', false\);/, googleAnalytics.render())
    end

end