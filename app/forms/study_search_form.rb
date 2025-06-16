# app/forms/study_search_form.rb
class StudySearchForm
    include ActiveModel::Model
    attr_accessor :from, :to, :keyword, :target
  
    def search(user)
      studies = user.studies.includes(:contents)
      studies = studies.where("date >= ?", from) if from.present?
      studies = studies.where("date <= ?", to) if to.present?
  
      if keyword.present?
        case target
        when "content"
          studies = studies.joins(:contents).where("contents.name LIKE ?", "%#{keyword}%")
        when "body"
          studies = studies.where("body LIKE ?", "%#{keyword}%")
        else
          studies = studies.where("body LIKE ?", "%#{keyword}%")
                           .or(studies.joins(:contents).where("contents.name LIKE ?", "%#{keyword}%"))
        end
      end
  
      studies.distinct
    end
  end