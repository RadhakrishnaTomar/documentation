puts "Seeding roles and test users..."
admin = User.find_or_initialize_by(email: "admin@example.com")
admin.password = "password"
admin.role = :super_admin
admin.save!

manager = User.find_or_initialize_by(email: "manager@example.com")
manager.password = "password"
manager.role = :manager
manager.save!

supervisor = User.find_or_initialize_by(email: "supervisor@example.com")
supervisor.password = "password"
supervisor.role = :supervisor
supervisor.save!

deo = User.find_or_initialize_by(email: "deo@example.com")
deo.password = "password"
deo.role = :data_entry_operator
deo.save!

client_user = User.find_or_initialize_by(email: "client@example.com")
client_user.password = "password"
client_user.role = :client
client_user.save!

puts "Users seeded!"

puts "Creating client profile..."

client = Client.find_or_create_by!(user: client_user) do |c|
  c.name = "Client 1"
  c.email = client_user.email
  c.status = "Active"
end

puts "Creating test document for client..."
client.documents.create!(
  title: "Test Document",
  category: "ID Proof"
)

puts "✅ Seeding complete!"
