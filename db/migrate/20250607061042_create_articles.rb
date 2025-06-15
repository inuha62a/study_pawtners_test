class CreateArticles < ActiveRecord::Migration[7.2]
  def change
    create_table :articles do |t|
      t.string :title

       # 外部キー（user_id）を追加
       t.references :user, null: false, foreign_key: true

       # enum用の整数型カラム（type は予約語なので category に変更）
       t.integer :category, null: false, default: 0
       # ステータス管理用のenumカラム
       t.integer :status, null: false, default: 0

      t.timestamps
    end
  end
end
