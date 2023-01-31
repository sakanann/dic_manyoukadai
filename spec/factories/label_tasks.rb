FactoryBot.define do
  factory :label_task do
    association :test_label
    association :label_task
  end
end
