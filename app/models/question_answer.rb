class QuestionAnswer < ApplicationRecord
  belongs_to :question
  belongs_to :answer
  belongs_to :student_test
end
