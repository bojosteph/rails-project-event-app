class Category < ApplicationRecord
  has_many :events
  
  validates :name, presence: true
  validate :category_exist, on: :create
  before_save :upcase_name
  
       
    

  def upcase_name
    self.name.upcase!
  end

  def category_exist
    if Category.all.any?{|category| category.name == self.name.upcase! || category.name == self.name.downcase!}
      errors.add(:name, "Category already exist. Please choose on dropdown list")
    end
  end

  
end
