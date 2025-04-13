require_relative "../lib/analytics/CounterDotDev.rb"
require "test/unit"

class TestCounterDotDev < Test::Unit::TestCase
    def test_init
        assert_raise(ArgumentError) { CounterDotDev.new({}) }
        assert_instance_of(CounterDotDev, CounterDotDev.new({
            "source" => "https://cdn.counter.dev/script.js",
            "data_id" => "0006dd92-4e28-4a49-b37e-e76fd3419ffc",
            "data_utc_offset" => "2"
        }))
    end

    def test_default_tracking_string
        counterDotDev = CounterDotDev.new({
            "source" => "https://different.counter.dev/script.js",
            "data_id" => "00000-000000",
            "data_utc_offset" => "2"
        })
        assert_equal(counterDotDev.render(), 
"""
    <!-- Counter.dev Analytics -->
    <script src=\"https://different.counter.dev/script.js\" data-id=\"00000-000000\" data-utcoffset=\"2\"></script>
    <!-- End Counter.dev Analytics  -->
""")
    end

    def test_other_tracking_string
        counterDotDev = CounterDotDev.new({
            "source" => "https://cdn.counter.dev/script.js",
            "data_id" => "1234abcd-5678-efgh-ijkl-9876mnopqrst",
            "data_utc_offset" => "5"
        })
        assert_equal(counterDotDev.render(), 
"""
    <!-- Counter.dev Analytics -->
    <script src=\"https://cdn.counter.dev/script.js\" data-id=\"1234abcd-5678-efgh-ijkl-9876mnopqrst\" data-utcoffset=\"5\"></script>
    <!-- End Counter.dev Analytics  -->
""")
    end
end