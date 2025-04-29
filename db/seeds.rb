# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
# db/seeds.rb

# Clear existing data (optional for dev resets), yes I did borrow this. Fun seed data is hard to come up with on the fly!
# TeaSubscription.destroy_all
# Customer.destroy_all
# Tea.destroy_all

puts "🌱 Seeding whimsical tea realm..."

# === CUSTOMERS ===
customers = Customer.create!([
  { first_name: "Darren", last_name: "Deepbrew", email: "darren@brewmail.com", address: "12 Ember Hollow, Cinderkeep" },
  { first_name: "Lira", last_name: "Tealeaf", email: "lira@forestpost.com", address: "77 Moss Path, Elderwood" },
  { first_name: "Grunk", last_name: "Steepgut", email: "grunk@orcbrew.net", address: "9 Boulder Lane, Stonetown" },
  { first_name: "Elaria", last_name: "Steamwhisper", email: "elaria@fogmail.org", address: "1 Cloudrise Spire, Mistvale" },
  { first_name: "Merrick", last_name: "Oolongshade", email: "merrick@darkleaf.io", address: "13 Shadegrove Alley, Duskfen" }
])

# === TEAS ===
teas = Tea.create!([
  { name: "Goblin's Gold", description: "A spicy green tea that smells faintly of coins and mischief.", brew_time: "3 minutes", temperature: 180 },
  { name: "Dragon's Breath", description: "So strong it may singe your tongue. Perfect for fire mages.", brew_time: "5 minutes", temperature: 212 },
  { name: "Enchanted Chamomile", description: "May induce sudden naps or mild floating. Sip with care.", brew_time: "4 minutes", temperature: 200 },
  { name: "Feywild Bloom", description: "Floral and confusing. You'll swear it changed flavor mid-sip.", brew_time: "2 minutes", temperature: 175 },
  { name: "Shadowmint", description: "A cool, dark brew that whispers secrets to your tastebuds.", brew_time: "3 minutes", temperature: 185 },
  { name: "Wizard’s Wakeup", description: "One sip and you’re halfway through your spellbook.", brew_time: "4 minutes", temperature: 198 },
  { name: "Pixie Punch", description: "Fruity, fizzy, and liable to prank your palate.", brew_time: "3 minutes", temperature: 190 },
  { name: "Elderbark Tonic", description: "Tastes like wisdom and dirt. Somehow comforting.", brew_time: "6 minutes", temperature: 205 },
  { name: "Cursed Hibiscus", description: "It’s red, it’s floral, and we’re pretty sure it growls.", brew_time: "5 minutes", temperature: 210 },
  { name: "Twilight Spice", description: "A cozy blend of cinnamon and stardust. Best at dusk.", brew_time: "3 minutes", temperature: 195 }
])

# === TEA SUBSCRIPTIONS ===
frequencies = TeaSubscription::FREQUENCIES
statuses = TeaSubscription.statuses.keys

subscriptions = []

customers.each do |customer|
  teas.sample(rand(3..5)).each do |tea|
    subscriptions << TeaSubscription.create!(
      customer: customer,
      tea: tea,
      frequency: frequencies.sample,
      status: statuses.sample
    )
  end
end

puts "✨ Seeded #{customers.count} customers, #{teas.count} teas, and #{subscriptions.count} subscriptions!"
