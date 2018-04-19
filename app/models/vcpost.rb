class Vcpost < ApplicationRecord
  mount_uploader :image, S3Uploader
end
