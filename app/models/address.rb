class Address < ActiveRecord::Base

  belongs_to :user

  validates_presence_of :address
  validates_uniqueness_of :address, :scope => :user_id

  named_scope :local, ->(user) { where(:user_id => user.id, :is_local => true) }
  named_scope :remote, ->(user) { where(:user_id => user.id, :is_local => false) }

  def self.get address
    Address.find_by_address(address) || Address.new(:address => address)
  end

  def to_param
    address
  end

end