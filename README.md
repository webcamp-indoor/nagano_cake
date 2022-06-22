# Nagano CAKE（ECサイト）です。


# サービス概要
長野県にある小さな洋菓子店「ながのCAKE」の商品を通販するためのECサイト開発。


# 主な機能

## 一般ユーザー
* 会員登録機能(住所・氏名・連絡先など)
* User ログイン機能
* 退会機能
* アカウント編集
* 商品を購入する機能
* 商品をカートに入れる機能
* 購入した商品を確認できる機能
* 商品レビュー機能（raty.js）
* 購入履歴表示
* 商品検索機能
* ジャンル検索機能

## 管理ユーザー
* 商品を登録する機能
* ジャンルを登録する機能
* 受注一覧
* 受注詳細画面
* ステータス（注文ステータス、製作ステータス、販売ステータス、会員ステータス ）更新
* 顧客一覧
* 顧客の論理削除

## ER図

![indoa_ER図](https://user-images.githubusercontent.com/99533616/174832356-04ceb2d6-df72-47c6-a6f4-653b8271468f.jpg)

# 使用技術
## バックエンド
 * ruby 2.6.3p62 (2019-04-16 revision 67580) [x86_64-linux]
 * Rails 6.1.6
 
## フロントエンド
* HTML
* CSS(SCSS)
* JavaScript(jQuery)
* bootstrap4

# 主な Gem
* gem 'devise'
* gem 'kaminari'
* gem 'better_errors'
* gem 'binding_of_caller'
* gem 'pry-rails'
* gem 'annotate'
* gem "enum_help"


# その他
* raty.js

