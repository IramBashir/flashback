import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'screens/timeline_screen.dart';
import 'screens/log_memory_screen.dart';
import 'screens/map_screen.dart';
import 'screens/profile_screen.dart';
import 'data/dummy_data.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'screens/onboarding_screen.dart';
import 'screens/auth_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform, // yeh add karo
  );
  runApp(const FlashbackApp());
}

class FlashbackApp extends StatelessWidget {
  const FlashbackApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flashback',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF111111),
      ),
      home: const OnboardingScreen(),
      routes: {'/home': (context) => const MainScreen()},
    );
  }
}

// Main wrapper — sab screens yahan hain
class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0; // active tab track karta hai

  // Sab screens ki list — index se match karti hain nav items se
  final List<Widget> _screens = [
    const HomeScreen(),
    const TimelineScreen(),
    const SizedBox(), // Log — bottom sheet se open hoga
    const MapScreen(),
    const ProfileScreen(),
  ];

  void _onTabTapped(int index) {
    if (index == 2) {
      // Log button — CafeListCard se cafe select karke LogMemory open hoga
      // Abhi ke liye pehle cafe select karni hogi
      // Dummy cafe pass karte hain
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => LogMemoryScreen(cafe: cafes[0]),
        ),
      );
      return;
    }
    setState(() => _currentIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // IndexedStack — sab screens render hoti hain
      // sirf active index wali visible hoti hai
      // React mein conditional rendering jaisa but state preserve hoti hai
      body: IndexedStack(index: _currentIndex, children: _screens),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          border: Border(top: BorderSide(color: Color(0xFF2A2A2A))),
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: _onTabTapped,
          backgroundColor: const Color(0xFF1A1A1A),
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white38,
          elevation: 0,
          type: BottomNavigationBarType.fixed,
          selectedFontSize: 10,
          unselectedFontSize: 10,
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
            BottomNavigationBarItem(
              icon: Icon(Icons.map_outlined),
              label: 'Map',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
