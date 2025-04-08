class CounterDotDev
    def initialize(config)
        if config['user'].nil?
            raise ArgumentError, 'Please use your counter.dev "user"'
        end

        @user = config['user']

    end

    def render()
        str = """
    <!-- Counter.dev Analytics -->
    <script>if(!sessionStorage.getItem(\"_swa\")&&document.referrer.indexOf(location.protocol+\"//\"+location.host)!== 0){fetch(\"https://counter.dev/track?\"+new URLSearchParams({referrer:document.referrer,screen:screen.width+\"x\"+screen.height,user:\"#{@user}\",utcoffset:\"2\"}))};sessionStorage.setItem(\"_swa\",\"1\");</script>
    <!-- End Counter.dev Analytics  -->
"""
        return str
    end
end
