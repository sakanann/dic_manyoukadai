# 「FactoryBotを使用します」という記述
FactoryBot.define do
  # 作成するテストデータの名前を「task」とします
  # （実際に存在するクラス名と一致するテストデータの名前をつければ、そのクラスのテストデータを自動で作成します）
  factory :task do
    title { '坂本' }
    content { '坂本薫哉' }
    expired_at {'2022-01-14'}
    status {1}
    priority {2}
  end
  # 作成するテストデータの名前を「second_task」とします
  # （存在しないクラス名の名前をつける場合、オプションで「このクラスのテストデータにしてください」と指定します）
  factory :second_task, class: Task do
    title { 'タイトル2' }
    content { 'タイトル2' }
    expired_at {'2022-01-15'}
    status {'完了'}
    priority {2}
  end
end