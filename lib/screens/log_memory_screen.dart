import 'package:flutter/material.dart';
import '../models/cafe.dart';

class LogMemoryScreen extends StatefulWidget {
  final CafeData cafe;
  const LogMemoryScreen({super.key, required this.cafe});

  @override
  State<LogMemoryScreen> createState() => _LogMemoryScreenState();
}

class _LogMemoryScreenState extends State<LogMemoryScreen> {
  // State variables — form ka data yahan store hoga
  int selectedRating = 3;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController notesController = TextEditingController();

  // Cleanup — controllers dispose karo jab screen band ho
  // React mein yeh useEffect cleanup jaisa hai
  @override
  void dispose() {
    nameController.dispose();
    priceController.dispose();
    notesController.dispose();
    super.dispose();
  }

  void _saveMemory() {
    // Validation
    if (nameController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter item name'),
          backgroundColor: Color(0xFF4A5240),
        ),
      );
      return;
    }

    // Abhi sirf print karte hain — Firebase baad mein
    print('Memory saved: ${nameController.text}');
    print('Price: ${priceController.text}');
    print('Rating: $selectedRating');
    print('Notes: ${notesController.text}');

    // Success message + back jao
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Memory saved!'),
        backgroundColor: Color(0xFF4A5240),
      ),
    );
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
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
                  // Back button
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.08),
                            blurRadius: 8,
                          ),
                        ],
                      ),
                      child: const Icon(
                        Icons.arrow_back,
                        color: Color(0xFF2D2D2D),
                        size: 18,
                      ),
                    ),
                  ),

                  const Text(
                    'Log Memory',
                    style: TextStyle(
                      color: Color(0xFF2D2D2D),
                      fontSize: 17,
                      fontWeight: FontWeight.w600,
                    ),
                  ),

                  // Profile pic
                  Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: const Color(0xFFD4C5B0),
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                    child: const Icon(
                      Icons.person,
                      color: Color(0xFF8B7355),
                      size: 20,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),

            // Scrollable form
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Image upload area
                    Center(
                      child: GestureDetector(
                        onTap: () {
                          // Image picker baad mein add karenge
                        },
                        child: Container(
                          height: 180,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: const Color(0xFFE8E0D0),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(14),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.8),
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.camera_alt_outlined,
                                  color: Color(0xFF8B7355),
                                  size: 28,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 24),

                    // Item Name field
                    _buildLabel('Item Name'),
                    const SizedBox(height: 8),
                    _buildTextField(
                      controller: nameController,
                      hint: 'e.g. Pistachio Latte',
                    ),

                    const SizedBox(height: 20),

                    // Price field
                    _buildLabel('Price'),
                    const SizedBox(height: 8),
                    _buildTextField(
                      controller: priceController,
                      hint: '0.00',
                      prefix: 'PKR  ',
                      keyboardType: TextInputType.number,
                    ),

                    const SizedBox(height: 20),

                    // Rating
                    _buildLabel('Your Rating'),
                    const SizedBox(height: 12),
                    Row(
                      children: List.generate(5, (index) {
                        final starIndex = index + 1;
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedRating = starIndex;
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(right: 8),
                            child: Icon(
                              starIndex <= selectedRating
                                  ? Icons.star_rounded
                                  : Icons.star_outline_rounded,
                              color: starIndex <= selectedRating
                                  ? const Color(0xFF8B7355)
                                  : const Color(0xFFCCC0A8),
                              size: 36,
                            ),
                          ),
                        );
                      }),
                    ),

                    const SizedBox(height: 20),

                    // Notes field
                    _buildLabel('Notes'),
                    const SizedBox(height: 8),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: TextField(
                        controller: notesController,
                        maxLines: 4,
                        style: const TextStyle(
                          color: Color(0xFF2D2D2D),
                          fontSize: 14,
                        ),
                        decoration: InputDecoration(
                          hintText:
                              'Describe the aroma, the vibe, or who you were with...',
                          hintStyle: TextStyle(
                            color: Colors.black.withOpacity(0.3),
                            fontSize: 13,
                          ),
                          border: InputBorder.none,
                          contentPadding: const EdgeInsets.all(16),
                        ),
                      ),
                    ),

                    const SizedBox(height: 32),

                    // Save Memory button
                    GestureDetector(
                      onTap: _saveMemory,
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        decoration: BoxDecoration(
                          color: const Color(0xFF4A5240),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.bookmark_outline,
                              color: Colors.white,
                              size: 18,
                            ),
                            SizedBox(width: 8),
                            Text(
                              'Save Memory',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Reusable label widget
  Widget _buildLabel(String text) {
    return Text(
      text,
      style: const TextStyle(
        color: Color(0xFF2D2D2D),
        fontSize: 14,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  // Reusable text field widget
  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    String? prefix,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        style: const TextStyle(color: Color(0xFF2D2D2D), fontSize: 14),
        decoration: InputDecoration(
          hintText: hint,
          prefixText: prefix,
          prefixStyle: const TextStyle(
            color: Color(0xFF8B7355),
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
          hintStyle: TextStyle(
            color: Colors.black.withOpacity(0.3),
            fontSize: 14,
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 14,
          ),
        ),
      ),
    );
  }
}
