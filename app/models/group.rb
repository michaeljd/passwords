class Group < ActiveRecord::Base
  attr_accessible :name, :users, :notes, :passwords, :user_ids, :group_id
  has_and_belongs_to_many :users
  has_and_belongs_to_many :passwords
  belongs_to :group
  has_many :groups
  validates :users, :length => {:minimum => 1 }

  def update_password_hashes(current_user, user_session)
    passwords.each do |p|
      p.create_hashes(p.password_hashes.find_by_user_id(current_user.id).decrypt(user_session[:private_key]))
    end
  end
end
