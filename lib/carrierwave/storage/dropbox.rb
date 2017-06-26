# encoding: utf-8
require 'dropbox'
require 'mime/types'

module CarrierWave
  module Storage
    class Dropbox < Abstract

      # Stubs we must implement to create and save
      # files (here on Dropbox)

      # Store a single file
      def store!(file)
        location = "/Public/#{uploader.store_path}"
        dropbox_client.upload location, file.to_file
      end

      # Retrieve a single file
      def retrieve!(file)
        CarrierWave::Storage::Dropbox::File.new(uploader, config, uploader.store_path(file), dropbox_client)
      end

      def dropbox_client
        @dropbox_client ||= ::Dropbox::Client.new config[:access_token]
      end

      private

      def config
        @config ||= {}

        @config[:access_token] ||= uploader.dropbox_access_token
        @config[:user_id] ||= uploader.dropbox_user_id

        @config
      end

      class File
        include CarrierWave::Utilities::Uri
        attr_reader :path

        def initialize(uploader, config, path, client)
          @uploader, @config, @path, @client = uploader, config, path, client
        end

        def url
          "https://dl.dropboxusercontent.com/u/#{@config[:user_id]}/#{@path}"
        end

        def delete
          begin
            @client.delete api_path
          rescue ::Dropbox::ApiError
          end
        end

        def download
          @client.download @path
        end

        def metadata
          @metadata ||= @client.get_metadata api_path
        end

        def content_type
          MIME::Types.type_for(api_path).first.to_s
        end

        def size
          metadata.size.to_s
        end

        private

        def api_path
          "/Public/#{@path}"
        end
      end
    end
  end
end
