import 'dart:io';

import 'package:care_bridge/res/color.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class CommunityScreen extends StatefulWidget {
  const CommunityScreen({super.key});

  @override
  State<CommunityScreen> createState() => _CommunityScreenState();
}

class _CommunityScreenState extends State<CommunityScreen> {
  final TextEditingController _captionController = TextEditingController();
  File? _selectedImage;
  final List<Map<String, dynamic>> _posts = [];

  // Pick image from gallery
  Future<void> _pickImage() async {
    final pickedFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  // Post the image with caption
  void _postImage() {
    if (_selectedImage != null && _captionController.text.isNotEmpty) {
      setState(() {
        _posts.insert(0, {
          "image": _selectedImage,
          "caption": _captionController.text,
          "time": DateTime.now(),
        });
        _selectedImage = null;
        _captionController.clear();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "Community",
          style: TextStyle(
            color: Colors.black,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Upload Section
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Row(
              children: [
                GestureDetector(
                  onTap: _pickImage,
                  child: CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.grey.shade300,
                    child: _selectedImage == null
                        ? const Icon(Icons.add_a_photo,
                            size: 30, color: Colors.black)
                        : ClipOval(
                            child: Image.file(
                              _selectedImage!,
                              width: 60,
                              height: 60,
                              fit: BoxFit.cover,
                            ),
                          ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: TextField(
                    controller: _captionController,
                    decoration: InputDecoration(
                      hintText: "Write your views...",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: _postImage,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.selectedItem,
                  ),
                  child: const Text("Post"),
                ),
              ],
            ),
          ),

          // Divider
          const Divider(),

          // Posts Feed
          Expanded(
            child: _posts.isEmpty
                ? const Center(
                    child: Text(
                      "No posts yet. Upload your first post!",
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  )
                : ListView.builder(
                    itemCount: _posts.length,
                    itemBuilder: (context, index) {
                      return PostCard(
                        image: _posts[index]["image"],
                        caption: _posts[index]["caption"],
                        time: _posts[index]["time"],
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

// Post Card Widget
class PostCard extends StatelessWidget {
  final File image;
  final String caption;
  final DateTime time;

  const PostCard({
    super.key,
    required this.image,
    required this.caption,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(10),
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
            child: Image.file(image,
                width: double.infinity, fit: BoxFit.cover, height: 250),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  caption,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 5),
                Text(
                  "${time.hour}:${time.minute} • ${time.day}/${time.month}/${time.year}",
                  style: const TextStyle(fontSize: 14, color: Colors.grey),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
