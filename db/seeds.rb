puts "Seeding roles and test users..."

admin = User.create!(email: "admin@example.com", password: "password", role: :super_admin)
manager = User.create!(email: "manager@example.com", password: "password", role: :manager)
supervisor = User.create!(email: "supervisor@example.com", password: "password", role: :supervisor)
deo = User.create!(email: "deo@example.com", password: "password", role: :data_entry_operator)
client_user = User.create!(email: "client@example.com", password: "password", role: :client)

puts "Users seeded!"

puts "Creating client profile..."
client = Client.create!(user: client_user, name: "Client 1", email: client_user.email, status: "Active")

puts "Creating test document for client..."
client.documents.create!(
  title: "Test Document",
  category: "ID Proof"
)

puts "✅ Seeding complete!"
