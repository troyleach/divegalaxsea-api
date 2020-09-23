# frozen_string_literal: true

# rails db:seed:replant to clean db and re-seed
# rails db:seed:reset to clean db and re-seed

User.create([
              {
                first_name: Carrie,
                last_name: Blackburn,
                email: carrie@email.com,
                admin: false
              },
              {
                first_name: Courtney,
                last_name: Rivera,
                email: courtney@email.com,
                admin: false
              },
              {
                first_name: 'Troy',
                last_name: 'Leach',
                email: 'troyleach29@gmail.com',
                admin: true
              }
            ])

# TODO: If table does not exist run the seeds files
training_sql = "INSERT INTO trainings (title,price,description,created_at,updated_at) VALUES
('testing one two threee PLUS: (Includes Nitrox Certification)',525.0,'this is the description','2016-08-13 13:47:06.240','2016-08-13 13:47:06.240')
,('Advanced Adventurer: (Number or required dives logged varies depending on the specialties selected)',50.0,'this is the description','2016-08-13 13:47:06.255','2016-08-13 13:47:06.255')
,('Advanced Open Water Diver: (Number or required dives logged varies depending on the specialties selected)',200.0,'this is the description','2016-08-13 13:47:06.262','2016-08-13 13:47:06.262')
,('Scuba Diver Course',275.0,'this is the description','2016-08-13 13:47:06.269','2016-08-13 13:47:06.269')
,('Open Water Diver Certification',425.0,'this is the description','2016-08-13 13:47:06.282','2016-08-13 13:47:06.282')
,('Scuba Skills Update',160.0,'this is the description','2016-08-13 13:47:06.289','2016-08-13 13:47:06.289')
,('Try Scuba Diving Beach - 1 Tank',80.0,'this is the description','2016-08-13 13:47:06.296','2016-08-13 13:47:06.296')
,('Try Scuba Diving Beach - 1 Tank',130.0,'this is the description','2016-08-13 13:47:06.304','2016-08-13 13:47:06.304')
,('Open Water Certification Referral (4 dives)',295.0,NULL,'2017-03-11 01:49:05.743','2017-03-11 01:49:05.743')
;"
ActiveRecord::Base.connection.execute(training_sql)

diving_sql = "INSERT INTO divings (title,price,description,created_at,updated_at) VALUES
('TEST',45.0,'this is the description','2016-05-01 02:12:02.970','2016-05-01 02:12:02.970')
,('Bubble watcher',20.0,'this is the description','2016-05-01 02:12:02.998','2016-05-01 02:12:02.998')
,('Private Charter (Maximum 6 Divers)',480.0,'this is the description','2016-05-01 02:12:03.007','2016-05-01 02:12:03.007')
,('Private dive master',50.0,'this is the description','2016-05-01 02:12:03.032','2016-06-28 12:25:15.629')
,('Snorkeling with Whale Sharks',NULL,'this is the description','2016-05-01 02:12:03.049','2016-06-28 12:28:00.969')
,('Night Dive',65.0,'this is the description','2016-05-01 02:12:02.980','2017-01-29 23:33:51.412')
,('Bull Sharks (Seasonal)',NULL,NULL,'2017-01-29 23:50:03.268','2017-01-29 23:50:03.268')
,('2 Tank boat dive',95.0,'this is the description','2016-05-01 02:12:02.896','2018-01-03 02:45:47.723')
,('3 Tank boat dives',130.1,'this is the description','2016-05-01 02:12:02.940','2020-01-25 14:22:06.430')
;"

ActiveRecord::Base.connection.execute(diving_sql)

miscellaneous_pricings_sql = "INSERT INTO miscellaneous_pricings (title,price,description,created_at,updated_at) VALUES
('Marine Park Fee',2.5,'Marine park fee per day','2016-05-01 02:12:03.858','2016-05-01 02:12:03.858')
;"

ActiveRecord::Base.connection.execute(miscellaneous_pricings_sql)

rentals_sql = "INSERT INTO rentals (title,price,description,created_at,updated_at) VALUES
('Regulator',10.0,'this is the description','2016-05-01 02:12:03.664','2016-05-01 02:12:03.664')
,('Wetsuit',10.0,'this is the description','2016-05-01 02:12:03.680','2016-05-01 02:12:03.680')
,('Mask and Fins',10.0,'this is the description','2016-05-01 02:12:03.704','2016-05-01 02:12:03.704')
,('Light',10.0,'this is the description','2016-05-01 02:12:03.724','2016-05-01 02:12:03.724')
,('Nitrox Tank',10.0,'this is the description','2016-05-01 02:12:03.744','2016-05-01 02:12:03.744')
,('100 CC Tank',5.0,'this is the description','2016-05-01 02:12:03.783','2016-05-01 02:12:03.783')
,('Complete Set (BCD, Regulator, Mask and Fins)',38.38,'this is the description updatedate YO','2016-05-01 02:12:03.529','2019-09-07 04:43:20.875')
,('BCD',10.0,'this is the description','2016-05-01 02:12:03.549','2019-10-01 02:31:14.113')
;"

ActiveRecord::Base.connection.execute(rentals_sql)

specialties_sql = "INSERT INTO specialties (title,price,description,created_at,updated_at) VALUES
('Deep Diving',NULL,'this is the description','2016-08-13 13:47:42.840','2016-08-13 13:47:42.840')
,('Navigation',NULL,'this is the description','2016-08-13 13:47:42.847','2016-08-13 13:47:42.847')
,('Night Diving and Limited Visibility',NULL,'this is the description','2016-08-13 13:47:42.854','2016-08-13 13:47:42.854')
,('Nitrox EAN',NULL,'this is the description','2016-08-13 13:47:42.861','2016-08-13 13:47:42.861')
,('Perfect Buoyancy',NULL,'this is the description','2016-08-13 13:47:42.868','2016-08-13 13:47:42.868')
,('Science of Diving',NULL,'this is the description','2016-08-13 13:47:42.875','2016-08-13 13:47:42.875')
,('Stress Rescue',NULL,'this is the description','2016-08-13 13:47:42.882','2016-08-13 13:47:42.882')
,('Snorkeling',NULL,'this is the description','2016-08-13 13:47:42.889','2017-03-08 01:35:38.325')
,('Boat Diving',22.22,'this is the description UPDATED','2016-08-13 13:47:42.831','2019-09-08 15:12:31.280')
;"

ActiveRecord::Base.connection.execute(specialties_sql)
