class Ticket < ApplicationRecord
    
        belongs_to :project
        belongs_to :user
        validates :title, presence: true, uniqueness: { scope: :project_id }
        validates :category, presence: true
        validates :status, presence: true   
      
end