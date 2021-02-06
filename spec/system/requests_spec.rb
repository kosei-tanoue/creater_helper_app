require 'rails_helper'

RSpec.describe "Requests", type: :system do
  before do
    @user = FactoryBot.create(:user)
    @request_text = Faker::Lorem.sentence
  end

  context '依頼投稿ができる時' do
    it 'ログインしたユーザーは新規投稿できる' do
      # ログイン
      visit new_user_session_path
      sign_in(@user)
      #新規投稿ページへのリンクがあることを確認
      expect(page).to have_content('投稿する')
      #投稿ページへ
      visit new_request_path
      #フォームに情報を入力
      fill_in 'request[title]', with: @request_text
      fill_in 'request_text', with: @request_text
      select '作詞依頼', from: 'request_category_id'
      #送信
      expect{
        find('input[name="commit"]').click
      }.to change { Request.count }.by(1)
      #送信後、トップページへ
      expect(current_path).to eq(root_path)
      #記事一覧ページに遷移して、記事が存在するかを確認
      visit requests_path
      expect(page).to have_content(@request_text)
    end
  end
  context '依頼投稿が失敗する時' do
    it 'ログインしていないと新規投稿ページに遷移できない' do
      visit root_path
      expect(page).to have_no_content('投稿する')
    end
  end
end

RSpec.describe '依頼編集', type: :system do
  before do
    @request1 = FactoryBot.create(:request)
    @request2 = FactoryBot.create(:request)
  end

  context '編集ができる時' do
    it 'ログインしたユーザーは自分が投稿した依頼の編集ができる' do
      #request1を投稿したユーザーでログイン
      sign_in(@request1.user)
      #編集ボタンがあるかを確認する
      visit request_path(@request1.id)
      expect(page).to have_content('編集')
      #編集ページへ
      visit edit_request_path(@request1)
      #既に投稿済みの内容がフォームに入っているかを確認
      expect(
        find('#request_title').value
      ).to eq(@request1.title)
      expect(
        find('#request_text').value
      ).to eq(@request1.text)
      #投稿内容を編集
      fill_in 'request_title', with: "#{@request1.title}+編集"
      fill_in 'request_text', with: "#{@request1.text}+編集したテキスト"
      select '作曲依頼', from: 'request_category_id'
      #編集してもRequestモデルのカウントは変わらないことを確認する
      expect{
        find('input[name="commit"]').click
      }.to change { Request.count }.by(0)
      #編集後記事投稿一覧へ
      expect(current_path).to eq requests_path
      #編集した記事が存在するかどうかを確認する
      expect(page).to have_content("#{@request1.title}+編集")
      expect(page).to have_content("#{@request1.text}+編集したテキスト")
    end
  end

  context '編集ができない時' do
    it 'ログインしたユーザーは自分以外が投稿した依頼の編集画面には遷移できない' do
      sign_in(@request1.user)
      #@request2に編集リンクがないことを確認
      visit request_path(@request2.id)
      expect(page).to have_no_content('編集')
    end
    it 'ログインしていないと編集画面には遷移できない' do
      visit request_path(@request1.id)
      expect(page).to have_no_content('編集')
    end
  end
end

RSpec.describe '依頼削除', type: :system do
  before do
    @request1 = FactoryBot.create(:request)
    @request2 = FactoryBot.create(:request)
  end
  context '依頼削除ができる時' do
    it 'ログインしたユーザーは自らが投稿した依頼の削除ができる' do
      sign_in(@request1.user)
      #@request1のページに削除リンクがあることを確認し、削除。モデルのカウントが減ることを確認
      visit request_path(@request1.id)
      expect{
        find_link('削除', href: request_path(@request1)).click
      }.to change { Request.count }.by(-1)
      #削除後、記事一覧へ。記事が消えていることを確認
      expect(current_path).to eq requests_path
      expect(page).to have_no_content(@request1.title)
      expect(page).to have_no_content(@request1.text)
    end
  end
  context '依頼が削除できない時' do
    it 'ログインしたユーザーは自分以外が投稿した依頼の削除ができない' do
      sign_in(@request1.user)
      #@request2に削除リンクがないことを確認
      visit request_path(@request2.id)
      expect(page).to have_no_content('削除')
    end
    it 'ログインしていないと削除ボタンが見つからない' do
      visit request_path(@request1.id)
      expect(page).to have_no_content('削除')
    end
  end
end

RSpec.describe '依頼詳細', type: :system do
  before do
    @request3 = FactoryBot.create(:request)
  end
  it 'ログインしたユーザーは依頼詳細ページに遷移してコメントが表示される' do
    sign_in(@request3.user)
    #リクエストの詳細ページに遷移
    visit request_path(@request3)
    expect(page).to have_content(@request3.title)
    expect(page).to have_content(@request3.text)
    #コメント用のフォームが存在する
    expect(page).to have_selector 'form'
  end
  it 'ログインしていない状態で依頼詳細ページに遷移できるがコメント投稿欄が表示されない' do
    visit request_path(@request3)
    expect(page).to have_content(@request3.title)
    expect(page).to have_content(@request3.text)
    #コメント用のフォームがない
    expect(page).to have_no_selector 'form'
    #「コメントの渡航には新規登録/ログインが必要です」が表示されていることを確認する
    expect(page).to have_content 'コメントの投稿には新規登録/ログインが必要です'
  end
end