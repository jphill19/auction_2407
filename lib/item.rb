class Item

    attr_reader :name, :bids

    def initialize(name)
        @name = name
        @bids = Hash.new
    end

end