class Vpropose < ApplicationRecord
  mount_uploader :image, S3Uploader
end
