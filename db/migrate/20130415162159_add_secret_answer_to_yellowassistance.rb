class AddSecretAnswerToYellowassistance < ActiveRecord::Migration
  def change
    add_column :yellowassistances, :secret_answer, :text
  end
end
