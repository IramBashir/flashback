import 'package:flutter/material.dart';

// Temporary memory model — Firebase se replace hoga baad mein
class MemoryEntry {
  final String itemName;
  final String cafeName;
  final String date;
  final String monthYear; // grouping ke liye
  final double rating;
  final String imageColor;
  final String? imagePath;
  final IconData icon;

  const MemoryEntry({
    required this.itemName,
    required this.cafeName,
    required this.date,
    required this.monthYear,
    required this.rating,
    required this.imageColor,
    this.imagePath,
    required this.icon,
  });
}

// Dummy data
const List<MemoryEntry> memories = [
  MemoryEntry(
    itemName: 'Velvet Flat White',
    cafeName: 'Brew & Bloom',
    date: 'Oct 24, 2023',
    monthYear: 'OCTOBER 2023',
    rating: 4.0,
    imageColor: '#8B6355',
    imagePath: 'assets/images/howdy_burger1.jpg',
    icon: Icons.coffee,
  ),
  MemoryEntry(
    itemName: 'Almond Croissant',
    cafeName: 'Artisan Pastry Lab',
    date: 'Oct 18, 2023',
    monthYear: 'OCTOBER 2023',
    rating: 4.5,
    imageColor: '#C4A882',
    imagePath: 'assets/images/howdy_burger2.jpg',
    icon: Icons.bakery_dining,
  ),
  MemoryEntry(
    itemName: 'Iced Caramel Swirl',
    cafeName: 'The Glass House',
    date: 'Sep 30, 2023',
    monthYear: 'SEPTEMBER 2023',
    rating: 5.0,
    imageColor: '#6B8B7A',
    imagePath: 'assets/images/howdy_burger3.jpg',
    icon: Icons.local_drink,
  ),
  MemoryEntry(
    itemName: 'Son of a Bun',
    cafeName: 'Howdy',
    date: 'Sep 15, 2023',
    monthYear: 'SEPTEMBER 2023',
    rating: 4.5,
    imageColor: '#8B2500',
    imagePath: 'assets/images/howdy_cover.jpg',
    icon: Icons.lunch_dining,
  ),
];

class TimelineScreen extends StatefulWidget {
  const TimelineScreen({super.key});

  @override
  State<TimelineScreen> createState() => _TimelineScreenState();
}

class _TimelineScreenState extends State<TimelineScreen> {
  int selectedFilter = 0;
  final List<String> filters = ['All Memories', 'By Cafe', 'Price'];

  // Memories ko month ke hisaab se group karo
  // yeh Map<String, List> hai — React mein reduce() jaisa
  Map<String, List<MemoryEntry>> get groupedMemories {
    final Map<String, List<MemoryEntry>> grouped = {};
    for (final memory in memories) {
      if (!grouped.containsKey(memory.monthYear)) {
        grouped[memory.monthYear] = [];
      }
      grouped[memory.monthYear]!.add(memory);
    }
    return grouped;
  }

  @override
  Widget build(BuildContext context) {
    final grouped = groupedMemories;
    final months = grouped.keys.toList();

    return Scaffold(
      backgroundColor: const Color(0xFFF5F0E8),
      body: SafeArea(
        child: Column(
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
                  Container(
                    width: 34,
                    height: 34,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: const Color(0xFFD4C5B0),
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                    child: const Icon(
                      Icons.person,
                      color: Color(0xFF8B7355),
                      size: 18,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Filter chips horizontal scroll
            SizedBox(
              height: 36,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: filters.length,
                itemBuilder: (context, index) {
                  final isSelected = selectedFilter == index;
                  return GestureDetector(
                    onTap: () => setState(() => selectedFilter = index),
                    child: Container(
                      margin: const EdgeInsets.only(right: 8),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 14,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected
                            ? const Color(0xFF4A5240)
                            : Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: isSelected
                              ? const Color(0xFF4A5240)
                              : const Color(0xFFDDD5C8),
                        ),
                      ),
                      child: Row(
                        children: [
                          Text(
                            filters[index],
                            style: TextStyle(
                              color: isSelected
                                  ? Colors.white
                                  : const Color(0xFF6B6055),
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          // By Cafe aur Price pe dropdown arrow
                          if (index != 0) ...[
                            const SizedBox(width: 4),
                            Icon(
                              Icons.keyboard_arrow_down,
                              size: 14,
                              color: isSelected
                                  ? Colors.white
                                  : const Color(0xFF6B6055),
                            ),
                          ],
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 8),

            // Timeline list
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 100),
                itemCount: months.length,
                itemBuilder: (context, monthIndex) {
                  final month = months[monthIndex];
                  final monthMemories = grouped[month]!;

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Month header
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        child: Text(
                          month,
                          style: const TextStyle(
                            color: Color(0xFF4A5240),
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 1.2,
                          ),
                        ),
                      ),

                      // Memories in this month
                      ...monthMemories.asMap().entries.map((entry) {
                        final index = entry.key;
                        final memory = entry.value;
                        final isLast = index == monthMemories.length - 1;

                        return _TimelineItem(
                          memory: memory,
                          isLast: isLast && monthIndex == months.length - 1,
                        );
                      }),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),

      // FAB — pencil button
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: const Color(0xFFE8A0A0),
        child: const Icon(Icons.edit, color: Colors.white, size: 20),
      ),

      // Bottom nav
      bottomNavigationBar: _buildBottomNav(),
    );
  }

  Widget _buildBottomNav() {
    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        border: Border(top: BorderSide(color: Color(0xFFEEE8E0))),
      ),
      child: BottomNavigationBar(
        backgroundColor: Colors.transparent,
        selectedItemColor: const Color(0xFF4A5240),
        unselectedItemColor: const Color(0xFFBBB5AD),
        elevation: 0,
        type: BottomNavigationBarType.fixed,
        selectedFontSize: 10,
        unselectedFontSize: 10,
        currentIndex: 1, // Timeline active
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.explore_outlined),
            label: 'Explore',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.timeline),
            label: 'Timeline',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_circle_outline, size: 28),
            label: 'Log',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.map_outlined), label: 'Map'),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_outline),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}

// Timeline item — alag widget banaya reusability ke liye
class _TimelineItem extends StatelessWidget {
  final MemoryEntry memory;
  final bool isLast;

  const _TimelineItem({required this.memory, required this.isLast});

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Left side — timeline line + icon
          SizedBox(
            width: 40,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Icon circle
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: const Color(0xFFEEE8E0),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: const Color(0xFFDDD5C8),
                      width: 1.5,
                    ),
                  ),
                  child: Icon(
                    memory.icon,
                    size: 14,
                    color: const Color(0xFF8B7355),
                  ),
                ),
                // Vertical line — last item pe nahi
                if (!isLast)
                  Expanded(
                    child: Container(
                      width: 1.5,
                      color: const Color(0xFFDDD5C8),
                      margin: const EdgeInsets.symmetric(vertical: 4),
                    ),
                  ),
              ],
            ),
          ),

          const SizedBox(width: 12),

          // Right side — memory card
          Expanded(
            child: Container(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.all(12),
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
                  // Food image
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: memory.imagePath != null
                        ? Image.asset(
                            memory.imagePath!,
                            width: 64,
                            height: 64,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                Container(
                                  width: 64,
                                  height: 64,
                                  color: Color(
                                    int.parse(
                                      memory.imageColor.replaceAll('#', '0xFF'),
                                    ),
                                  ),
                                ),
                          )
                        : Container(
                            width: 64,
                            height: 64,
                            color: Color(
                              int.parse(
                                memory.imageColor.replaceAll('#', '0xFF'),
                              ),
                            ),
                          ),
                  ),

                  const SizedBox(width: 12),

                  // Text info
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          memory.itemName,
                          style: const TextStyle(
                            color: Color(0xFF2D2D2D),
                            fontSize: 15,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            const Icon(
                              Icons.store_outlined,
                              size: 12,
                              color: Color(0xFF8B7355),
                            ),
                            const SizedBox(width: 4),
                            Text(
                              memory.cafeName,
                              style: const TextStyle(
                                color: Color(0xFF8B7355),
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          memory.date,
                          style: const TextStyle(
                            color: Color(0xFFBBB5AD),
                            fontSize: 11,
                          ),
                        ),
                        const SizedBox(height: 6),
                        // Stars
                        Row(
                          children: List.generate(5, (index) {
                            return Icon(
                              index < memory.rating.floor()
                                  ? Icons.star_rounded
                                  : index < memory.rating
                                  ? Icons.star_half_rounded
                                  : Icons.star_outline_rounded,
                              color: const Color(0xFFE8A838),
                              size: 14,
                            );
                          }),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
