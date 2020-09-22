# frozen_string_literal: true

require 'pry'
require 'google_drive'

module Image
  # Documents for this gem
  # https://www.rubydoc.info/gems/google_drive

  def self.images
    # https://github.com/gimite/google-drive-ruby/blob/master/doc/authorization.md
    # session = GoogleDrive::Session.from_config('./config.json')

    # https://blog.saeloun.com/2019/10/10/rails-6-adds-support-for-multi-environment-credentials.html
    private_key = Rails.application.credentials.config[:google_drive][:private_key]
    client_email = Rails.application.credentials.config[:google_drive][:client_email]

    config_hash = { "private_key": private_key, "client_email": client_email }

    # https://mauricio.github.io/2014/08/03/quick-tips-for-doing-io-with-ruby.html search for StringIO
    # https://www.rubyguides.com/2017/05/stringio-objects/
    io_like_object = StringIO.new(config_hash.to_json)

    # https://www.rubydoc.info/gems/google_drive/GoogleDrive/Session
    # This method is expecting a file. I did not want my keys exposed so I had to use
    # IO-like object.
    google_drive_session = GoogleDrive::Session.from_service_account_key(
      io_like_object
    )

    objs = []
    # Gets list of remote files.
    google_drive_session.files.each do |file|
      objs.push({
                  id: file.id,
                  kind: file.kind,
                  name: file.name,
                  mimeType: file.mime_type,
                  webViewLink: file.web_view_link,
                  webContentLink: file.web_content_link,
                  parents: file.parents
                })
    end

    parent_folders = objs.find { |folder| !folder[:parents] } # for future features
    sub_folders = objs.filter do |folder|
      folder[:mimeType] == 'application/vnd.google-apps.folder' &&
        folder[:parents]
    end

    objs.group_by { |file| file[:parents] && file[:parents][0] }
        .map do |id, images|
      result = sub_folders.find { |sub_folder_id| sub_folder_id[:id] == id }
      folder_name = result[:name] if id && result
      folder_name ? { folder_name => images } : next
    end.compact # compact removes null from the array
  end
end
