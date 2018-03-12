class AddAttachmentContratToPdfs < ActiveRecord::Migration[5.1]
  def self.up
    change_table :pdfs do |t|
      t.attachment :contrat
    end
  end

  def self.down
    remove_attachment :pdfs, :contrat
  end
end
