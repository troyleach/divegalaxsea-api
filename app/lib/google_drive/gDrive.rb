# frozen_string_literal: true

require 'pry'
require 'google_drive'

module Image
  # Documents for this gem
  # https://www.rubydoc.info/gems/google_drive

  # TODO: seems I only need private key and email for this to work in the config.js file
  def self.images
    # Creates a session. This will prompt the credential via command line for the
    # first time and save it to config.json file for later usages.
    # See this document to learn how to create config.json:
    # session = GoogleDrive::Session.from_service_account_key(
    #   "my-service-account-xxxxxxxxxxxx.json")
    # https://github.com/gimite/google-drive-ruby/blob/master/doc/authorization.md
    # session = GoogleDrive::Session.from_config('./config.json')
    google_drive_session = GoogleDrive::Session.from_service_account_key(
      'app/lib/google_drive/api-project-171670602045.json'
    )
    objs = []
    # fields: 'files(id, name, mimeType, webViewLink, webContentLink, parents)',
    # Gets list of remote files.
    google_drive_session.files.each do |file|
      # file.class === GoogleDrive::File

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

    parentFolders = objs.find { |folder| !folder[:parents] } # for future features
    subFolders = objs.filter do |folder|
      folder[:mimeType] == 'application/vnd.google-apps.folder' &&
        folder[:parents]
    end

    objs.group_by { |file| file[:parents] && file[:parents][0] }
        .map do |id, images|
      result = subFolders.find { |sub_folder_id| sub_folder_id[:id] == id }
      result_two = subFolders.pluck { |sub_folder_id| sub_folder_id[:id] == id }
      folderName = result[:name] if id && result
      folderName ? { folderName => images } : next
    end.compact # compact removes null from the array
  end
end
