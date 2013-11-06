class Question < ActiveRecord::Base
  attr_accessible :question_text, :answer_text, :category
end 
