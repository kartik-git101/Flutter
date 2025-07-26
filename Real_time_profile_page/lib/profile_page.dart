import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  Future<void> _pickAndUploadImage(BuildContext context, User user) async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      final ref = FirebaseStorage.instance.ref('profile_images/${user.uid}.jpg');
      await ref.putFile(File(picked.path));
      final url = await ref.getDownloadURL();
      await FirebaseFirestore.instance.collection('users').doc(user.uid).update({'profileImage': url});
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return const Scaffold(
        body: Center(child: Text('Not logged in')),
      );
    }
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance.collection('users').doc(user.uid).snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
          final data = snapshot.data!.data() as Map<String, dynamic>?;
          if (data == null) return const Center(child: Text('No user data'));
          return Column(
            children: [
              const SizedBox(height: 24),
              GestureDetector(
                onTap: () => _pickAndUploadImage(context, user),
                child: CircleAvatar(
                  radius: 50,
                  backgroundImage: data['profileImage'] != null && data['profileImage'] != ''
                      ? NetworkImage(data['profileImage'])
                      : null,
                  child: data['profileImage'] == null || data['profileImage'] == ''
                      ? const Icon(Icons.person, size: 50)
                      : null,
                ),
              ),
              const SizedBox(height: 16),
              Text(data['name'] ?? '', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              Text(data['email'] ?? '', style: const TextStyle(fontSize: 16)),
              const SizedBox(height: 24),
              const Divider(),
              const Text('My Posts', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              Expanded(child: _UserPostsList(userId: user.uid)),
            ],
          );
        },
      ),
    );
  }
}

class _UserPostsList extends StatelessWidget {
  final String userId;
  const _UserPostsList({required this.userId});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('posts')
          .where('userId', isEqualTo: userId)
          .orderBy('timestamp', descending: true)
          .snapshots(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const Center(child: CircularProgressIndicator());
        final posts = snapshot.data!.docs;
        if (posts.isEmpty) {
          return const Center(child: Text('No posts yet.'));
        }
        return ListView.builder(
          itemCount: posts.length,
          itemBuilder: (context, i) {
            final post = posts[i].data() as Map<String, dynamic>;
            return Card(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: ListTile(
                leading: post['imageUrl'] != null && post['imageUrl'] != ''
                    ? Image.network(post['imageUrl'], width: 50, height: 50, fit: BoxFit.cover)
                    : null,
                title: Text(post['content'] ?? ''),
                subtitle: Text(post['timestamp'] != null
                    ? (post['timestamp'] as Timestamp).toDate().toString()
                    : ''),
              ),
            );
          },
        );
      },
    );
  }
}
