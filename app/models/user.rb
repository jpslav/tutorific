class User < ActiveRecord::Base

  has_many :students, :dependent => :destroy
  has_one :researcher, :dependent => :destroy
  has_many :educators, :dependent => :destroy


end