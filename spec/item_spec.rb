
require './lib/item'

RSpec.describe Item do
    before(:each) do
        @item1 = Item.new('Chalkware Piggy Bank')
    end

    describe 'Initialize' do
        it 'exists' do
            expect(@item1).to be_an_instance_of Item
        end
    end

end