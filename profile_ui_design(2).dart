import 'package:flutter/material.dart';

void main() {
  runApp(const MaterialApp(
    home: ProfilePage(),
    debugShowCheckedModeBanner: false,
  ));
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  Widget buildSkillChip(String label) {
    return Chip(
      label: Text(label, style: const TextStyle(fontWeight: FontWeight.w500)),
      backgroundColor: const Color(0xFFF1F4F9),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Top bar
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: const [
                    SizedBox(width: 24), // Placeholder for alignment
                    Text(
                      'Profile',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    Icon(Icons.settings, color: Colors.black54),
                  ],
                ),
                const SizedBox(height: 24),
                // Profile image
                CircleAvatar(
                  radius: 56,
                  backgroundColor: Color(0xFFF1E4D8),
                  child: Icon(Icons.person, size: 50,),
                ),
                const SizedBox(height: 16),
                // Name
                const Text(
                  'Ethan Carter',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
                ),
                // Title and location
                const SizedBox(height: 4),
                Text(
                  'Product Designer',
                  style: TextStyle(color: Colors.blue[600], fontSize: 16),
                ),
                const SizedBox(height: 2),
                Text(
                  'San Francisco, CA',
                  style: TextStyle(color: Colors.blue, fontSize: 14),
                ),
                const SizedBox(height: 24),
                // Skills
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Skills',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    buildSkillChip('UI/UX Design'),
                    buildSkillChip('User Research'),
                    buildSkillChip('Prototyping'),
                    buildSkillChip('Wireframing'),
                    buildSkillChip('Design Systems'),
                    buildSkillChip('Interaction Design'),
                  ],
                ),
                const SizedBox(height: 24),
                // About
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'About',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Ethan is a product designer with over 5 years of experience in creating user-centered designs. He specializes in UI/UX design, user research, and prototyping. Ethan is passionate about solving complex problems and creating intuitive and engaging user experiences.',
                  style: TextStyle(fontSize: 14, color: Colors.black87, height: 1.4),
                ),
                const SizedBox(height: 24),
                // Contact
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Contact',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
                const SizedBox(height: 12),
                Column(
                  children: [
                    Row(
                      children: const [
                        Icon(Icons.email, color: Colors.black54),
                        SizedBox(width: 12),
                        Text('ethan.carter@email.com', style: TextStyle(fontSize: 15)),
                      ],
                    ),
                    SizedBox(height: 12),
                    Row(
                      children: const [
                        Icon(Icons.phone, color: Colors.black54),
                        SizedBox(width: 12),
                        Text('(555) 123-4567', style: TextStyle(fontSize: 15)),
                      ],
                    ),
                    SizedBox(height: 12),
                    Row(
                      children: const [
                        Icon(Icons.link, color: Colors.black54),
                        SizedBox(width: 12),
                        Text('linkedin.com/in/ethancarter', style: TextStyle(fontSize: 15)),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ),
      // Bottom navigation bar
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.blue[700],
        unselectedItemColor: Colors.black38,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.add), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.bookmark_border), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: ''),
        ],
      ),
    );
  }
}