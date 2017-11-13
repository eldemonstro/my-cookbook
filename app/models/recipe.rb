class Recipe < ApplicationRecord
  belongs_to :recipe_type
  belongs_to :cuisine
  belongs_to :user
  has_many :favorites

  has_attached_file :photo, default_url: ':style/missing.svg'
  validates_attachment_content_type :photo, content_type: %r{\Aimage\/.*\z}

  validates :title, :recipe_type, :cuisine, :difficulty, :cook_time,
            :ingredients, :method, presence: true

  def show_cook_time
    "#{cook_time} minutos"
  end
end
