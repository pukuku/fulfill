# Fulfill!

## サイト概要
【Fulfill!】は目標達成アプリです。
目標の設定とタスクの完了度や充実度を評価することでユーザーの目標の実現を支援し、ユーザーの人生を充実させることを目的としております。
***
--機能一覧--
・目標とタスクの設定
ユーザーは設定した目標に対して曜日ごとにタスクを設定することができます。
毎日0時に目標詳細ページにてその日に設定したタスクが表示され、完了したタスクにはチェックをいれます。

・完了度と充実度の判定
完了したタスクにチェックを入れ、一日の最後にコメントを記入することで、充実度とタスク完了度を評価します。充実度の判定にはGoogleが提供するNatural LanguageAPIを利用します。
評価された充実度と達成度、記述したコメントについてはカレンダーで振り返ることができます。

・目標とタスクのシェア
目標はタスクとセットで他のユーザーに公開することができます。
公開する際にはカテゴリの選択と説明を記載します。
気に入った目標やタスクはコピーして自分流にアレンジしたり、クリップ（お気に入り）していつでも確認することができます。
***

### サイトテーマ
どんな目標でも達成までサポートするアプリ

### テーマを選んだ理由
ダイエットならダイエットアプリ、勉強なら勉強のアプリ、目的ごとに進捗管理をするアプリは多くありますが、下記のような点が気になっておりました。
***
*アプリをいくつも開くのが面倒。。
*アプリごとに使い方が違うから管理の仕方がまとまらない
*そもそもホーム画面にアイコンがかさばって何があるか忘れてしまう
***
様々な目標を一元管理することで上記課題を解決して継続しやすくし、充実度や達成度の可視化でモチベーションをキープできるアプリがあると良いと思い作成しました。

### ターゲットユーザ
貯金をしたい人　ダイエットをしたい人　資格を取りたい人　など

### 主な利用シーン
貯金を使用と思ったとき　ダイエットを使用と思ったとき　資格を取りたいとき　など、目標が決まったとき

## 設計書
機能一覧：https://docs.google.com/spreadsheets/d/1cgzJke1VzmLdBV6eqiz6AEdrxbZMoLMwAQsx0qWPKr0/edit?usp=sharing
画面遷移図：https://drive.google.com/file/d/1KG1Sazbp6WCwNJQkcYJqztTUQs53QEb8/view?usp=sharing
ワイヤーフレーム：https://drive.google.com/file/d/1faJe52h9bsdoCc-boBXuIzp9XRgMYmME/view?usp=sharing
ER図：https://drive.google.com/file/d/1QrRrvn_u6IyCEa2uVghU9YDobM2mQMYe/view?usp=sharing
テーブル定義書：https://docs.google.com/spreadsheets/d/11is1dHCLPhLQgMzmNlBEootF2EIbftbw/edit?usp=sharing&ouid=116271808043362304355&rtpof=true&sd=true
詳細設計：https://docs.google.com/spreadsheets/d/1zwGEi1PPiEVFZQEBgJR-wkFxijWHSOYxNPNf1Aj4omE/edit?usp=sharing

## チャレンジ要素一覧
https://docs.google.com/spreadsheets/d/1GlrxuI0WsPtIopD3BBLAWCb-jklrHXlxBCpdsykUFWM/edit?usp=sharing

## 開発環境
- OS：Linux(CentOS)
- 言語：HTML,CSS,JavaScript,Ruby,SQL
- フレームワーク：Ruby on Rails
- JSライブラリ：jQuery
- IDE：Cloud9
