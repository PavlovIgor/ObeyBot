# CarrierWave.configure do |config|
#   # Use local storage if in development or test
#   if Rails.env.development? || Rails.env.test?
#     CarrierWave.configure do |config|
#       config.storage = :file
#     end
#   end

#   # Use AWS storage if in production
#   if Rails.env.production?
#     CarrierWave.configure do |config|
#       config.storage = :fog
#     end
#   end
#   # config.fog_provider = 'fog/aws'                        # required
#   config.fog_credentials = {
#     provider:              'AWS',                        # required
#     aws_access_key_id:     ENV["AWS_ACCESS_KEY"],                        # required
#     aws_secret_access_key: ENV["AWS_SECRET_KEY"],                        # required
#     # region:                'us-east-1',                  # optional, defaults to 'us-east-1'
#     # host:                  's3.example.com',             # optional, defaults to nil
#     # endpoint:              'https://s3.example.com:8080' # optional, defaults to nil
#   }
#   config.fog_directory  = ENV["AWS_BUCKET"]                         # required
#   # config.fog_public     = false                                        # optional, defaults to true
#   # config.fog_attributes = { 'Cache-Control' => "max-age=#{365.day.to_i}" } # optional, defaults to {}
# end
#
