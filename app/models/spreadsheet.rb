class Spreadsheet < ActiveRecord::Base
  mount_uploader :csv, CsvUploader
  belongs_to :user
end
