require 'rails_helper'

RSpec.describe Label, type: :system do
  let!(:user1) { FactoryBot.create(:user1) }
  let!(:label) { FactoryBot.create(:label) }

  def login
    visit new_session_path
      fill_in 'session_email', with: 'user1@dive.com'
      fill_in 'session_password', with: '222222'
      click_on "Log in"
  end


  context "タスクを新規登録した場合" do
    it "ラベルも登録できる" do
      visit new_session_path
      login
      click_on "タスク一覧"
      click_button "新規作成"
      fill_in 'task_title', with: 'テスト'
      fill_in 'task_content', with: 'テスト'
      fill_in "task_expired_at", with: DateTime.new(2021, 8, 1, 10, 30)
      select '未着手', from: 'task_status'
      select '高', from: 'task_priority'
      check 'ラベル１'
      click_on "登録する"
      expect(page).to have_content 'テスト'
    end
  end

  context "タスクを編集した場合" do
    it "ラベルも編集できる" do
      visit new_session_path
      login
      click_on "タスク一覧"
      click_button "新規作成"
      fill_in 'task_title', with: 'テスト'
      fill_in 'task_content', with: 'テスト'
      fill_in "task_expired_at", with: DateTime.new(2021, 8, 1, 10, 30)
      select '未着手', from: 'task_status'
      select '高', from: 'task_priority'
      check 'ラベル１'
      click_on "登録する"
      click_on "編集"
      expect(page).to have_content 'テスト'
    end
  end

  context "タスクの詳細画面に遷移した場合" do
    it "そのタスクに紐づいているラベル一覧を出力する" do
      visit new_session_path
      login
      click_on "タスク一覧"
      click_button "新規作成"
      fill_in 'task_title', with: 'テスト'
      fill_in 'task_content', with: 'テスト'
      fill_in "task_expired_at", with: DateTime.new(2021, 8, 1, 10, 30)
      select '未着手', from: 'task_status'
      select '高', from: 'task_priority'
      check 'ラベル１'
      click_on "登録する"
      click_on "詳細"
      expect(page).to have_content 'テスト'
    end
  end

  context "タスクにラベルを登録した場合" do
    it "つけたラべルで検索ができる" do
      visit new_session_path
      login
      click_on "タスク一覧"
      click_button "新規作成"
      fill_in 'task_title', with: 'テスト'
      fill_in 'task_content', with: 'テスト'
      fill_in "task_expired_at", with: DateTime.new(2021, 8, 1, 10, 30)
      select '未着手', from: 'task_status'
      select '高', from: 'task_priority'
      check 'ラベル１'
      click_on "登録する"
      select 'ラベル１', from: 'task_label_ids'
      click_button "検索"
      expect(page).to have_content 'テスト'
    end
  end
end