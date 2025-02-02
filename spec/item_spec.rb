
require './lib/item'
require './lib/attendee'


RSpec.describe Item do
    before(:each) do
        @item1 = Item.new('Chalkware Piggy Bank')
        @item2 = Item.new('Bamboo Picture Frame')

        @attendee1 = Attendee.new({name: 'Megan', budget: '$50'})
        @attendee2 = Attendee.new({name: 'Bob', budget: '$75'})
        @attendee3 = Attendee.new({name: 'Mike', budget: '$100'})
    end

    describe 'Initialize' do
        it 'exists' do
            expect(@item1).to be_an_instance_of Item
        end

        it "stores names" do
            expect(@item1.name).to eq('Chalkware Piggy Bank')
            expect(@item2.name).to eq('Bamboo Picture Frame')
        end

        it "generates an emtpy hash for bids" do
            expect(@item1.bids).to eq({})
        end

    end

    describe 'add_bid' do
        it "add bids" do
            @item1.add_bid(@attendee2, 20)
            @item1.add_bid(@attendee1, 22)

            expect(@item1.bids).to eq({
                @attendee2 => 20,
                @attendee1 => 22
            })
        end
    end

    describe 'current_high_bid' do
        it "returns highest bid" do
            @item1.add_bid(@attendee2, 20)
            @item1.add_bid(@attendee1, 22)
            
            expect(@item1.current_high_bid).to eq(22)
        end

        it "returns 0 if no bids have been placed" do
            expect(@item2.current_high_bid).to eq(0)
        end
    end

    describe "close_bidding" do
        it "closes the items bidding by returning false" do
            @item1.close_bidding

            expect(@item1.add_bid(@attendee1, 20)).to eq(false)
            expect(@item1.bids).to eq ({})
        end
    end

end