# frozen_string_literal: true

require 'rails_helper'

describe '[STEP2] メイン機能のテスト' do
  let!(:user) { create(:user) }
  let!(:other_user) { create(:user) }
  let!(:goal) { create(:goal, user: user) }
  let!(:other_goal) { create(:goal, user: other_user) }
  let!(:category) { create(:category) }
  let!(:share) { create(:share, user: other_user, goal: other_goal, category: category ) }
  let!(:clip) { create(:clip, user: user, share: share) }
  let!(:task) { create(:task, goal: goal) }
  let!(:task_work) { create(:task_work, goal: goal, task: task) }

  before do
    visit new_user_session_path
    fill_in 'user[email]', with: user.email
    fill_in 'user[password]', with: user.password
    click_button 'ログイン'
  end

  describe 'ヘッダーのテスト: ログインしている場合' do
    context 'リンクの内容を確認: ※logoutは『ユーザログアウトのテスト』でテスト済' do
      subject { current_path }

      it 'ユーザー名を押すと、ユーザ情報変更に遷移する' do
        users_link = find_all('a')[1].native.inner_text
        users_link = users_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
        click_link users_link
        is_expected.to eq edit_users_path
      end
      it 'マイページを押すと、自分の目標一覧画面に遷移する' do
        home_link = find_all('a')[2].native.inner_text
        home_link = home_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
        click_link home_link
        is_expected.to eq goals_path
      end
      it 'Shareを押すと、シェア一覧画面に遷移する' do
        share_link = find_all('a')[3].native.inner_text
        share_link = share_link.gsub(/\n/, '').gsub(/\A\s*/, '').gsub(/\s*\Z/, '')
        click_link share_link
        is_expected.to eq shares_path
      end
    end
  end

  describe '目標一覧画面のテスト' do
    before do
      visit goals_path
    end

    context '表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/goals'
      end
      it '自分の投稿と他人の投稿のタイトルのリンク先がそれぞれ正しい' do
        expect(page).to have_link goal.content, href: goal_path(goal)
      end
    end

    context 'サイドバーの確認' do
      it '自分の名前と紹介文が表示される' do
        expect(page).to have_content user.name
      end
      it '自分のユーザ編集画面へのリンクが存在する' do
        expect(page).to have_link '', href: edit_users_path
      end
      it '「クリップした目標」と表示される' do
        expect(page).to have_content 'クリップした目標'
      end
      it 'クリップした目標が表示される' do
        expect(page).to have_content clip.share.goal.content
      end
      it 'クリップした目標がシェア詳細にリンクしている' do
        expect(page).to have_link href: share_path(share)
      end
    end

    context '投稿成功のテスト' do
      before do
        visit new_goal_path
        fill_in 'goal[content]', with: Faker::Lorem.characters(number: 10)
      end

      it '自分の新しい投稿が正しく保存される' do
        expect { click_button '新規登録' }.to change(user.goals, :count).by(1)
      end
      it 'リダイレクト先が、保存できた投稿の詳細画面になっている' do
        click_button '新規登録'
        expect(current_path).to eq '/goals/' + Goal.last.id.to_s
      end
    end
  end

  describe '自分の目標詳細画面のテスト' do
    before do
      visit goal_path(goal)
    end

    context '表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq '/goals/' + goal.id.to_s
      end
      it '目標が表示される' do
        expect(page).to have_content goal.content
      end
      it '「今日のタスク」と表示される' do
        expect(page).to have_content '今日のタスク'
      end
      it '今日のタスクが表示される' do
        expect(page).to have_content task_work.goal.content
      end
      it '編集リンクが表示される' do
        expect(page).to have_link href: edit_goal_path(goal)
      end
      it '削除リンクが表示される' do
        expect(page).to have_link href: goal_path(goal)
      end
    end

    context 'サイドバーの確認' do
      it '自分の名前と紹介文が表示される' do
        expect(page).to have_content user.name
      end
      it '自分のユーザ編集画面へのリンクが存在する' do
        expect(page).to have_link '', href: edit_users_path
      end
      it '「クリップした目標」と表示される' do
        expect(page).to have_content 'クリップした目標'
      end
      it 'クリップした目標が表示される' do
        expect(page).to have_content clip.share.goal.content
      end
      it 'クリップした目標がシェア詳細にリンクしている' do
        expect(page).to have_link href: share_path(share)
      end
    end

    context 'レポート送信のテスト' do
      before do
        fill_in 'report[comment]', with: Faker::Lorem.characters(number: 30)
      end

      it '自分の新しい投稿が正しく保存される' do
        expect { click_button '今日の活動を終了する' }.to change(goal.reports, :count).by(1)
      end
      it 'リダイレクト先が、レポート一覧画面になっている' do
        click_button '今日の活動を終了する'
        expect(current_path).to eq goal_reports_path(goal)
      end
    end

    context '編集リンクのテスト' do
      it '編集画面に遷移する' do
        find('.fa-edit').click
        expect(current_path).to eq edit_goal_path(goal)
      end
    end

    context '削除リンクのテスト' do
      before do
        find('.fa-trash-alt').click
      end

      it '正しく削除される' do
        expect(Goal.where(id: goal.id).count).to eq 0
      end
      it 'リダイレクト先が、投稿一覧画面になっている' do
        expect(current_path).to eq goals_path
      end
    end
  end

  describe '自分の投稿編集画面のテスト' do
    before do
      visit edit_goal_path(goal)
    end

    context '表示の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq edit_goal_path(goal)
      end
      it '「編集」と表示される' do
        expect(page).to have_content '編集'
      end
      it '編集フォームが表示される' do
        expect(page).to have_field 'goal[content]', with: goal.content
      end
      it 'タスクの追加フォームが表示される' do
        expect(page).to have_link href: new_goal_task_path(goal)
      end
      it 'タスクの編集フォームが表示される' do
        expect(page).to have_link href: edit_goal_task_path(goal, task)
      end
      it 'Backリンクが表示される' do
        expect(page).to have_link href: goal_path(goal)
      end
    end
  end

  describe 'シェア一覧画面のテスト' do
    before do
      visit shares_path
    end

    context '表示内容の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq shares_path
      end
      it '自分と他人の画像が表示される: ロゴ１つ＋サイドバー1つ＋一覧１つの計3つ存在する' do
        expect(all('img').size).to eq(3)
      end
      it '自分と他人の名前がそれぞれ表示される' do
        expect(page).to have_content user.name
        expect(page).to have_content other_user.name
      end
      it 'シェア詳細リンクが表示される' do
        expect(page).to have_link other_goal.content, href: share_path(share)
      end
    end

    context 'サイドバーの確認' do
      it '自分の名前と紹介文が表示される' do
        expect(page).to have_content user.name
      end
      it '自分のユーザ編集画面へのリンクが存在する' do
        expect(page).to have_link '', href: edit_users_path
      end
      it '「クリップした目標」と表示される' do
        expect(page).to have_content 'クリップした目標'
      end
      it 'クリップした目標が表示される' do
        expect(page).to have_content clip.share.goal.content
      end
      it 'クリップした目標がシェア詳細にリンクしている' do
        expect(page).to have_link href: share_path(share)
      end
    end
  end

  describe '自分のユーザ情報編集画面のテスト' do
    before do
      visit edit_users_path
    end

    context '表示の確認' do
      it 'URLが正しい' do
        expect(current_path).to eq edit_users_path
      end
      it '画像編集フォームが表示される' do
        expect(page).to have_field 'user[user_image]'
      end
      it '名前編集フォームに自分の名前が表示される' do
        expect(page).to have_field 'user[name]', with: user.name
      end
      it 'メールアドレスフォームに自分のメールアドレスが表示される' do
        expect(page).to have_field 'user[email]', with: user.email
      end
      it '「編集内容を保存」ボタンが表示される' do
        expect(page).to have_button '編集内容を保存'
      end
    end

    context '更新成功のテスト' do
      before do
        @user_old_name = user.name
        @user_old_email = user.email
        fill_in 'user[name]', with: Faker::Lorem.characters(number: 5)
        fill_in 'user[email]', with: Faker::Internet.email
        click_button '編集内容を保存'
      end

      it 'nameが正しく更新される' do
        expect(user.reload.name).not_to eq @user_old_name
      end
      it 'emailが正しく更新される' do
        expect(user.reload.email).not_to eq @user_old_email
      end
      it 'リダイレクト先が、自分のユーザ詳細画面になっている' do
        expect(current_path).to eq goals_path
      end
    end
  end
end
