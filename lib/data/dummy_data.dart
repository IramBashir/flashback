import '../models/cafe.dart';

const List<CafeData> cafes = [
  CafeData(
    name: 'Howdy',
    rating: 4.5,
    description:
        'Wildest gourmet burgers in Islamabad. Famous for Son of a Bun, Volconda cheese burst, and over 16 beef burger options.',
    tags: ['Beef Burgers', 'Smash Burgers', 'Dine In'],
    imageColor: '#8B2500',
    imagePath: 'assets/images/howdy_cover.jpg',
    address: 'Gol Market Shop 6, F7/3, Islamabad',
    timings: 'Mon-Thu: 12PM-1AM  |  Fri-Sun: 12PM-2AM',
    whatsapp: '+923255556311',
    memories: [
      FoodMemory(
        title: 'Son of a Bun',
        price: 'Rs. 1,195',
        time: 'Today, 2 hrs ago',
        imagePath: 'assets/images/howdy_burger1.jpg',
        imageColor: '#3D2B1F',
      ),
      FoodMemory(
        title: 'Rango Tango',
        price: 'Rs. 995',
        time: 'Yesterday',
        imagePath: 'assets/images/howdy_burger2.jpg',
        imageColor: '#2D1A0A',
      ),
      FoodMemory(
        title: 'Buckshots',
        price: 'Rs. 899',
        time: '3 days ago',
        imagePath: 'assets/images/howdy_burger3.jpg',
        imageColor: '#1A0A00',
      ),
    ],
  ),
  CafeData(
    name: 'Brew & Bloom',
    rating: 4.5,
    description: 'Cozy corner with beautiful plants and artisan coffee.',
    tags: ['Outdoor', 'Pet Friendly'],
    imageColor: '#8B7355',
  ),
  CafeData(
    name: 'Secret Garden',
    rating: 4.8,
    description: 'Quiet patio, perfect for reading.',
    tags: ['Outdoor', 'WiFi'],
    imageColor: '#2D5016',
  ),
  CafeData(
    name: 'The Library Cafe',
    rating: 4.2,
    description: 'Artisan brews and classic novels.',
    tags: ['Iced Coffee', 'Pour Over'],
    imageColor: '#3D2B1F',
  ),
];

const List<String> filters = [
  'All Cafes',
  'Pet Friendly',
  'Iced Coffee',
  'Outdoor',
  'WiFi',
];
