p "Deleting default user"
User.delete_all(:email => 'contacto@feathermexico.com')
p "Creating default user"
u = User.new(:name => 'Joel', :surname => 'Cano', :email => 'contacto@feathermexico.com')
u.user_type = User::TYPES[:admin]
u.password = '123456'
u.save!
p "User: #{u.email} | Pwd: #{u.password}"
