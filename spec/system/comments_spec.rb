require 'rails_helper'

RSpec.describe "Comments", type: :system do
  before do
    @request1 = FactoryBot.create(:request)
    @comment = Faker::Lorem.sentence
  end

  it 'ログインしたユーザーは依頼詳細ページでコメント投稿ができる' do
    #ログイン
    sign_in(@request1.user)
    # 依頼詳細ページに遷移
    visit request_path(@request1)
    #フォームに情報を入力
    fill_in 'comment_text', with: @comment
    # コメントを投稿すると、Commentモデルのカウントが1上がることを確認する
    expect{
      find('input[name="commit"]').click
    }.to change { Comment.count }.by(1)
    # 詳細ページにリダイレクト
    expect(current_path).to eq request_path(@request1)
    # #詳細ページに投稿したコメントが含まれているかを確認する
    expect(page).to have_content(@comment)
  end
end
