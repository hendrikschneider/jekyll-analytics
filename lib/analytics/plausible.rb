class Plausible
    def initialize(config)
        @domain = config['domain']
        @source = config['source']
        @not_found = !!config['404_tracking']
    end

    def render()
        tag = "<script async defer data-domain=\"#{@domain}\" src=\"#{@source}\"></script>"
        if @not_found
            tag += "<script>window.plausible = window.plausible || function() { (window.plausible.q = window.plausible.q || []).push(arguments) }</script>"
        end
        return tag
    end
end
