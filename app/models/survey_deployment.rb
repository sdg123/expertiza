class SurveyDeployment < ActiveRecord::Base
  validates_numericality_of :num_of_students
  validates_presence_of :num_of_students
  validates_presence_of :start_date
  validates_presence_of :end_date
  validate :validate_survey_deployment

  def validate_survey_deployment
    if !end_date.nil? && !start_date.nil? && (end_date - start_date) < 0
      errors[:base] << "The End Date should be after the Start Date."
    end
    if !start_date.nil? && start_date < Time.now
      errors[:base] << "The Start Date should be in the future"
    end
    if !end_date.nil? && end_date < Time.now
      errors[:base] << "The End Date should be in the future."
    end

    if !num_of_students.nil? && num_of_students > User.where(role_id: Role.student.id).length
      errors.add(:num_of_students, " - Too many students. #{num_of_students} : #{User.where(role_id: Role.student.id).length}")
    end
  end
end
