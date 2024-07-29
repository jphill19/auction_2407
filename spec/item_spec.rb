
require './lib/item'

RSpec.describe Item do
    before(:each) do
        @item1 = Item.new('Chalkware Piggy Bank')
        @item2 = Item.new('Bamboo Picture Frame')
    end

    describe 'Initialize' do
        it 'exists' do
            expect(@item1).to be_an_instance_of Item
        end

        it "stores names" do
            expect(@item1.name).to eq('Chalkware Piggy Bank')
            expect(@item2.name).to eq('Bamboo Picture Frame')
        end
    end


    

end