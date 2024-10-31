# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

require 'csv'
require 'open-uri'

url = "https://raw.githubusercontent.com/akhiltak/inspirational-quotes/refs/heads/master/Quotes.csv"
begin
  CSV.open(URI.open(url), headers: true, col_sep: ';').each do |row|
    Quote.create!(content: row['QUOTE'], author: row['AUTHOR'])
  end
rescue OpenURI::HTTPError => e
  puts "Failed to retrieve the file: #{e.message}"
rescue CSV::MalformedCSVError => e
  puts "Failed to parse the CSV: #{e.message}"
end
