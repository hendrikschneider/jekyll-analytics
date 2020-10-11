class Plausible
    def initialize(config)
        @domain = config['domain']
        @source = config['source']
    end

    def render()
        return "<script async defer data-domain=\"#{@domain}\" src=\"#{@source}\"></script>"
    end
end
