class Category < ApplicationRecord
  has_many :events

  before_save :upcase_name

  validates_uniqueness_of :name, :message => "Category Already Exist"

  def upcase_name
    self.name.upcase!
  end

end
