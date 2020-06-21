require "carrierwave/storage/abstract"
require "carrierwave/storage/file"
require "carrierwave/storage/fog"

CarrierWave.configure do |config|
  if Rails.env.production?
    config.storage = :fog
    config.fog_provider = "fog/aws"
    config.fog_directory = "fleamarket72b"
    config.asset_host = "https://s3-ap-northeast-1.amazonaws.com/fleamarket72b"
    config.fog_credentials = {
      provider: "AWS",
      aws_access_key_id: Rails.application.credentials.aws_access_key_id,
      aws_secret_access_key: Rails.application.credentials.aws_secret_access_key,
      region: "ap-northeast-1",
    }
  else
    config.storage :file
    config.enable_processing = false if Rails.env.test?
  end
end