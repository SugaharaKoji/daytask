class CreateTasks < ActiveRecord::Migration[6.0]
  def change
    create_table :tasks do |t|
      t.string :name
      t.text :description

      // created_at,updated_atカラムが生成される
      t.timestamps
    end
  end
end
