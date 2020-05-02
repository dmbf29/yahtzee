class AddSubmitterToSubmissions < ActiveRecord::Migration[5.2]
  def change
    add_reference :submissions, :submitter, foreign_key: { to_table: :users }
    subs = Submission.where(submitter: nil)
    subs.each do |sub|
      sub.submitter = sub.user
      sub.save
    end
  end
end
