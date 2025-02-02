require './lib/item'
require './lib/auction'
require './lib/attendee'

RSpec.describe Auction do
    before(:each) do
        @auction = Auction.new

        @item1 = Item.new('Chalkware Piggy Bank')
        @item2 = Item.new('Bamboo Picture Frame')
        @item3 = Item.new('Homemade Chocolate Chip Cookies')
        @item4 = Item.new('2 Days Dogsitting')
        @item5 = Item.new('Forever Stamps')

        @attendee1 = Attendee.new({name: 'Megan', budget: '$50'})
        @attendee2 = Attendee.new({name: 'Bob', budget: '$75'})
        @attendee3 = Attendee.new({name: 'Mike', budget: '$100'})

        @auction2 = Auction.new
        @auction2.add_item(@item1)
        @auction2.add_item(@item2)
        @auction2.add_item(@item3)
        @auction2.add_item(@item4)
        @auction2.add_item(@item5)

    end

    describe 'Initialize' do
        it 'exists' do
            expect(@auction).to be_an_instance_of Auction
        end

        it "contains an array for items, since no items, it should be empty" do
            expect(@auction.items).to eq([])
        end

        it "contains an array for attendees, since no attendees, it should be empty" do
            expect(@auction.bidders).to eq([])
        end

        it "contain an emtpy hash to store bidder info" do
            expect(@auction.bidder_info).to eq({})
        end
    end

    describe 'add_item' do
        it 'can add items' do
            @auction.add_item(@item1)
            @auction.add_item(@item2)

            expect(@auction.items).to eq([@item1, @item2])
        end
    end

    describe 'item_names' do
        it 'can return item object names' do
            @auction.add_item(@item1)
            @auction.add_item(@item2)

            expect(@auction.item_names).to eq(["Chalkware Piggy Bank", "Bamboo Picture Frame"])
        end
    end

    describe 'unpopular_items' do
        it "returns items without a bid" do
            @item1.add_bid(@attendee2, 20)
            @item3.add_bid(@attendee1, 22)
            @item5.add_bid(@attendee3, 40)

            expect(@auction2.unpopular_items).to eq([@item2, @item4])
        end
    end

    describe 'potential_revenue' do
        it "returns a sum of all the highest bids" do
            @item1.add_bid(@attendee2, 20)
            @item3.add_bid(@attendee1, 22)
            @item5.add_bid(@attendee3, 40)

            expect(@auction2.potential_revenue).to eq(82)
        end
    end

    describe 'add_bidder' do
        it 'can add bidder to the bidders array, which stores the bidders name' do
            @auction2.add_bidder(@attendee1)
            @auction2.add_bidder(@attendee2)

            expect(@auction2.bidders).to eq(['Megan', 'Bob'])
        end

        it "will create bidder info tab on the attendee" do
            @auction2.add_bidder(@attendee1)
            @auction2.add_bidder(@attendee2)

            expect(@auction2.bidder_info).to eq({
                @attendee1 => {
                    :budget => 50,
                    :items => []
                },
                @attendee2 => {
                    :budget => 75,
                    :items => []
                }
            })
        end
    end

    describe "update_bidder_info_items" do

        it "will update bidder_info to contain all the items that the atteendees have bid on" do
            @auction2.add_bidder(@attendee1)
            @auction2.add_bidder(@attendee2)

            @item3.add_bid(@attendee1, 20)
            @item4.add_bid(@attendee1, 30)

            @item3.add_bid(@attendee2, 25)
            @item1.add_bid(@attendee2,45)

            @auction2.update_bidder_info_items
            expect(@auction2.bidder_info).to eq({
                @attendee1 => {
                    :budget => 50,
                    :items => [@item3, @item4]
                },
                @attendee2 => {
                    :budget => 75,
                    :items => [@item1,@item3]
                }
            })
        end
    end

    describe 'close_auction' do
        it "will close the auction for all items" do
            @auction2.add_bidder(@attendee1)
            @auction2.add_bidder(@attendee2)

            @item3.add_bid(@attendee1, 30)
            @item4.add_bid(@attendee1, 30)
            @item5.add_bid(@attendee1, 40)

            @item3.add_bid(@attendee2, 25)
            @item1.add_bid(@attendee2,45)

            @auction2.update_bidder_info_items
            expect(@auction2.close_auction).to eq({
                @item1 => @attendee2,
                @item2 => 'Not Sold',
                @item3 => @attendee1,
                @item4 => 'Not Sold',
                @item5 => 'Not Sold'
            })
        end
    end
end