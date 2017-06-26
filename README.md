# Carrierwave uploads on Dropbox

This gem allows you to easily upload your medias on Dropbox using the awesome
[CarrierWave](https://github.com/carrierwaveuploader/carrierwave) gem.

## Installation

First, you have to create a [Dropbox app](https://www.dropbox.com/developers/apps).
You can either create a "full dropbox" or "app folder" application. Please see
[this wiki](https://github.com/janko-m/paperclip-dropbox/wiki/Access-types) for
further information and gotchas.

Then, add this line to your application's Gemfile:

~~~ruby
gem 'carrierwave-dropbox'
~~~

And make sure that it gets installed running the `bundle` command.

Go back to the [Dropbox apps dashboard](https://www.dropbox.com/developers/apps), and under your newly created app, click the link to generate an OAuth2 access token.

Config CarrierWave to make it work with your Dropbox application:

~~~ruby
CarrierWave.configure do |config|
  config.dropbox_access_token = ENV["ACCESS_TOKEN"]
  config.dropbox_user_id = ENV["USER_ID"]
end
~~~

**Note**: It's advisable not to directly store the credentials in your files
especially if you are using a SCM (e.g. git). You should store these values in
[environment variables for instance](https://gist.github.com/canton7/1423106)
like in the above example.

Then you can either specify in your uploader files the storage or define it
globally through `CarrierWave.configure`:

~~~ruby
class ImageUploader < CarrierWave::Uploader::Base
  storage :dropbox
end
~~~

## Special thanks

This project is highly based on these two gems:

* [paperclip-dropbox](https://github.com/janko-m/paperclip-dropbox)
* [carrierwave-aws](https://github.com/sorentwo/carrierwave-aws)

Thanks to their respective authors and contributors!

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

## License

Please see the `LICENSE` file for further information.
