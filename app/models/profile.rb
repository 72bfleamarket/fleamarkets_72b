class Profile < ApplicationRecord
  belongs_to :user

  mount_uploader :icon, IconUploader

end
