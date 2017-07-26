class MPulse 
    #source: https://docs.soasta.com/boomerang/#mpulse-loader-snippet
    MPULSE_LOADER = """
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
})(\"%s\");
</script>
<!-- End mPulse -->
"""

    APIKEY_RE = /^[a-zA-Z2-9]{5}-[a-zA-Z2-9]{5}-[a-zA-Z2-9]{5}-[a-zA-Z2-9]{5}-[a-zA-Z2-9]{5}$/

    def initialize(config)
        if !(APIKEY_RE.match(config["apikey"]))
            raise ArgumentError, 'Invalid mPulse API key. Id must look like XXXXX-XXXXX-XXXXX-XXXXX-XXXXX'
        end

        @apikey = config["apikey"]
    end

    def render()
        return MPULSE_LOADER % @apikey
    end
end
