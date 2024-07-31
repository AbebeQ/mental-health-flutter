import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:url_launcher/url_launcher.dart';

class ApprovePage extends StatefulWidget {
  const ApprovePage({Key? key}) : super(key: key);

  @override
  _ApprovePageState createState() => _ApprovePageState();
}

class _ApprovePageState extends State<ApprovePage> {
  @override
  void initState() {
    super.initState();
    _initializeFirebase();
  }

  Future<void> _initializeFirebase() async {
    await Firebase.initializeApp();
  }

  Future<void> _toggleExpertApproval(String expertId, bool approved) async {
    try {
      CollectionReference experts = FirebaseFirestore.instance.collection('experts');
      await experts.doc(expertId).update({'approved': approved});
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Expert ${approved ? 'approved' : 'unapproved'}')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to ${approved ? 'approve' : 'unapprove'} expert: $e')),
      );
    }
  }

  Future<void> _deleteExpert(String expertId) async {
    try {
      CollectionReference experts = FirebaseFirestore.instance.collection('experts');
      await experts.doc(expertId).delete();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Expert deleted')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to delete expert: $e')),
      );
    }
  }

  void _showFullImage(String imageUrl) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Scaffold(
          appBar: AppBar(
            title: const Text('Image View'),
            backgroundColor: Colors.redAccent.withOpacity(0.8),
          ),
          body: Center(
            child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Image.network(imageUrl),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildExpertItem(DocumentSnapshot<Map<String, dynamic>> expertDoc) {
    final expert = expertDoc.data()!;
    final expertId = expertDoc.id;
    final name = expert['name'];
    final age = expert['age'];
    final email = expert['email'];
    final phone = expert['phone'];
    final job = expert['job'];
    final experience = expert['experience'];
    final description = expert['description'];
    final approved = expert['approved'] ?? false;
    final profileImageUrl = expert['profileImageUrl'];
    final cvDownloadUrl = expert['cvDownloadUrl'];

    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.black12,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                if (profileImageUrl != null)
                  GestureDetector(
                    onTap: () => _showFullImage(profileImageUrl),
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage: NetworkImage(profileImageUrl),
                    ),
                  ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        name,
                        style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),
                      Text('Email: $email'),
                      const SizedBox(height: 10),
                      Text('Age: $age'),
                      const SizedBox(height: 10),
                      Text('Phone: $phone'),
                      const SizedBox(height: 10),
                      Text('Job: $job'),
                      const SizedBox(height: 10),
                      Text('Work Experience: $experience years'),
                      const SizedBox(height: 10),
                      Text('Description: $description'),
                      const SizedBox(height: 10),
                      Text('Approved: ${approved ? 'Yes' : 'No'}'),
                    ],
                  ),
                ),
                Column(
                  children: [
                    IconButton(
                      iconSize: 35,
                      icon: const Icon(Icons.check),
                      color: approved ? Colors.green : Colors.grey,
                      onPressed: () => _toggleExpertApproval(expertId, !approved),
                    ),
                    IconButton(
                      iconSize: 35,
                      icon: const Icon(Icons.delete),
                      color: Colors.red,
                      onPressed: () => _deleteExpert(expertId),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 10),
            ExpansionTile(
              title: const Text('View CV'),
              children: [
                TextButton(
                  onPressed: () async {
                    final Uri url = Uri.parse(cvDownloadUrl);
                    if (await canLaunchUrl(url)) {
                      await launchUrl(url, mode: LaunchMode.externalApplication);
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Could not open CV')),
                      );
                    }
                  },
                  child: const Text('Open CV'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Please Delete or Approve Experts'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        backgroundColor: Colors.redAccent.withOpacity(0.8),
      ),
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: FirebaseFirestore.instance.collection('experts').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final experts = snapshot.data?.docs ?? [];
            return ListView.builder(
              itemCount: experts.length,
              itemBuilder: (context, index) {
                return _buildExpertItem(experts[index]);
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
