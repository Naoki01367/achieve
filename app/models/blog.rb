class Blog < ActiveRecord::Base
  belongs_to :user
  validates :name, presence:{message: 'お名前を入力してください。'}
  validates :title, presence:{message: 'タイトルを入力してください。'}
  validates :content, presence:{message: '内容を入力してください。'}
end
