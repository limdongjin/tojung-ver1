class Vcommunity < ApplicationRecord
  mount_uploader :image, S3Uploader
end
