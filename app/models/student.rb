
class Student < ActiveRecord::Base
  
  belongs_to :user
  belongs_to :cohort
  belongs_to :section

  validates :section_id, :presence => true
  validates :user_id, :presence => true#, :uniqueness => {:scope => :cohort_id} # this part only sometimes or elsewhere - can go in DB

  attr_accessible :is_auditing , :user, :section

  module Behavior
  end

  include Behavior

end