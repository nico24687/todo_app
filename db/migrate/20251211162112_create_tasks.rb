class CreateTasks < ActiveRecord::Migration[8.0]
  def change
    create_table :tasks do |t|
      t.string :title, null: false, limit: 100
      t.text :description
      t.date :due_date
      t.boolean :completed, default: false, null: false
      t.integer :priority, default: 2, null: false

      t.timestamps
    end

    add_index :tasks, :completed
    add_index :tasks, :priority
    add_index :tasks, :due_date
  end
end
