class CreateQuestionSets < ActiveRecord::Migration[6.0]
  def change
    create_table :question_sets do |t|
      t.references :test, null: false, foreign_key: true
      t.references :question, null: false, foreign_key: true

      t.timestamps
    end
  end
end
