class Cohort < ActiveRecord::Base

  belongs_to :klass
  belongs_to :section
  has_many :students, :dependent => :nullify
  
end