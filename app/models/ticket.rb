# frozen_string_literal: true

class Ticket < ApplicationRecord
  belongs_to :project
  belongs_to :user
  belongs_to :developer, class_name: 'User', optional: true
  validates :title, presence: true, uniqueness: { scope: :project_id }
  validates :category, presence: true
  validates :status, presence: true

  mount_uploader :image_url, ImageUploader
end
