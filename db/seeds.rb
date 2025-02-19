# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

puts "Création des pratiques suggérées..."

suggested_practices = [
  { name: "Éveil du matin", category: "suggested" },
  { name: "Relaxation profonde", category: "suggested" },
  { name: "Méditation du soir", category: "suggested" }
]

suggested_practices.each do |practice_data|
  Practice.find_or_create_by(practice_data)
end

puts "Pratiques suggérées créées avec succès ! 🎉"
