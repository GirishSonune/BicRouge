import 'package:bicrouge/components/drawer.dart';
import 'package:bicrouge/pages/course_create_page.dart';
import 'package:bicrouge/pages/scaned_document.dart';
import 'package:flutter/material.dart';

class CoursesPage extends StatelessWidget {
  const CoursesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset('assets/logo.png', height: 40), // BicRouge Logo
            Row(
              children: [
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CourseCreatePage(),
                      ),
                    );
                  },
                  icon: const Icon(Icons.add),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ScanedDocument(),
                      ),
                    );
                  },
                  icon: const Icon(Icons.document_scanner_rounded),
                ),
              ],
            ),
          ],
        ),
        backgroundColor: Colors.grey[100],
        elevation: 0,
      ),
      drawer: AppDrawer(),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // First Card
          _buildCourseCard(
            title: 'Human Interaction...',
            author: 'Patrick Vingi',
            profileImage: 'assets/person1.png',
            backgroundColor: Colors.blueGrey[200]!,
          ),
          const SizedBox(height: 20),
          // Second Card
          _buildCourseCard(
            title: 'Human Interaction...',
            author: 'Patrick Vingi',
            profileImage: 'assets/person2.png',
            backgroundColor: Colors.blueGrey[700]!,
          ),
        ],
      ),
    );
  }

  // Helper method to create course cards
  Widget _buildCourseCard({
    required String title,
    required String author,
    required String profileImage,
    required Color backgroundColor,
  }) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 5,
      child: Column(
        children: [
          // Course Header with Image and Title
          Container(
            decoration: BoxDecoration(
              color: backgroundColor,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15),
              ),
            ),
            padding: const EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title and Author
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 5),
                      Text(
                        author,
                        style:
                            const TextStyle(fontSize: 14, color: Colors.white),
                      ),
                    ],
                  ),
                ),
                // More options icon
                IconButton(
                  onPressed: () {
                    // Handle more options
                  },
                  icon: const Icon(Icons.more_vert, color: Colors.white),
                ),
                // Profile image
                CircleAvatar(
                  radius: 25,
                  backgroundImage: AssetImage(profileImage),
                ),
              ],
            ),
          ),
          // Bottom Icon (Clipboard)
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Align(
              alignment: Alignment.bottomRight,
              child: IconButton(
                onPressed: () {
                  // Handle clipboard logic here
                },
                icon: const Icon(Icons.assignment, color: Colors.grey),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
