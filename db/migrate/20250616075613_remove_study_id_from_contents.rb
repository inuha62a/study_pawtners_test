class RemoveStudyIdFromContents < ActiveRecord::Migration[7.2]
  def change
    remove_reference :contents, :study, foreign_key: true
  end
end
