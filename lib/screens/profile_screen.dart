import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    final uid = user?.uid ?? 'anonymous';
    final email = user?.email ?? 'No email';
    final displayName = user?.displayName ?? email.split('@')[0];

    return Scaffold(
      backgroundColor: const Color(0xFFF5F0E8),
      body: SafeArea(
        child: StreamBuilder<QuerySnapshot>(
          // Real time memories fetch karo
          stream: FirebaseFirestore.instance
              .collection('memories')
              .where('userId', isEqualTo: uid)
              .snapshots(),
          builder: (context, snapshot) {
            // Stats calculate karo from real data
            int memoriesCount = 0;
            int cafesCount = 0;
            double avgRating = 0.0;
            List<Map<String, dynamic>> recentMemories = [];

            if (snapshot.hasData && snapshot.data!.docs.isNotEmpty) {
              final docs = snapshot.data!.docs;
              memoriesCount = docs.length;

              // Unique cafes count
              final cafeNames = docs
                  .map(
                    (d) =>
                        (d.data() as Map<String, dynamic>)['cafeName']
                            as String? ??
                        '',
                  )
                  .toSet();
              cafesCount = cafeNames.length;

              // Average rating
              final ratings = docs
                  .map(
                    (d) =>
                        ((d.data() as Map<String, dynamic>)['rating'] as int? ??
                                0)
                            .toDouble(),
                  )
                  .toList();
              if (ratings.isNotEmpty) {
                avgRating = ratings.reduce((a, b) => a + b) / ratings.length;
              }

              // Recent memories for favorite dishes
              recentMemories = docs
                  .take(3)
                  .map((d) => d.data() as Map<String, dynamic>)
                  .toList();
            }

            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Top bar
                  Padding(
                    padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Icon(
                          Icons.menu,
                          color: Color(0xFF2D2D2D),
                          size: 22,
                        ),
                        const Text(
                          'Flashback',
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

                  // Profile picture + name
                  Center(
                    child: Column(
                      children: [
                        Stack(
                          children: [
                            Container(
                              width: 90,
                              height: 90,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: const Color(0xFFD4C5B0),
                                border: Border.all(
                                  color: Colors.white,
                                  width: 3,
                                ),
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
                            Positioned(
                              bottom: 0,
                              right: 0,
                              child: Container(
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  color: const Color(0xFF4A5240),
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 2,
                                  ),
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

                        Text(
                          displayName,
                          style: const TextStyle(
                            color: Color(0xFF2D2D2D),
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 4),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(
                              Icons.location_on_outlined,
                              color: Color(0xFF8B7355),
                              size: 14,
                            ),
                            const SizedBox(width: 2),
                            Text(
                              email,
                              style: const TextStyle(
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
                                Text(
                                  '$cafesCount',
                                  style: const TextStyle(
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
                                Text(
                                  '$memoriesCount',
                                  style: const TextStyle(
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
                          Text(
                            avgRating.toStringAsFixed(1),
                            style: const TextStyle(
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

                  // Recent Memories section
                  if (recentMemories.isNotEmpty) ...[
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Recent Memories',
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

                    SizedBox(
                      height: 120,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        padding: const EdgeInsets.only(left: 20),
                        itemCount: recentMemories.length,
                        itemBuilder: (context, index) {
                          final memory = recentMemories[index];
                          return Container(
                            width: 110,
                            margin: const EdgeInsets.only(right: 12),
                            decoration: BoxDecoration(
                              color: const Color(0xFFE8E0D0),
                              borderRadius: BorderRadius.circular(14),
                            ),
                            padding: const EdgeInsets.all(12),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  memory['itemName'] ?? '',
                                  style: const TextStyle(
                                    color: Color(0xFF2D2D2D),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  memory['cafeName'] ?? '',
                                  style: const TextStyle(
                                    color: Color(0xFF8B7355),
                                    fontSize: 10,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),

                    const SizedBox(height: 24),
                  ],

                  // Settings menu
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Column(
                      children: [
                        _menuItem(Icons.settings_outlined, 'Settings', () {}),
                        const SizedBox(height: 8),
                        _menuItem(
                          Icons.notifications_outlined,
                          'Notifications',
                          () {},
                        ),
                        const SizedBox(height: 8),
                        _menuItem(Icons.help_outline, 'Help & Support', () {}),
                      ],
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
                        onTap: () async {
                          await FirebaseAuth.instance.signOut();
                          if (context.mounted) {
                            Navigator.pushReplacementNamed(context, '/');
                          }
                        },
                      ),
                    ),
                  ),

                  const SizedBox(height: 40),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _menuItem(IconData icon, String label, VoidCallback onTap) {
    return Container(
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
        leading: Icon(icon, color: const Color(0xFF6B6055), size: 20),
        title: Text(
          label,
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
        onTap: onTap,
      ),
    );
  }
}
