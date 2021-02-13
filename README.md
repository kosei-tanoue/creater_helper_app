# README

# アプリケーション名
  Creater_Helper_App


# 概要
  自分にはないスキルを他の誰かに依頼することを目的としたアプリ。
  簡単な内容の依頼を掲示板に投稿し、興味を持ったユーザー同士でコミュニケーションを取るきっかけを作ることができる。


# URL
[creater_helper](https://stark-everglades-90094.herokuapp.com/)

# テスト用アカウント
## テスター1
  name: test1
  email: test@1
  password: aaaaaa


## テスター2
  name: test2
  email: test@2
  password: aaaaaa

# 利用方法
  作成したアカウントでログインした後にTOPページへと遷移する。
  新規で依頼を投稿する場合は、ヘッダー部分の新規投稿で投稿することができる。
  またTOPページにある「依頼一覧」で全てのユーザーが投稿した依頼がまとめて表示される。
  「チャットルーム」では、興味を持ったユーザーと直接コミュニケーションを取れるチャット機能を実装している。
  またユーザーのフォロー機能を実装しており、気に入ったユーザーをフォローすることもできる。


# 目指した課題解決
  このアプリケーションで自分にはないスキルで思うような制作ができないクリエイターの悩みを解決を目指した。


# 要件定義

## トップページ
  依頼一覧、チャットルームへ移動できる窓口のページ。
  [トップページ](https://gyazo.com/f7114664f2b76d7b7f8b61e5b0461b46)

## ユーザー管理機能
  deviseを使用したログイン、ログアウト、サインインの機能を実装。
  最低限の情報(名前、メールアドレス、パスワード)を登録し、保存する。
  [ログイン](https://gyazo.com/733e7a495a1754f9e56dd0e9aa2c7b4b)
  [ログアウト](https://gyazo.com/6d9cb0a8e9600210273c2fe6fb3cf6fd)
  [サインイン](https://gyazo.com/b1166383050fecdc04371691c78e9fa1)

## 依頼投稿
  簡潔なタイトル、内容の依頼を投稿することが出来るページ。
  短いタイトル、内容でも他のユーザーが理解できるように補足情報としてカテゴリーを選択することが出来る。
  あくまでチャットで本題を話すことを促したいので、ここでは簡潔な内容でしか投稿できないようにする。
  [依頼投稿](https://gyazo.com/fa296f9688da14bf3f51acbcc91c092e)

## 依頼一覧
  全ユーザーが投稿した依頼を表示するページを実装。
  依頼のタイトルをクリックすると、個別の依頼ページへと移動しコメントを投稿することができる。
  [依頼一覧](https://gyazo.com/47f6f32cf270576100919727e2da06c8)

## フォロー機能
  依頼を見て、興味を持ったユーザーをフォローする機能。
  他ユーザーのページにフォローボタンを設置し、クリックすることでフォロー、アンフォローすることができる。
  自分のユーザーページでは、フォローした人、フォロワー、それらの人数が表示される。
  [フォロー](https://gyazo.com/a63e79f0f3f4dcaa2626af9770550cd0)
  [アンフォロー](https://gyazo.com/9a0abfa7ce68f1a85193586d0de11986)

## チャット機能
  依頼を見たユーザーが直接1対1でコミュニケーションをとることが出来る。
  チャットルームの名前を入力し、直接コミュニケーションを取りたいユーザーを選択すると、部屋を作成することが出来る。
  チャットルームでは、画像を投稿することもできる。
  [チャットルーム作成](https://gyazo.com/af54a5e398b3dc909117e520b950c949)
  [チャット](https://gyazo.com/7ffba1b1076485268d1d6d539561173e)


# 実装予定の機能
  1対1でのコミュニケーションでしか実装していないため、チームで制作したいユーザーに対応するために大部屋のようなチャットルームを実装したい。


# データベース設計

## users テーブル
| Columns  | Type   | Options     | 
| -------- | ------ | ----------- | 
| nickname | string | null: false | 
| email    | string | null: false | 
| password | string | null: false | 

### Association
- has_many :requests
- has_many :comments

- has_many :room_users
- has_many :rooms, through: :room_users
- has_many :messages

- has_many :relationships
- has_many :followings, through: :relationships, source: :follow

- has_many :reverse_of_relationships, class_name: 'Relationship', foreign_key: 'follow_id'
- has_many :followers, through: :reverse_of_relationships, source: :user


## requests テーブル
| Columns     | Type       | Options           | 
| ----------- | ---------- | ----------------- | 
| name        | string     | null: false       | 
| title       | string     | null :false       | 
| text        | string     | null: false       | 
| category_id | integer    | null: false       | 
| user_id     | references | foreign_key: true | 


### Association
- belongs_to :user
- has_many :comments, dependent: :destroy


## comments テーブル
| Columns    | Type    | Options | 
| ---------- | ------- | ------- | 
| user_id    | integer |         | 
| request_id | integer |         | 
| text       | string  |         | 

### Association
- belongs_to :user
- belongs_to :request


## rooms テーブル
| Columns | Type   | Options     | 
| ------- | ------ | ----------- | 
| name    | string | null: false | 

### Association
- has_many :room_users, dependent: :destroy
- has_many :users, through: :room_users
- has_many :messages, dependent: :destroy


## room_users テーブル
| Columns | Type       | Options                        | 
| ------- | ---------- | ------------------------------ | 
| room    | references | null: false, foreign_key: true | 
| user    | references | null: false, foreign_key: true | 

### Association
- belongs_to :user
- belongs_to :room


## messages テーブル
| Columns | Type       | Options                        | 
| ------- | ---------- | ------------------------------ | 
| content | string     |                                | 
| room    | references | null: false, foreign_key: true | 
| user    | references | null: false, foreign_key: true | 

### Association
- belongs_to :user
- belongs_to :room


## relationships テーブル
| Columns   | Type       | Options                           | 
| --------- | ---------- | --------------------------------- | 
| user_id   | references | foreign_key: true                 | 
| follow_id | references | foreign_key: { to_table: :users } | 

### Association
- belongs_to :user
- belongs_to :follow, class_name: 'User'


# ローカルでの動作方法
## 開発環境
  OS
  macOS Catalina バージョン 10.15.6

  rubyバージョン
  ruby 2.6.5p114 (2019-10-01 revision 67812) x86_64-darwin19

  MySQLバージョン
  mysql  Ver 14.14 Distrib 5.6.47

  Railsバージョン
  Rails 6.0.3.4

  RubyGemバージョン
  3.0.3
  

## ダウンロード
  ターミナルでダウンロードしたいディレクトリ上で
  git clone https://github.com/kosei-tanoue/creater_helper_app.git

  ターミナルでダウンロードしたディレクトリへ移動し、「rails s」コマンドを実行後「localhost:3000」へアクセス。