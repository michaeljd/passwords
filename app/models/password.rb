class Password < ActiveRecord::Base
  attr_accessible :notes, :server, :user, :group_ids
  has_many :password_hashes, :dependent=>:destroy
  has_and_belongs_to_many :groups
  validates :groups, :length => {:minimum => 1 }

  def create_hashes(raw_password)
    # Remove all existing hashes for this password
    password_hashes.each do |h|
      h.delete
    end

    # Re-create hashes for each user that has permission
    groups.each do |g|
      g.users.each do |u|
        # Only create one hash per user (even if user shares multiple groups with password)
        if password_hashes.find_by_user_id(u.id).nil?
          public_key = OpenSSL::PKey::RSA.new u.public_key
          public_hash = public_key.public_encrypt raw_password
          new_hash = PasswordHash.new
          new_hash.user = u
          new_hash.password_id = id 
          new_hash.public_hash = Base64.encode64 public_hash
          new_hash.save
        end
      end
    end
  end
end
