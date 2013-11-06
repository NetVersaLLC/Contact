class CreateQuestions < ActiveRecord::Migration
  def up
    create_table :questions do |t| 
      t.string :question_text 
      t.text :answer_text
      t.integer :category, default: 0

      t.timestamps
    end 
  end

  def down
    drop_table :questions
  end
end
