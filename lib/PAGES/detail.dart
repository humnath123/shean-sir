import 'package:flutter/material.dart';
import 'package:learning/model/news.dart';

class Detail extends StatelessWidget {
  final Articles article;

  const Detail({super.key, required this.article});

  final String imageUrl =
      'https://images.pexels.com/photos/1047517/pexels-photo-1047517.jpeg?auto=compress&cs=tinysrgb&w=500';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('News Details'),
        centerTitle: true,
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
      ),

      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // News Image
            SizedBox(
              width: double.infinity,
              height: 250,
              child: Image.network(
                (article.urlToImage?.isNotEmpty ?? false)
                    ? article.urlToImage!
                    : imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    color: Colors.grey.shade300,
                    child: const Icon(Icons.image_not_supported, size: 60),
                  );
                },
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Source
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      article.source?.name ?? 'News',
                      style: const TextStyle(color: Colors.white, fontSize: 13),
                    ),
                  ),

                  const SizedBox(height: 15),

                  // Title
                  Text(
                    article.title ?? 'No Title Available',
                    style: const TextStyle(
                      fontSize: 23,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 12),

                  // Author
                  Text(
                    'Author: ${article.author ?? 'Unknown'}',
                    style: TextStyle(fontSize: 13, color: Colors.grey.shade700),
                  ),

                  const SizedBox(height: 5),

                  // Published Date
                  Text(
                    article.publishedAt ?? '',
                    style: TextStyle(fontSize: 13, color: Colors.grey.shade600),
                  ),

                  const Divider(height: 30),

                  // Description
                  const Text(
                    'Description',
                    style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 10),

                  Text(
                    article.description ?? 'No Description Available',
                    style: const TextStyle(fontSize: 16, height: 1.6),
                  ),

                  const SizedBox(height: 20),

                  // Full Content
                  const Text(
                    'Full Content',
                    style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold),
                  ),

                  const SizedBox(height: 10),

                  Text(
                    article.content ?? 'No Content Available',
                    style: const TextStyle(fontSize: 16, height: 1.6),
                  ),

                  const SizedBox(height: 25),

                  // News URL
                  if (article.url != null)
                    SelectableText(
                      'News URL: ${article.url}',
                      style: const TextStyle(color: Colors.blue, fontSize: 14),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
