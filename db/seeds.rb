# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Admin.create(name: 'Admin', email: 'admin@ncsu.edu', password: 'zxcv0987')
University.create(name: 'NC State University')
University.create(name: 'Duke University')
University.create(name: 'UNC Chapel Hill')
Library.create(name: 'Hunt', university_id: 1, location: 'Centennial Campus',max_days_borrowed: 25,overdue_fines: 0.5)
Library.create(name: 'Hill', university_id: 1, location: 'Main Campus',max_days_borrowed: 20,overdue_fines: 0.5)
Library.create(name: 'Perkins & Bostock', university_id: 2, location: 'Main Campus',max_days_borrowed: 10,overdue_fines: 1)
Library.create(name: 'J Murrey Atkins', university_id: 3, location: 'University Blvd',max_days_borrowed: 20,overdue_fines: 0.5)
