require 'rails_helper'

RSpec.describe "Users", type: :system do
  it 'ログインに成功し、トップページに遷移する' do
    #予め、ユーザーをDBへ保存
    @user = FactoryBot.create(:user)
    #サインインへ
    visit new_user_session_path
    #ログインしていない場合、サインインへ
    expect(current_path).to eq new_user_session_path
    #すでに保存されているユーザーのemailとpasswordを入力
    fill_in 'user_email', with: @user.email
    fill_in 'user_password', with: @user.password
    #ログインボタンをクリック
    click_on("Log in")
    #トップページへ
    expect(current_path).to eq root_path
  end

  it 'ログインに失敗し、再びサインインに戻ってくる' do
    #予め、ユーザーをDBへ保存
    @user = FactoryBot.create(:user)
    #サインインへ
    visit new_user_session_path
    #誤ったユーザー情報を入力
    fill_in 'user_email', with: "test"
    fill_in 'user_password', with: "test"
    #ログインボタンをクリック
    click_on("Log in")
    #サインインページに戻ってきていることを確認
    expect(current_path).to eq new_user_session_path
  end
end
