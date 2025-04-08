require_relative "../lib/analytics/CounterDotDev.rb"
require "test/unit"

class TestCounterDotDev < Test::Unit::TestCase
    def test_init
        assert_raise( ArgumentError ) { CounterDotDev.new() }
        assert_instance_of(CounterDotDev, CounterDotDev.new( {"user" => "SomeUser"} ))
    end

    def test_default_tracking_string
        counterDotDev = CounterDotDev.new( {"user" => "SomeUser"} )
        assert_equal(counterDotDev.render(), 
'''
    <!-- Counter.dev Analytics -->
    <script>if(!sessionStorage.getItem("_swa")&&document.referrer.indexOf(location.protocol+"//"+location.host)!== 0){fetch("https://counter.dev/track?"+new URLSearchParams({referrer:document.referrer,screen:screen.width+"x"+screen.height,user:"SomeUser",utcoffset:"2"}))};sessionStorage.setItem("_swa","1");</script>
    <!-- End Counter.dev Analytics  -->
''')
    end

    def test_other_tracking_string
        counterDotDev = CounterDotDev.new( {"user" => "SomeOtherUser"} )
        assert_equal(counterDotDev.render(), 
'''
    <!-- Counter.dev Analytics -->
    <script>if(!sessionStorage.getItem("_swa")&&document.referrer.indexOf(location.protocol+"//"+location.host)!== 0){fetch("https://counter.dev/track?"+new URLSearchParams({referrer:document.referrer,screen:screen.width+"x"+screen.height,user:"SomeOtherUser",utcoffset:"2"}))};sessionStorage.setItem("_swa","1");</script>
    <!-- End Counter.dev Analytics  -->
''')
    end

end