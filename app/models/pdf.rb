class Pdf < ApplicationRecord

  has_attached_file :contrat
  validates_attachment_content_type :contrat, content_type: ['application/pdf']
end
