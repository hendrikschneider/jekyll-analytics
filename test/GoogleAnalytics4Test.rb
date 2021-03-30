require_relative "../lib/analytics/GoogleAnalytics4.rb"
require "test/unit"

class GoogleAnalytics4Test < Test::Unit::TestCase
    def test_init
        # Measurement ID must begin with a `G-`.
        assert_raise( ArgumentError ) { GoogleAnalytics4.new( {"measurement_id" => "1234567890"} ) }

        # Measurement ID must not begin with a `UA-`, `YT-`, or `MO-` (Legacy Google Analytics).
        # User should be informed of their error and the fix.
        assert_raise( ArgumentError ) { GoogleAnalytics4.new( {"measurement_id" => "UA-12346789-0"} ) } # Valid UA
        assert_raise( ArgumentError ) { GoogleAnalytics4.new( {"measurement_id" => "UA-12346789"} ) } # Invalid UA
        assert_raise( ArgumentError ) { GoogleAnalytics4.new( {"measurement_id" => "YT-1234-56"} ) } # Valid YT
        assert_raise( ArgumentError ) { GoogleAnalytics4.new( {"measurement_id" => "MO-1-1"} ) } # Valid MO

        # Measurement ID begins with `G-` and is followed by digits.
        assert_instance_of(GoogleAnalytics4, GoogleAnalytics4.new( {"measurement_id" => "G-1234567890"} ))
    end

    def test_default_tracking_string
        googleAnalytics4 = GoogleAnalytics4.new( {"measurement_id" => "G-1234567890"} )
        assert_equal(googleAnalytics4.render(),
        """
    <!-- Global site tag (gtag.js) - Google Analytics -->
    <script async src=\"https://www.googletagmanager.com/gtag/js?id=G-1234567890\"></script>
    <script>
        window.dataLayer = window.dataLayer || [];
        function gtag(){dataLayer.push(arguments);}
        gtag('js', new Date());

        gtag('config', 'G-1234567890');
    </script>
    """)
    end
end