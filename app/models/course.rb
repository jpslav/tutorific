class Course < ActiveRecord::Base

  belongs_to :organization
  has_many :klasses, :dependent => :destroy
  
end