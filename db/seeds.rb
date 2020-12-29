
user = User.create(
  email: 'user@ephicacy-assignment.com',
  password: 'Assignment1',
  password_confirmation: 'Assignment1'
)

10.times do
  patient = Patient.create(
    email: Faker::Internet.unique.email,
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    phone: Faker::PhoneNumber.phone_number
  )
end