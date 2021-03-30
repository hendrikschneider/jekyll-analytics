require_relative "../lib/analytics/CloudflareWebAnalytics.rb"
require "test/unit"

class CloudflareWebAnalyticsTest < Test::Unit::TestCase
    def test_init
        # Token must be supplied.
        assert_raise( ArgumentError ) { CloudflareWebAnalytics.new() }

        # Token must be alphanumeric.
        assert_raise( ArgumentError ) { CloudflareWebAnalytics.new( {"cf_beacon_token" => "_1a2345b6c789012defgh23456ij7890"} ) }
        assert_instance_of(CloudflareWebAnalytics, CloudflareWebAnalytics.new( {"cf_beacon_token" => "01a2345b6c789012defgh23456ij7890"} ))
    end

    def test_default_tracking_string
        cloudflareWebAnalytics = CloudflareWebAnalytics.new( {"cf_beacon_token" => "01a2345b6c789012defgh23456ij7890"} )

        # Script renders correctly.
        assert_equal(cloudflareWebAnalytics.render(),
        """
    <!-- Cloudflare Web Analytics -->
    <script defer
    src='https://static.cloudflareinsights.com/beacon.min.js'
    data-cf-beacon='{\"token\": \"01a2345b6c789012defgh23456ij7890\"}'></script>
    <!-- End Cloudflare Web Analytics -->
    """)
    end
end