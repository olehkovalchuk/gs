# == Schema Information
#
# Table name: content_email_templates
#
#  id         :bigint           not null, primary key
#  code       :string           not null
#  text       :jsonb            not null
#  title      :jsonb            not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_content_email_templates_on_code  (code)
#
module Content
  class EmailTemplate  < ApplicationRecord
    multilang :title, :text
  end
end



