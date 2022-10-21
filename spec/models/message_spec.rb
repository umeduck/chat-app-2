require 'rails_helper'

RSpec.describe Message, type: :model do
  before do
    @message = FactoryBot.build(:message)
  end

  describe 'メッセージ投稿' do
    context 'メッセージ投稿できる' do
      it 'contentとimageが存在すれば投稿できる' do
        expect(@message).to be_valid
      end
      it 'contentが空でも投稿できる' do
        @message.content = ''
        expect(@message).to be_valid
      end
      it 'imageが空でも投稿できる' do
        @message.image = nil
        expect(@message).to be_valid
      end
    end
    context 'メッセージ投稿できない場合' do
      it 'contentとimageが存在しなければ投稿できない' do
        @message.content = ''
        @message.image = nil
        @message.valid?
        expect(@message.errors.full_messages).to include("Content can't be blank")
      end
      it 'roomが紐づいていないと投稿できない' do
        @message.room = nil
        @message.valid?
        expect(@message.errors.full_messages).to include("Room must exist")
      end
      it 'userが紐づいていないと投稿できない' do
        @message.user = nil
        @message.valid?
        expect(@message.errors.full_messages).to include("User must exist")
      end
    end
  end
end
