import 'package:wishtag_web/data/models/user/user.dart';

class DataMock {
  static List<String> get recentActivities => [
        '[2023-05-17] John Doe banned user asda@asdas.com',
        '[2022-11-05] Kriss resolved ticket #123',
        '[2021-07-19] James resolved ticket #213',
        '[2023-01-08] Kriss resolved ticket #1113',
        '[2022-03-22] Michael resolved ticket #41',
        '[2021-12-30] Sam resolved ticket #21',
        '[2022-06-15] Rick resolved ticket #322',
        '[2023-04-03] Alice approved new feature request ticket #504',
        '[2022-10-11] Bob updated system settings',
        '[2021-09-27] Charlie removed inactive user dave@example.com',
        '[2022-08-14] Diana created new ticket #789',
        '[2023-02-06] Evan reviewed ticket #456',
        '[2022-05-09] Fiona reset user password for user frank@example.com',
        '[2021-11-12] George closed ticket #890',
        '[2023-03-30] Helen escalated ticket #567',
        '[2022-07-01] Ivan resolved ticket #678',
        '[2021-04-18] Julia added new admin role to user kate@example.com',
        '[2023-06-22] Kevin assigned ticket #234 to team',
        '[2022-01-31] Laura flagged ticket #345 for review',
        '[2021-08-05] Mike approved pending merge request #112',
        '[2023-04-27] Nina updated ticket #456 with new details',
        '[2022-09-16] Oliver banned user oscar@example.com',
        '[2021-10-04] Patricia resolved ticket #789',
        '[2023-07-13] Quentin commented on ticket #890',
        '[2022-02-20] Rachel updated security settings'
      ];

  static List<User> get users => [
        User(
          id: 'user_1',
          name: 'Alice Johnson',
          email: 'alice.johnson@example.com',
          photoUrl: 'https://i.imgur.com/QYqSjzi.png',
          role: UserRole.admin,
          exp: 100,
          publicWishes: [],
          privateWishes: [],
          limitedWishes: [],
        ),
        User(
          id: 'user_2',
          name: 'Bob Smith',
          email: 'bob.smith@example.com',
          photoUrl: 'https://i.imgur.com/QYqSjzi.png',
          role: UserRole.support,
          exp: 150,
          publicWishes: [],
          privateWishes: [],
          limitedWishes: [],
        ),
        User(
          id: 'user_3',
          name: 'Carol Williams',
          email: 'carol.williams@example.com',
          photoUrl: 'https://i.imgur.com/QYqSjzi.png',
          role: UserRole.banned,
          exp: 200,
          publicWishes: [],
          privateWishes: [],
          limitedWishes: [],
        ),
        User(
          id: 'user_4',
          name: 'David Brown',
          email: 'david.brown@example.com',
          photoUrl: 'https://i.imgur.com/QYqSjzi.png',
          role: UserRole.user,
          exp: 250,
          publicWishes: [],
          privateWishes: [],
          limitedWishes: [],
        ),
        User(
          id: 'user_5',
          name: 'Emma Davis',
          email: 'emma.davis@example.com',
          photoUrl: 'https://i.imgur.com/QYqSjzi.png',
          role: UserRole.user,
          exp: 300,
          publicWishes: [],
          privateWishes: [],
          limitedWishes: [],
        ),
        User(
          id: 'user_6',
          name: 'Frank Miller',
          email: 'frank.miller@example.com',
          photoUrl: 'https://i.imgur.com/QYqSjzi.png',
          role: UserRole.user,
          exp: 350,
          publicWishes: [],
          privateWishes: [],
          limitedWishes: [],
        ),
        User(
          id: 'user_7',
          name: 'Grace Wilson',
          email: 'grace.wilson@example.com',
          photoUrl: 'https://i.imgur.com/QYqSjzi.png',
          role: UserRole.user,
          exp: 400,
          publicWishes: [],
          privateWishes: [],
          limitedWishes: [],
        ),
        User(
          id: 'user_8',
          name: 'Henry Moore',
          email: 'henry.moore@example.com',
          photoUrl: 'https://i.imgur.com/QYqSjzi.png',
          role: UserRole.user,
          exp: 450,
          publicWishes: [],
          privateWishes: [],
          limitedWishes: [],
        ),
        User(
          id: 'user_9',
          name: 'Ivy Taylor',
          email: 'ivy.taylor@example.com',
          photoUrl: 'https://i.imgur.com/QYqSjzi.png',
          role: UserRole.user,
          exp: 500,
          publicWishes: [],
          privateWishes: [],
          limitedWishes: [],
        ),
        User(
          id: 'user_10',
          name: 'Jack Anderson',
          email: 'jack.anderson@example.com',
          photoUrl: 'https://i.imgur.com/QYqSjzi.png',
          role: UserRole.user,
          exp: 550,
          publicWishes: [],
          privateWishes: [],
          limitedWishes: [],
        ),
        User(
          id: 'user_11',
          name: 'Kate Thomas',
          email: 'kate.thomas@example.com',
          photoUrl: 'https://i.imgur.com/QYqSjzi.png',
          role: UserRole.user,
          exp: 600,
          publicWishes: [],
          privateWishes: [],
          limitedWishes: [],
        ),
        User(
          id: 'user_12',
          name: 'Leo Jackson',
          email: 'leo.jackson@example.com',
          photoUrl: 'https://i.imgur.com/QYqSjzi.png',
          role: UserRole.user,
          exp: 650,
          publicWishes: [],
          privateWishes: [],
          limitedWishes: [],
        ),
        User(
          id: 'user_13',
          name: 'Mia White',
          email: 'mia.white@example.com',
          photoUrl: 'https://i.imgur.com/QYqSjzi.png',
          role: UserRole.user,
          exp: 700,
          publicWishes: [],
          privateWishes: [],
          limitedWishes: [],
        ),
        User(
          id: 'user_14',
          name: 'Noah Harris',
          email: 'noah.harris@example.com',
          photoUrl: 'https://i.imgur.com/QYqSjzi.png',
          role: UserRole.user,
          exp: 750,
          publicWishes: [],
          privateWishes: [],
          limitedWishes: [],
        ),
        User(
          id: 'user_15',
          name: 'Olivia Martin',
          email: 'olivia.martin@example.com',
          photoUrl: 'https://i.imgur.com/QYqSjzi.png',
          role: UserRole.user,
          exp: 800,
          publicWishes: [],
          privateWishes: [],
          limitedWishes: [],
        ),
        User(
          id: 'user_16',
          name: 'Paul Thompson',
          email: 'paul.thompson@example.com',
          photoUrl: 'https://i.imgur.com/QYqSjzi.png',
          role: UserRole.user,
          exp: 850,
          publicWishes: [],
          privateWishes: [],
          limitedWishes: [],
        ),
        User(
          id: 'user_17',
          name: 'Quinn Garcia',
          email: 'quinn.garcia@example.com',
          photoUrl: 'https://i.imgur.com/QYqSjzi.png',
          role: UserRole.user,
          exp: 900,
          publicWishes: [],
          privateWishes: [],
          limitedWishes: [],
        ),
        User(
          id: 'user_18',
          name: 'Rachel Martinez',
          email: 'rachel.martinez@example.com',
          photoUrl: 'https://i.imgur.com/QYqSjzi.png',
          role: UserRole.user,
          exp: 950,
          publicWishes: [],
          privateWishes: [],
          limitedWishes: [],
        ),
        User(
          id: 'user_19',
          name: 'Sam Robinson',
          email: 'sam.robinson@example.com',
          photoUrl: 'https://i.imgur.com/QYqSjzi.png',
          role: UserRole.user,
          exp: 1000,
          publicWishes: [],
          privateWishes: [],
          limitedWishes: [],
        ),
        User(
          id: 'user_20',
          name: 'Tina Clark',
          email: 'tina.clark@example.com',
          photoUrl: 'https://i.imgur.com/QYqSjzi.png',
          role: UserRole.user,
          exp: 1050,
          publicWishes: [],
          privateWishes: [],
          limitedWishes: [],
        ),
        User(
          id: 'user_21',
          name: 'Uma Rodriguez',
          email: 'uma.rodriguez@example.com',
          photoUrl: 'https://i.imgur.com/QYqSjzi.png',
          role: UserRole.user,
          exp: 1100,
          publicWishes: [],
          privateWishes: [],
          limitedWishes: [],
        ),
        User(
          id: 'user_22',
          name: 'Victor Lewis',
          email: 'victor.lewis@example.com',
          photoUrl: 'https://i.imgur.com/QYqSjzi.png',
          role: UserRole.user,
          exp: 1150,
          publicWishes: [],
          privateWishes: [],
          limitedWishes: [],
        ),
        User(
          id: 'user_23',
          name: 'Wendy Lee',
          email: 'wendy.lee@example.com',
          photoUrl: 'https://i.imgur.com/QYqSjzi.png',
          role: UserRole.user,
          exp: 1200,
          publicWishes: [],
          privateWishes: [],
          limitedWishes: [],
        ),
        User(
          id: 'user_24',
          name: 'Xavier Walker',
          email: 'xavier.walker@example.com',
          photoUrl: 'https://i.imgur.com/QYqSjzi.png',
          role: UserRole.user,
          exp: 1250,
          publicWishes: [],
          privateWishes: [],
          limitedWishes: [],
        ),
        User(
          id: 'user_25',
          name: 'Yvonne Hall',
          email: 'yvonne.hall@example.com',
          photoUrl: 'https://i.imgur.com/QYqSjzi.png',
          role: UserRole.user,
          exp: 1300,
          publicWishes: [],
          privateWishes: [],
          limitedWishes: [],
        ),
        User(
          id: 'user_26',
          name: 'Zach Allen',
          email: 'zach.allen@example.com',
          photoUrl: 'https://i.imgur.com/QYqSjzi.png',
          role: UserRole.user,
          exp: 1350,
          publicWishes: [],
          privateWishes: [],
          limitedWishes: [],
        ),
        User(
          id: 'user_27',
          name: 'Aaron Young',
          email: 'aaron.young@example.com',
          photoUrl: 'https://i.imgur.com/QYqSjzi.png',
          role: UserRole.user,
          exp: 1400,
          publicWishes: [],
          privateWishes: [],
          limitedWishes: [],
        ),
        User(
          id: 'user_28',
          name: 'Bella Hernandez',
          email: 'bella.hernandez@example.com',
          photoUrl: 'https://i.imgur.com/QYqSjzi.png',
          role: UserRole.user,
          exp: 1450,
          publicWishes: [],
          privateWishes: [],
          limitedWishes: [],
        ),
        User(
          id: 'user_29',
          name: 'Calvin King',
          email: 'calvin.king@example.com',
          photoUrl: 'https://i.imgur.com/QYqSjzi.png',
          role: UserRole.user,
          exp: 1500,
          publicWishes: [],
          privateWishes: [],
          limitedWishes: [],
        ),
        User(
          id: 'user_30',
          name: 'Daisy Wright',
          email: 'daisy.wright@example.com',
          photoUrl: 'https://i.imgur.com/QYqSjzi.png',
          role: UserRole.user,
          exp: 1550,
          publicWishes: [],
          privateWishes: [],
          limitedWishes: [],
        ),
        User(
          id: 'user_31',
          name: 'Ethan Lopez',
          email: 'ethan.lopez@example.com',
          photoUrl: 'https://i.imgur.com/QYqSjzi.png',
          role: UserRole.user,
          exp: 1600,
          publicWishes: [],
          privateWishes: [],
          limitedWishes: [],
        ),
        User(
          id: 'user_32',
          name: 'Fiona Hill',
          email: 'fiona.hill@example.com',
          photoUrl: 'https://i.imgur.com/QYqSjzi.png',
          role: UserRole.user,
          exp: 1650,
          publicWishes: [],
          privateWishes: [],
          limitedWishes: [],
        )
      ];
}
