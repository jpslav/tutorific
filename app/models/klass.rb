class Klass < ActiveRecord::Base

  belongs_to :course
  has_many :sections,   :dependent => :destroy
  has_many :cohorts,    :dependent => :destroy, :order => :number
  has_many :educators,  :dependent => :destroy

end