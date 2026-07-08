import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

// Real memory model from Firestore
class MemoryEntry {
  final String id;
  final String itemName;
  final String cafeName;
  final String date;
  final String monthYear;
  final int rating;
  final String notes;
  final String imagePath;

  MemoryEntry({
    required this.id,
    required this.itemName,
    required this.cafeName,
    required this.date,
    required this.monthYear,
    required this.rating,
    required this.notes,
    required this.imagePath,
  });

  // Firestore document se MemoryEntry banao
  // React mein API response transform karna jaisa
  factory MemoryEntry.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    final timestamp = data['createdAt'] as Timestamp;
    final date = timestamp.toDate();

    final months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December',
    ];

    return MemoryEntry(
      id: doc.id,
      itemName: data['itemName'] ?? '',
      cafeName: data['cafeName'] ?? '',
      date: '${months[date.month - 1]} ${date.day}, ${date.year}',
      monthYear: '${months[date.month - 1].toUpperCase()} ${date.year}',
      rating: data['rating'] ?? 0,
      notes: data['notes'] ?? '',
      imagePath: data['imageUrl'] ?? '',
    );
  }
}

const List<String> filters = ['All Memories', 'By Cafe', 'Price'];

class TimelineScreen extends StatefulWidget {
  const TimelineScreen({super.key});

  @override
  State<TimelineScreen> createState() => _TimelineScreenState();
}

class _TimelineScreenState extends State<TimelineScreen> {
  int selectedFilter = 0;

  // Memories ko month ke hisaab se group karo
  Map<String, List<MemoryEntry>> _groupByMonth(List<MemoryEntry> memories) {
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
    final uid = FirebaseAuth.instance.currentUser?.uid ?? 'anonymous';

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
                    'Flashback',
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

            // Filter chips
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

            // StreamBuilder — real time Firestore data
            // React ka useEffect + useState jaisa but automatic
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('memories')
                    .where('userId', isEqualTo: uid)
                    .orderBy('createdAt', descending: true)
                    .snapshots(),
                builder: (context, snapshot) {
                  // Loading state
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: Color(0xFF4A5240),
                      ),
                    );
                  }

                  // Error state
                  if (snapshot.hasError) {
                    return Center(
                      child: Text(
                        'Error: ${snapshot.error}',
                        style: const TextStyle(color: Color(0xFF8B7355)),
                      ),
                    );
                  }

                  // Empty state
                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('☕', style: TextStyle(fontSize: 48)),
                          const SizedBox(height: 16),
                          const Text(
                            'No memories yet',
                            style: TextStyle(
                              color: Color(0xFF2D2D2D),
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'Visit a cafe and log your first memory!',
                            style: TextStyle(
                              color: Color(0xFF8B7355),
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    );
                  }

                  // Data aaya — convert aur group karo
                  final memories = snapshot.data!.docs
                      .map((doc) => MemoryEntry.fromFirestore(doc))
                      .toList();

                  final grouped = _groupByMonth(memories);
                  final months = grouped.keys.toList();

                  return ListView.builder(
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
                          ...monthMemories.asMap().entries.map((entry) {
                            final index = entry.key;
                            final memory = entry.value;
                            final isLast =
                                index == monthMemories.length - 1 &&
                                monthIndex == months.length - 1;
                            return _TimelineItem(
                              memory: memory,
                              isLast: isLast,
                            );
                          }),
                        ],
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: const Color(0xFFE8A0A0),
        child: const Icon(Icons.edit, color: Colors.white, size: 20),
      ),
    );
  }
}

class _TimelineItem extends StatelessWidget {
  final MemoryEntry memory;
  final bool isLast;

  const _TimelineItem({required this.memory, required this.isLast});

  IconData _getIcon() {
    final name = memory.itemName.toLowerCase();
    if (name.contains('coffee') ||
        name.contains('latte') ||
        name.contains('cappuccino') ||
        name.contains('espresso')) {
      return Icons.coffee;
    } else if (name.contains('cake') ||
        name.contains('pastry') ||
        name.contains('croissant')) {
      return Icons.cake_outlined;
    } else if (name.contains('burger') || name.contains('sandwich')) {
      return Icons.lunch_dining;
    } else {
      return Icons.restaurant;
    }
  }

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
              children: [
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
                    _getIcon(),
                    size: 14,
                    color: const Color(0xFF8B7355),
                  ),
                ),
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
                  // Image
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: memory.imagePath.isNotEmpty
                        ? Image.network(
                            memory.imagePath,
                            width: 64,
                            height: 64,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                Container(
                                  width: 64,
                                  height: 64,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFFE8E0D0),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: const Icon(
                                    Icons.restaurant,
                                    color: Color(0xFF8B7355),
                                    size: 24,
                                  ),
                                ),
                          )
                        : Container(
                            width: 64,
                            height: 64,
                            decoration: BoxDecoration(
                              color: const Color(0xFFE8E0D0),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: const Icon(
                              Icons.restaurant,
                              color: Color(0xFF8B7355),
                              size: 24,
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
                        Row(
                          children: List.generate(5, (index) {
                            return Icon(
                              index < memory.rating
                                  ? Icons.star_rounded
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
