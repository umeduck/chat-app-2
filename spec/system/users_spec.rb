require 'rails_helper'

RSpec.describe "ユーザーログイン機能", type: :system do
  before do
    @user = FactoryBot.build(:user)
  end
  it 'ログインしていない状態でトップページにアクセスした場合、サインインページに移動する' do
    # トップページへ移動する
    visit root_path
    # ログインしていない場合、サインインページに遷移していることを確認する
    expect(current_path).to eq(new_user_session_path)
  end
  it 'ログインに成功し、トップページに遷移する' do
    # ユーザー情報をDBに保存する
    @user.save
    # サインインページへ移動する
    visit new_user_session_path
    #ログインしていない場合、サインインページに遷移していることを確認する
    expect(current_path).to eq(new_user_session_path)
    # すでに保存されているユーザーのemailとpasswordを入力する
    fill_in 'user_email', with: @user.email
    fill_in 'user_password', with: @user.password
    # ログインボタンをクリック
    click_on('Log in')
    # トップページへ遷移していることを確認する
    expect(current_path).to eq(root_path)
  end
  it 'ログインに失敗し、再びサインインページに戻ってくる' do
    # ユーザーをDBに保存する
    @user.save
    # トップページへ遷移する
    visit root_path
    # ログインしていない場合、サインインページに遷移していることを確認する
    expect(current_path).to eq(new_user_session_path)
    # 誤ったユーザー情報を入力する
    fill_in 'user_email', with: 'aaa'
    fill_in 'user_password', with: 'aaa'
    # サインインページに戻ってきていることを確認する
    expect(current_path).to eq(new_user_session_path)
  end
end
