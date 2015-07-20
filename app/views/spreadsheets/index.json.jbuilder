json.array!(@spreadsheets) do |spreadsheet|
  json.extract! spreadsheet, :id, :user_id, :csv
  json.url spreadsheet_url(spreadsheet, format: :json)
end
