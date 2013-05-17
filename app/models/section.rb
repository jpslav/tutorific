class Section < ActiveRecord::Base

  belongs_to :klass
  has_many :cohorts, :dependent => :nullify
  has_many :students, :dependent => :destroy


end