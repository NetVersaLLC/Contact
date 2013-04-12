class AddSecretAnswerToUscity < ActiveRecord::Migration
  def change
    add_column :uscities, :secret_answer, :text
  end
end
