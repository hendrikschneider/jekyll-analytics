require_relative "../lib/analytics/MPulse.rb"
require "test/unit"

class TestMPulse < Test::Unit::TestCase
    def test_init
        assert_raise( ArgumentError ) { MPulse.new( {"apikey" => "XXXXX-YYYYY-ZZZZZ-13456"} ) }
        assert_instance_of(MPulse, MPulse.new( {"apikey" => "XXXXX-YYYYY-ZZZZZ-AAAAA-23456"} ))
    end

    def test_default_tracking_string
        mpulse = MPulse.new( {"apikey" => "XXXXX-YYYYY-ZZZZZ-AAAAA-23456"} )
	@rendered = mpulse.render().split("\n")
        @expected = """
<!-- mPulse -->
<script>
(function(API_KEY){
    if (window.BOOMR && window.BOOMR.version) { return; }
    var dom, doc, where, iframe = document.createElement(\"iframe\"), win = window;

    function boomerangSaveLoadTime(e) {
        win.BOOMR_onload=(e && e.timeStamp) || new Date().getTime();
    }

    if (win.addEventListener) {
        win.addEventListener(\"load\", boomerangSaveLoadTime, false);
    } else if (win.attachEvent) {
        win.attachEvent(\"onload\", boomerangSaveLoadTime);
    }

    iframe.src = \"javascript:void(0)\";
    iframe.title = \"\";
    iframe.role = \"presentation\";
    (iframe.frameElement || iframe).style.cssText = \"width:0;height:0;border:0;display:none;\";
    where = document.getElementsByTagName(\"script\")[0];
    where.parentNode.insertBefore(iframe, where);

    try {
        doc = iframe.contentWindow.document;
    } catch(e) {
        dom = document.domain;
        iframe.src = \"javascript:var d=document.open();d.domain='\"+dom+\"';void(0);\";
        doc = iframe.contentWindow.document;
    }

    doc.open()._l = function() {
        var js = this.createElement(\"script\");
        if (dom) { this.domain = dom; }
        js.id = \"boomr-if-as\";
        js.src = \"https://s.go-mpulse.net/boomerang/\" + API_KEY;
        BOOMR_lstart = new Date().getTime();
        this.body.appendChild(js);
    };
    doc.write('<body onload=\"document._l();\">');
    doc.close();
})(\"XXXXX-YYYYY-ZZZZZ-AAAAA-23456\");
</script>
<!-- End mPulse -->
""".split("\n")

        @expected.zip(@rendered).each do | exp, act |
            assert_equal(act, exp)
        end

    end

end
