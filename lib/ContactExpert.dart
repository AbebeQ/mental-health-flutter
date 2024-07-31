import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class ContactExpertPage extends StatefulWidget {
  const ContactExpertPage({Key? key}) : super(key: key);

  @override
  _ContactExpertPageState createState() => _ContactExpertPageState();
}

class _ContactExpertPageState extends State<ContactExpertPage> {
  final ImagePicker _picker = ImagePicker();
  File? _image;

  Future<void> _takePhoto(DocumentReference expertRef) async {
    final pickedFile = await _picker.pickImage(source: ImageSource.camera);

    if (pickedFile != null) {
      setState(() {
        _image = File(pickedFile.path);
      });
      // Upload the image to Firebase Storage and update the expert document with the new photo URL
      // You'll need to implement the actual upload and update logic
    }
  }

  void _incrementLikes(DocumentReference expertRef, int currentLikes) {
    expertRef.update({'likes': currentLikes + 1});
  }

  Future<void> _addComment(DocumentReference expertRef, String comment) async {
    final newComment = {
      'user': 'Anonymous', // Replace with actual user data
      'comment': comment,
      'timestamp': FieldValue.serverTimestamp(),
    };

    await expertRef.update({
      'comments': FieldValue.arrayUnion([newComment]),
      'commentsCount': FieldValue.increment(1),
    });
  }

  void _showAddCommentDialog(DocumentReference expertRef) {
    final TextEditingController _commentController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Add a Comment'),
        content: TextField(
          controller: _commentController,
          decoration: InputDecoration(hintText: 'Write your comment here'),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              _addComment(expertRef, _commentController.text);
              Navigator.of(context).pop();
            },
            child: Text('Submit'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contact Expert Page'),
        centerTitle: true,
        backgroundColor: Colors.redAccent.withOpacity(0.8),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('experts')
            .where('approved', isEqualTo: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final experts = snapshot.data!.docs;
            return ListView.builder(
              itemCount: experts.length,
              itemBuilder: (context, index) {
                final expert = experts[index];
                final data = expert.data() as Map<String, dynamic>;
                final name = data['name'] as String? ?? '';
                final age = data['age'] as String? ?? '';
                final email = data['email'] as String? ?? '';
                final phone = data['phone'] as String? ?? '';
                final job = data['job'] as String? ?? '';
                final experience = data['experience'] as String? ?? '';
                final description = data['description'] as String? ?? '';
                final photoUrl = data['photoUrl'] as String? ?? '';
                final likes = data['likes'] as int? ?? 0;
                final commentsCount = data['commentsCount'] as int? ?? 0;
                final comments = data['comments'] as List<dynamic>? ?? [];
                bool isCommentsExpanded = false;

                return StatefulBuilder(
                  builder: (context, setState) {
                    return Container(
                      width: double.infinity,
                      margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                      padding: const EdgeInsets.only(left: 10),
                      decoration: BoxDecoration(
                        color: Colors.black12,
                        borderRadius: BorderRadius.circular(18),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListTile(
                            leading: GestureDetector(
                              onTap: () => _takePhoto(expert.reference),
                              child: CircleAvatar(
                                backgroundImage: photoUrl.isNotEmpty
                                    ? NetworkImage(photoUrl)
                                    : _image != null
                                    ? FileImage(_image!)
                                    : const AssetImage('assets/images/image1.png')
                                as ImageProvider<Object>?,
                                radius: 30,
                              ),
                            ),
                            title: Text(
                              name,
                              style: const TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                                color: Colors.purple,
                              ),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Age: $age'),
                                SizedBox(height: 10),
                                GestureDetector(
                                  onTap: () => launch('mailto:$email'),
                                  child: Row(
                                    children: [
                                      Icon(
                                        Icons.email,
                                        color: Colors.redAccent,
                                      ),
                                      SizedBox(width: 5),
                                      Text(
                                        ' $email',
                                        style: TextStyle(
                                          color: Colors.blue,
                                          decoration: TextDecoration.underline,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 10),
                                GestureDetector(
                                  onTap: () => launch('tel:$phone'),
                                  child: Row(
                                    children: [
                                      Icon(Icons.call, color: Colors.green),
                                      SizedBox(width: 5),
                                      Text(
                                        '$phone',
                                        style: const TextStyle(
                                          color: Colors.blue,
                                          decoration: TextDecoration.underline,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 10),
                                Text('Job: $job'),
                                SizedBox(height: 10),
                                Text('Work Experience: $experience Years'),
                                SizedBox(height: 10),
                                Text('About: $description'),
                                SizedBox(height: 10),
                                Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () => _incrementLikes(expert.reference, likes),
                                      child: Row(
                                        children: [
                                          Icon(Icons.thumb_up, color: Colors.blue),
                                          SizedBox(width: 5),
                                          Text('$likes likes'),
                                        ],
                                      ),
                                    ),
                                    SizedBox(width: 20),
                                    GestureDetector(
                                      onTap: () => setState(() {
                                        isCommentsExpanded = !isCommentsExpanded;
                                      }),
                                      child: Row(
                                        children: [
                                          Icon(Icons.comment, color: Colors.grey),
                                          SizedBox(width: 5),
                                          Text('$commentsCount comments'),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          if (isCommentsExpanded) ...[
                            Column(
                              children: comments
                                  .map((comment) => ListTile(
                                title: Text(comment['user']),
                                subtitle: Text(comment['comment']),
                              ))
                                  .toList(),
                            ),
                            TextButton(
                              onPressed: () => _showAddCommentDialog(expert.reference),
                              child: Text('Add Comment'),
                            ),
                          ],
                        ],
                      ),
                    );
                  },
                );
              },
            );
          } else if (snapshot.hasError) {
            return const Center(child: Text('Failed to load experts'));
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
