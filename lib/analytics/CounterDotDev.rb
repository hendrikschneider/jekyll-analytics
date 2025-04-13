class CounterDotDev
    def initialize(config)
        if config['source'].nil?
            raise ArgumentError, 'Please use the js "src" found when you add a website in counter.dev.'
        end
        @source = config['source']

        if config['data_id'].nil?
            raise ArgumentError, 'Please use the "data-id" found in the script when you add a website in counter.dev.'
        end
        @data_id = config['data_id']

        if config['data_utc_offset'].nil?
            raise ArgumentError, 'Please add a utc offset for the timezone you would want the data to be in.'
        end
        @data_utc_offset = config['data_utc_offset']
    end

    def render()
        str = """
    <!-- Counter.dev Analytics -->
    <script src=\"#{@source}\" data-id=\"#{@data_id}\" data-utcoffset=\"#{@data_utc_offset}\"></script>
    <!-- End Counter.dev Analytics  -->
"""
        return str
    end
end
