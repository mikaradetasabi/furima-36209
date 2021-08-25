require 'rails_helper'
RSpec.describe Item, type: :model do
  before do
    @item = FactoryBot.build(:item)
    @item.image = fixture_file_upload('app/assets/images/star.png')
  end

  describe '出品機能' do
    context '出品ができる時' do
      it "必須項目が全てあれば登録できること" do
        expect(@item).to be_valid
      end
      it 'ログイン状態のユーザーのみ、商品出品ページへ遷移できること' do
        @item = FactoryBot.create(:user)
        expect(@item).to be_valid
      end
    end

    context '出品ができない時' do
      it '商品画像を1枚つけることが必須であること' do
        @item.image.key = ''
        @item.valid?
        expect(@item.errors.full_messages).to include{"画像を入力してください"}
      end

      it '商品名が必須であること' do
        @item.product_name = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("商品名を入力してください")
      end

      it '商品の説明が必須であること' do
        @item.description = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("商品の説明を入力してください")
      end

      it 'カテゴリーの情報が必須であること' do
        @item.category_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("カテゴリーの情報を入力してください")
      end

      it '商品の状態についての情報が必須であること' do
        @item.status_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("商品の状態についての情報を入力してください")
      end

      it '配送料の負担についての情報が必須であること' do
        @item.burden_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("配送料の負担についての情報を入力してください")
      end

      it '発送元の地域についての情報が必須であること' do
        @item.delivery_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("発送元の地域についての情報を入力してください")
      end

      it '発送までの日数についての情報が必須であること' do
        @item.days_delivery_id = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("発送までの日数についての情報を入力してください")
      end

      it '販売価格についての情報が必須であること' do
        @item.price = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("販売価格についての情報を入力してください", "販売価格は半角数字のみ保存可能", "売価格は、¥300~¥9,999,999の間のみ保存可能")
      end

      it '販売価格は、¥300~¥9,999,999の間のみ保存可能であること' do
        @item.price = 100
        @item.valid?
        expect(@item.errors.full_messages).to include("Price Out of setting range")
      end

      it '販売価格は半角数字のみ保存可能であること' do
        @item.price = '１００００'
        @item.valid?
        expect(@item.errors.full_messages).to include("販売価格は半角数字で入力してください")
      end

      it '半角英数混合では登録できないこと' do
        @item.price = '３００sdfg'
        @item.valid?
        expect(@item.errors.full_messages).to include("Price can't Half-width alphanumeric")
      end

      it '半角英語だけでは登録できないこと' do
        @item.price = 'sdfg'
        @item.valid?
        expect(@item.errors.full_messages).to include("Price can't Half-width english")
      end

      it '10000000円以上では登録できない' do
        @item.price = 10000001
        @item.valid?
        expect(@item.errors.full_messages).to include("Price can't register with the above")
      end

      it 'userが空では登録できない' do
        @user.email = ''
        @user.valid?
        expect(@user.errors.full_messages).to include("User can't be blank")
      end

      it 'カテゴリーのid=１を選択した場合は登録できない' do
        @item.category_id = 1 
        @item.valid?
        expect(@item.errors.full_messages).to include("Category Select can't be blank")
      end

      it 'カテゴリーのid=１を選択した場合は登録できない' do
        @item.status_id = 1 
        @item.valid?
        expect(@item.errors.full_messages).to include("Status Select can't be blank")
      end

      it 'カテゴリーのid=１を選択した場合は登録できない' do
        @item.burden_id = 1 
        @item.valid?
        expect(@item.errors.full_messages).to include("Burden Select can't be blank")
      end

      it 'カテゴリーのid=１を選択した場合は登録できない' do
        @item.delivery_id = 1 
        @item.valid?
        expect(@item.errors.full_messages).to include("Delivery Select can't be blank")
      end

      it 'カテゴリーのid=１を選択した場合は登録できない' do
        @item.days_delivery_id = 1 
        @item.valid?
        expect(@item.errors.full_messages).to include("Days delivery Select can't be blank")
      end
    end
  end
end