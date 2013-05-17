class Organization < ActiveRecord::Base

  has_many :courses, :dependent => :destroy, :order => :number

end