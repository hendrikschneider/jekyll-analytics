class Analytics
    def initialize(config)
        raise NotImplementedError, "Implement this method in a child class"
    end

    def render()
        raise NotImplementedError, "Implement this method in a child class"
    end
end