class CreditCard
  include ActiveModel::Validations 
  include ActiveModel::Conversion 
  extend ActiveModel::Naming 

  attr_accessor :name, :brand, :number, :month, :year, :verification_value

  validates :name, presence: true
  validates :number, presence: true 
  validates :month, presence: true 
  validates :year, presence: true 
  validates :verification_value, presence: true
  def initialize(attributes ={}) 
    attributes.each do |name, value| 
      send("#{name}=", value) 
    end 
  end 
  def persisted? 
    true
  end 
end 
