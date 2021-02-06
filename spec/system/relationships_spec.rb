require 'rails_helper'

RSpec.describe "Relationships", type: :system do
  before do
    @user1 = FactoryBot.create(:user)
    @user2 = FactoryBot.create(:user)
  end

  it 'ログインしたユーザーは他ユーザー詳細ページでフォローボタンを確認することができる' do
    #サインイン
    sign_in(@user1)
    #他ユーザー詳細ページへ
    visit user_path(@user2)
    #フォローボタンがあることを確認し、クリックするとRelationshipsのカウントが上がる
    expect{
      find('input[name="commit"]').click
    }.to change { Relationship.count }.by(1)
    #フォロワーに自身の名前が追加されていることを確認
    expect(page).to have_content(@user1.nickname)
    #フォローリストにフォローしたユーザーの名前が追加されていることを確認
    visit user_path(@user1)
    expect(page).to have_content(@user2.nickname)
    #フォローボタン(unfollow)をクリックすると、Relationshipsのカウントが下がる
    visit user_path(@user2)
    expect{
      find('input[name="commit"]').click
    }.to change { Relationship.count }.by(-1)
    #フォロワーの名前から自身の名前が削除されていることを確認
    expect(page).to have_no_content(@user1.nickname)
  end
end
