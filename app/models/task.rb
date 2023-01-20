class Task < ApplicationRecord
  validates :title, presence: true
  validates :content, presence: true

  #enum status用
  enum status: {"未着手":0, "着手中":1, "完了":2}
  # enum :status, [ :draft, :published, :archived, :trashed ]
  # https://techracho.bpsinc.jp/hachi8833/2022_02_18/115735#:~:text=3%20%7D%0Aend-,%E9%85%8D%E5%88%97%E3%82%88%E3%82%8A%E3%82%82%E3%83%8F%E3%83%83%E3%82%B7%E3%83%A5%E3%81%8C%E3%81%8A%E3%81%99%E3%81%99%E3%82%81,-%E3%81%A7%E3%81%99%E3%80%82%E9%85%8D%E5%88%97%E3%81%AF
end
