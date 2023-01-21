require 'rails_helper'
RSpec.describe 'タスク管理機能', type: :system do
  let!(:task) { FactoryBot.create(:task, title: 'task', content: '詳細', expired_at: '') }

  describe '新規作成機能' do
    context 'タスクを新規作成した場合' do
      it '作成したタスクが表示される' do
        visit new_task_path
        fill_in 'task[title]', with: 'test'
        fill_in 'task[content]', with: 'test'
        fill_in 'task_expired_at', with: "2022-01-01"
        select '未着手', from: 'task[status]'
        select '中', from 'task[priority]'
        click_on '登録する'
        expect(page).to have_content 'test'
        expect(page).to have_content 'test'
        expect(page).to have_content '2022-01-01'
        expect(page).to have_content '未着手'
        expect(page).to have_content '高'
      end
    end
  end
  describe '一覧表示機能' do
    context '一覧画面に遷移した場合' do
      it '作成済みのタスク一覧が表示される' do
        task = FactoryBot.create(:task, title: 'task1')
        visit tasks_path
        expect(page).to have_content 'task1'
      end
    end

    context 'タスクが作成日時の降順に並んでいる場合' do
      it '新しいタスクが一番上に表示される' do
        task = FactoryBot.create(:task)
        visit tasks_path
        task_list = all('.task_row')

        expect(task_list.first).to have_content 'タスク1'
      end
    end

    context 'タスクが終了期限の降順に並んでいる場合' do
      it '終了期限が近いものから表示する' do
        task = FactoryBot.create(:task, expired_at: '2022-01-18')
        #facboの呼び出してるがカラム指定してるから関係あまりなし
        # task = FactoryBot.create(:task)
        visit tasks_path
        tasks_path(sort_expired_at: "true")
        task_list = all('.task_row')
        click_on "終了期限"
        expect(task_list[0]).to have_content '2022-01-18'
        expect(task_list.first).to have_content '2022-01-18'
      end
    end
  end
  
  describe '詳細表示機能' do
    context '任意のタスク詳細画面に遷移した場合' do
      it '該当タスクの内容が表示される' do
        task = FactoryBot.create(:task, title: 'task', content: 'task')
        visit task_path(task)
        expect(page).to have_content 'task'
      end
    end
  end
end