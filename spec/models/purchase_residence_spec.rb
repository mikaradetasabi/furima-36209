require 'rails_helper'

RSpec.describe PurchaseResidence, type: :model do
  before do
    item = FactoryBot.build_stubbed(:item)
    user = FactoryBot.create(:user)
    @purchase_residence = FactoryBot.build(:purchase_residence, user_id: user.id, item_id: item.id)
  end
  describe '購入内容確認' do
    context '内容に問題ない場合' do
      it 'すべての値が正しく入力されていれば保存できること' do
        expect(@purchase_residence).to be_valid
      end

      it 'building_nameは空でも保存できること' do
        @purchase_residence.building_name = ''
        expect(@purchase_residence).to be_valid
      end

    end
    context '内容に問題がある場合' do
      it 'postal_codeが空だと保存できないこと' do
        @purchase_residence.postal_code = ''
        @purchase_residence.valid?
        expect(@purchase_residence.errors.full_messages).to include("Postal code can't be blank")
      end

      it 'postal_codeが半角のハイフンを含んだ正しい形式でないと保存できないこと' do
        @purchase_residence.postal_code = '1234567'
        @purchase_residence.valid?
        expect(@purchase_residence.errors.full_messages).to include("Postal code Input correctly")
      end

      it 'municipalityを空だと保存できないこと' do
        @purchase_residence.municipality = ''
        @purchase_residence.valid?
        expect(@purchase_residence.errors.full_messages).to include("Municipality can't be blank")
      end

      it 'delivery_idが空だと保存できないこと' do
        @purchase_residence.delivery_id = 1
        @purchase_residence.valid?
        expect(@purchase_residence.errors.full_messages).to include("Delivery Select")
      end

      it 'addressが空だと保存できないこと' do
        @purchase_residence.address = ''
        @purchase_residence.valid?
        expect(@purchase_residence.errors.full_messages).to include("Address can't be blank")
      end

      it 'phone_numberが空だと保存できないこと' do
        @purchase_residence.phone_number = ''
        @purchase_residence.valid?
        expect(@purchase_residence.errors.full_messages).to include("Phone number can't be blank")
      end

      it 'phone_numberは10桁以内11桁以上では登録できない' do
        @purchase_residence.phone_number = "090-1234-5678"
        @purchase_residence.valid?
        expect(@purchase_residence.errors.full_messages).to include("Phone number Input only number")
      end

      it 'phone_numberが全角数字だと登録できないこと' do
        @purchase_residence.phone_number = '２０００'
        @purchase_residence.valid?
        expect(@purchase_residence.errors.full_messages).to include("Phone number Input only number")
      end

      it "tokenが空では登録できないこと" do
        @purchase_residence.token = nil
        @purchase_residence.valid?
        expect(@purchase_residence.errors.full_messages).to include("Token can't be blank")
      end

      it 'item_idが空だと保存できないこと' do
        @purchase_residence.item_id = ''
        @purchase_residence.valid?
        expect(@purchase_residence.errors.full_messages).to include("Item can't be blank")
      end

      it 'user_idが空だと保存できないこと' do
        @purchase_residence.user_id = ''
        @purchase_residence.valid?
        expect(@purchase_residence.errors.full_messages).to include("User can't be blank")
      end
    end
  end
end
