class CreateBooks < ActiveRecord::Migration[6.1]
  def change
    create_table :books do |t|
      t.string :title
      t.text :description
      t.integer :pages
      t.integer :publishing_year
      t.belongs_to :category, null: false, foreign_key: true

      t.timestamps
    end
  end
end
