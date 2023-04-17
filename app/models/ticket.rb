class Ticket < ApplicationRecord
    
        belongs_to :project
        belongs_to :user
        belongs_to :developer, class_name: 'User'
        validates :title, presence: true, uniqueness: { scope: :project_id }
        validates :category, presence: true
        validates :status, presence: true   

        mount_uploader :image_url, ImageUploader
      
end