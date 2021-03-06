class Event < ActiveRecord::Base
	resourcify
  include Authority::Abilities
	
	belongs_to :user
  belongs_to :category
  has_many :comments, dependent: :destroy
  has_many :users, through: :comments
	mount_uploader :image, ImageUploader


	validates_presence_of :category
  
  def self.search(search)
    if search
      #where('lower(title) LIKE ?', "%#{search.downcase}%")
      joins("INNER JOIN 'categories' ON 'categories'.id = category_id").where('lower(title) LIKE ? or categories.name LIKE ?', "%#{search.downcase}%", "%#{search.downcase}%")
    else
      all
    end
  end
  
  def address
    return (" #{self.number}, #{self.zip_code}, #{self.city}, #{self.country}, #{self.street}")
  end
  
end

