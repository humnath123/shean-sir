import 'package:flutter/material.dart';
import 'package:learning/controller/apicall.dart';
import 'package:learning/model/news.dart';

import 'detail.dart';

class dashboard extends StatefulWidget {
  const dashboard({super.key});

  @override
  State<dashboard> createState() => DashboardState();
}

class DashboardState extends State<dashboard> {
  final String imageUrl =
      'https://images.pexels.com/photos/1047517/pexels-photo-1047517.jpeg?auto=compress&cs=tinysrgb&w=500';

  // Horizontal News Item
  Widget horizontallistitem(Size size, Articles item) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Detail(article: item)),
        );
      },
      child: Container(
        width: size.width / 1.4,
        margin: const EdgeInsets.all(12),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: Stack(
            children: [
              SizedBox(
                height: size.height / 4 - 24,
                width: double.infinity,
                child: Image.network(
                  (item.urlToImage?.isNotEmpty ?? false)
                      ? item.urlToImage!
                      : imageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Colors.grey.shade300,
                      child: const Icon(Icons.image_not_supported, size: 50),
                    );
                  },
                ),
              ),

              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [Colors.transparent, Colors.black.withAlpha(210)],
                    ),
                  ),
                ),
              ),

              Positioned(
                left: 15,
                right: 15,
                bottom: 55,
                child: Text(
                  item.title ?? 'No Title',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              Positioned(
                left: 15,
                bottom: 20,
                child: Text(
                  item.publishedAt ?? '',
                  style: const TextStyle(color: Colors.white, fontSize: 12),
                ),
              ),

              const Positioned(
                right: 15,
                bottom: 18,
                child: Icon(Icons.handshake, color: Colors.white, size: 30),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Vertical News Item
  Widget verticallistitem(Size size, Articles item) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Detail(article: item)),
        );
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: SizedBox(
                width: 100,
                height: 100,
                child: Image.network(
                  (item.urlToImage?.isNotEmpty ?? false)
                      ? item.urlToImage!
                      : imageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Colors.grey.shade300,
                      child: const Icon(Icons.image_not_supported),
                    );
                  },
                ),
              ),
            ),

            const SizedBox(width: 12),

            Expanded(
              child: SizedBox(
                height: 100,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      item.title ?? 'No Title',
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    Row(
                      children: [
                        Flexible(
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 6,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              item.source?.name ?? 'News',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 11,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(width: 8),

                        Expanded(
                          child: Text(
                            item.publishedAt ?? '',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 11,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboard'),
        centerTitle: true,
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
      ),

      body: FutureBuilder<news?>(
        future: Apicall().getnewsdata(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.active:
            case ConnectionState.none:
            case ConnectionState.waiting:
              return const Center(
                child: CircularProgressIndicator(color: Colors.red),
              );

            case ConnectionState.done:
              if (snapshot.hasError) {
                return Center(
                  child: Text(
                    'Error: ${snapshot.error}',
                    style: const TextStyle(color: Colors.red),
                  ),
                );
              }

              if (snapshot.hasData &&
                  snapshot.data!.articles != null &&
                  snapshot.data!.articles!.isNotEmpty) {
                final data = snapshot.data!;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Featured News
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 16,
                        top: 16,
                        bottom: 4,
                      ),
                      child: Text(
                        'Featured News',
                        style: Theme.of(context).textTheme.titleLarge
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                    ),

                    SizedBox(
                      height: size.height / 4,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        padding: EdgeInsets.zero,
                        itemCount: data.articles!.length,
                        itemBuilder: (context, index) {
                          return horizontallistitem(
                            size,
                            data.articles![index],
                          );
                        },
                      ),
                    ),

                    // Latest News
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                      child: Text(
                        'Latest News',
                        style: Theme.of(context).textTheme.titleLarge
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                    ),

                    Expanded(
                      child: ListView.builder(
                        itemCount: data.articles!.length,
                        itemBuilder: (context, index) {
                          return verticallistitem(size, data.articles![index]);
                        },
                      ),
                    ),
                  ],
                );
              } else {
                return const Center(child: Text('No News Available'));
              }
          }
        },
      ),
    );
  }
}
