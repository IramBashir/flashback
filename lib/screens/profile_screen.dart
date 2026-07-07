import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  // Favorite dishes dummy data
  static const List<Map<String, String>> favoriteDishes = [
    {
      'name': 'Vanilla Bean Latte',
      'cafe': 'Burning Brownie',
      'color': '0xFF8B6355',
      'imagePath': 'assets/images/howdy_burger1.jpg',
    },
    {
      'name': 'Classic Fries',
      'cafe': 'Latte bay',
      'color': '0xFFC4A882',
      'imagePath': 'assets/images/howdy_burger2.jpg',
    },
    {
      'name': 'Iced Matcha',
      'cafe': 'Brew & Bloom',
      'color': '0xFF6B8B7A',
      'imagePath': 'assets/images/howdy_burger3.jpg',
    },
  ];

  static const List<Map<String, dynamic>> menuItems = [
    {'icon': Icons.settings_outlined, 'label': 'Settings'},
    {'icon': Icons.notifications_outlined, 'label': 'Notifications'},
    {'icon': Icons.help_outline, 'label': 'Help & Support'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F0E8),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Top bar
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Icon(Icons.menu, color: Color(0xFF2D2D2D), size: 22),
                    const Text(
                      'CafeMemory',
                      style: TextStyle(
                        color: Color(0xFF2D2D2D),
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(width: 22),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // Profile picture + name + location
              Center(
                child: Column(
                  children: [
                    // Profile picture
                    Stack(
                      children: [
                        Container(
                          width: 90,
                          height: 90,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: const Color(0xFFD4C5B0),
                            border: Border.all(color: Colors.white, width: 3),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.1),
                                blurRadius: 12,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.person,
                            color: Color(0xFF8B7355),
                            size: 44,
                          ),
                        ),
                        // Edit button
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                              color: const Color(0xFF4A5240),
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white, width: 2),
                            ),
                            child: const Icon(
                              Icons.edit,
                              color: Colors.white,
                              size: 12,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 12),

                    const Text(
                      'Coffee Enthusiast',
                      style: TextStyle(
                        color: Color(0xFF2D2D2D),
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 4),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(
                          Icons.location_on_outlined,
                          color: Color(0xFF8B7355),
                          size: 14,
                        ),
                        SizedBox(width: 2),
                        Text(
                          'Islamabad, PK',
                          style: TextStyle(
                            color: Color(0xFF8B7355),
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Stats cards
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    // Cafes visited
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(14),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                color: const Color(0xFFF5F0E8),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Icon(
                                Icons.store_outlined,
                                color: Color(0xFF8B7355),
                                size: 18,
                              ),
                            ),
                            const SizedBox(height: 10),
                            const Text(
                              '42',
                              style: TextStyle(
                                color: Color(0xFF2D2D2D),
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Text(
                              'Cafes Visited',
                              style: TextStyle(
                                color: Color(0xFF8B7355),
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(width: 12),

                    // Items logged
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: const Color(0xFFE8F0E0),
                          borderRadius: BorderRadius.circular(14),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.6),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Icon(
                                Icons.bookmark_outline,
                                color: Color(0xFF4A5240),
                                size: 18,
                              ),
                            ),
                            const SizedBox(height: 10),
                            const Text(
                              '128',
                              style: TextStyle(
                                color: Color(0xFF2D2D2D),
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Text(
                              'Items Logged',
                              style: TextStyle(
                                color: Color(0xFF4A5240),
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 12),

              // Avg rating
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.star_rounded,
                        color: Color(0xFFE8A838),
                        size: 22,
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        '4.8',
                        style: TextStyle(
                          color: Color(0xFF2D2D2D),
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 8),
                      const Text(
                        'Avg Rating',
                        style: TextStyle(
                          color: Color(0xFF8B7355),
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // Favorite Dishes
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Favorite Dishes',
                      style: TextStyle(
                        color: Color(0xFF2D2D2D),
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      'See All',
                      style: TextStyle(
                        color: const Color(0xFF4A5240),
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 12),

              // Horizontal dish cards
              SizedBox(
                height: 140,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.only(left: 20),
                  itemCount: favoriteDishes.length,
                  itemBuilder: (context, index) {
                    final dish = favoriteDishes[index];
                    return Container(
                      width: 120,
                      margin: const EdgeInsets.only(right: 12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),
                        color: Color(int.parse(dish['color']!)),
                      ),
                      clipBehavior: Clip.hardEdge,
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          // Image
                          Image.asset(
                            dish['imagePath']!,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                Container(
                                  color: Color(int.parse(dish['color']!)),
                                ),
                          ),
                          // Gradient
                          Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Colors.transparent,
                                  Colors.black.withOpacity(0.7),
                                ],
                              ),
                            ),
                          ),
                          // Text
                          Positioned(
                            bottom: 10,
                            left: 8,
                            right: 8,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  dish['name']!,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 11,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  dish['cafe']!,
                                  style: const TextStyle(
                                    color: Colors.white60,
                                    fontSize: 10,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 24),

              // Settings menu items
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: menuItems.map((item) {
                    return Container(
                      margin: const EdgeInsets.only(bottom: 8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(14),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.04),
                            blurRadius: 6,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: ListTile(
                        leading: Icon(
                          item['icon'] as IconData,
                          color: const Color(0xFF6B6055),
                          size: 20,
                        ),
                        title: Text(
                          item['label'] as String,
                          style: const TextStyle(
                            color: Color(0xFF2D2D2D),
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        trailing: const Icon(
                          Icons.arrow_forward_ios,
                          color: Color(0xFFBBB5AD),
                          size: 14,
                        ),
                        onTap: () {},
                      ),
                    );
                  }).toList(),
                ),
              ),

              const SizedBox(height: 8),

              // Logout
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(14),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.04),
                        blurRadius: 6,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: ListTile(
                    leading: const Icon(
                      Icons.logout,
                      color: Color(0xFFE05A5A),
                      size: 20,
                    ),
                    title: const Text(
                      'Logout',
                      style: TextStyle(
                        color: Color(0xFFE05A5A),
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    onTap: () {},
                  ),
                ),
              ),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),

      // // Bottom nav
      // bottomNavigationBar: Container(
      //   decoration: const BoxDecoration(
      //     color: Colors.white,
      //     border: Border(top: BorderSide(color: Color(0xFFEEE8E0))),
      //   ),
      //   child: BottomNavigationBar(
      //     backgroundColor: Colors.transparent,
      //     selectedItemColor: const Color(0xFF4A5240),
      //     unselectedItemColor: const Color(0xFFBBB5AD),
      //     elevation: 0,
      //     type: BottomNavigationBarType.fixed,
      //     selectedFontSize: 10,
      //     unselectedFontSize: 10,
      //     currentIndex: 4, // Profile active
      //     items: const [
      //       BottomNavigationBarItem(
      //         icon: Icon(Icons.explore_outlined),
      //         label: 'Explore',
      //       ),
      //       BottomNavigationBarItem(
      //         icon: Icon(Icons.timeline),
      //         label: 'Timeline',
      //       ),
      //       BottomNavigationBarItem(
      //         icon: Icon(Icons.add_circle_outline, size: 28),
      //         label: 'Log',
      //       ),
      //       BottomNavigationBarItem(
      //         icon: Icon(Icons.map_outlined),
      //         label: 'Map',
      //       ),
      //       BottomNavigationBarItem(
      //         icon: Icon(Icons.person_outline),
      //         label: 'Profile',
      //       ),
      //     ],
      //   ),
      // ),
    );
  }
}
