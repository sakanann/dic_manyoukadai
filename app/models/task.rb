class Task < ApplicationRecord
  belongs_to :user

  has_many :label_task, dependent: :destroy
  has_many :labels, through: :label_task

  validates :title, presence: true
  validates :content, presence: true

  #enum status・priority用
  enum status: {"未着手":0, "着手中":1, "完了":2}
  enum priority: { 低: 0, 中: 1, 高: 2}
  # enum :status, [ :draft, :published, :archived, :trashed ]

  scope :scope_title, -> (title){ where('title LIKE ?', "%#{title}%") }
  scope :scope_status, -> (status){ where(status: status) }
  scope :scope_label, -> (label_ids){ where(id: LabelTask.where(label_id: label_ids).pluck(:task_id))}

  scope :default_sort, -> { order(created_at: :desc) }
  scope :sort_expired_at, -> {order(expired_at: :desc)}
  scope :sort_priority, -> { order(priority: :desc) }
end
