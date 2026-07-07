import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import '../models/cafe.dart';
import '../data/dummy_data.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  // Islamabad center coordinates
  final LatLng _center = const LatLng(33.6844, 73.0479);
  CafeData? _selectedCafe;

  // Fake coordinates for dummy cafes
  final List<Map<String, dynamic>> _cafeLocations = [
    {'cafe': cafes[0], 'lat': 33.7215, 'lng': 73.0433}, // Howdy
    {'cafe': cafes[1], 'lat': 33.6938, 'lng': 73.0651}, // Brew & Bloom
    {'cafe': cafes[2], 'lat': 33.6844, 'lng': 73.0479}, // Secret Garden
    {'cafe': cafes[3], 'lat': 33.7100, 'lng': 73.0550}, // The Library Cafe
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F0E8),
      body: Stack(
        children: [
          // Map
          FlutterMap(
            options: MapOptions(
              initialCenter: _center,
              initialZoom: 12.5,
              onTap: (tapPosition, point) {
                // Tap on empty map — deselect cafe
                setState(() => _selectedCafe = null);
              },
            ),
            children: [
              // OpenStreetMap tiles — free, no API key
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.example.flashback',
              ),

              // Cafe markers
              MarkerLayer(
                markers: _cafeLocations.map((item) {
                  final cafe = item['cafe'] as CafeData;
                  final lat = item['lat'] as double;
                  final lng = item['lng'] as double;
                  return Marker(
                    point: LatLng(lat, lng),
                    width: 48,
                    height: 48,
                    child: GestureDetector(
                      onTap: () {
                        setState(() => _selectedCafe = cafe);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: _selectedCafe?.name == cafe.name
                              ? const Color(0xFF4A5240)
                              : const Color(0xFF6B8060),
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 2.5),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 6,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: const Icon(
                          Icons.coffee,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),

          // Top bar overlay
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Title
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: const Row(
                        children: [
                          Icon(
                            Icons.map_outlined,
                            color: Color(0xFF4A5240),
                            size: 16,
                          ),
                          SizedBox(width: 6),
                          Text(
                            'Cafe Map',
                            style: TextStyle(
                              color: Color(0xFF2D2D2D),
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Location button
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.my_location,
                        color: Color(0xFF4A5240),
                        size: 20,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Bottom sheet — selected cafe
          if (_selectedCafe != null)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                margin: const EdgeInsets.fromLTRB(16, 0, 16, 24),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.12),
                      blurRadius: 20,
                      offset: const Offset(0, -4),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    // Cafe image
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: _selectedCafe!.imagePath != null
                          ? Image.asset(
                              _selectedCafe!.imagePath!,
                              width: 64,
                              height: 64,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) =>
                                  Container(
                                    width: 64,
                                    height: 64,
                                    color: Color(
                                      int.parse(
                                        _selectedCafe!.imageColor.replaceAll(
                                          '#',
                                          '0xFF',
                                        ),
                                      ),
                                    ),
                                  ),
                            )
                          : Container(
                              width: 64,
                              height: 64,
                              color: Color(
                                int.parse(
                                  _selectedCafe!.imageColor.replaceAll(
                                    '#',
                                    '0xFF',
                                  ),
                                ),
                              ),
                            ),
                    ),

                    const SizedBox(width: 14),

                    // Info
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _selectedCafe!.name,
                            style: const TextStyle(
                              color: Color(0xFF2D2D2D),
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              const Icon(
                                Icons.location_on_outlined,
                                size: 12,
                                color: Color(0xFF8B7355),
                              ),
                              const SizedBox(width: 2),
                              Text(
                                'Islamabad, PK',
                                style: const TextStyle(
                                  color: Color(0xFF8B7355),
                                  fontSize: 12,
                                ),
                              ),
                              const SizedBox(width: 8),
                              const Icon(
                                Icons.near_me_outlined,
                                size: 12,
                                color: Color(0xFF8B7355),
                              ),
                              const SizedBox(width: 2),
                              const Text(
                                '1.2km away',
                                style: TextStyle(
                                  color: Color(0xFF8B7355),
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              const Icon(
                                Icons.star_rounded,
                                color: Color(0xFFE8A838),
                                size: 14,
                              ),
                              const SizedBox(width: 2),
                              Text(
                                _selectedCafe!.rating.toString(),
                                style: const TextStyle(
                                  color: Color(0xFF2D2D2D),
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    // View Memory button
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFF4A5240),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Text(
                          'View Memory',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),

      // Bottom nav
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
      //     currentIndex: 3, // Map active
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
