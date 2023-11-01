class Relationship < ApplicationRecord
  # classなしだとオレンジ部分のテーブルを探すため、参照する場所をclassでUserを指定している。
  belongs_to :follower, class_name: "User"
  belongs_to :followed, class_name: "User"
end
