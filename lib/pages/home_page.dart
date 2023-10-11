import 'package:flutter/material.dart';
import 'package:news/http_helper/news_http.dart';
import 'package:news/models/news.dart';
import 'package:news/pages/ajout_page.dart';
import 'package:news/pages/details_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var newsHttp = NewsHttp();
  List<NewsModel> news = [];

  @override
  void initState() {
    getAllNews();
    super.initState();
  }

  getAllNews() async {
    news = await newsHttp.getNews();
    setState(() {});
  }

  deleteNews(int id) async {
    await newsHttp.deleteNews(id);
    getAllNews();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('News'),
      ),
      body: news.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: news.length,
              itemBuilder: (context, index) {
                final newsItem = news[index];
                return Card(
                  elevation: 2.0,
                  margin: const EdgeInsets.all(8.0),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(16.0),
                    title: Text(
                      newsItem.title ?? '',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                      ),
                    ),
                    // subtitle: Text(
                    //   newsItem.detail ?? '',
                    //   style: const TextStyle(
                    //     fontSize: 14.0,
                    //   ),
                    // ),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.delete),
                          onPressed: () {
                            // Appeler la fonction de suppression ici
                            deleteNews(newsItem.id!);
                          },
                        ),
                        IconButton(
                          icon: const Icon(Icons.edit),
                          onPressed: () {
                            // Naviguer vers la page d'ajout pour la modification
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AjoutPage(
                                    newsData:
                                        newsItem), // Passer les données de la news à modifier
                              ),
                            );
                          },
                        ),
                        IconButton(
                            icon: const Icon(Icons.info),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      DetailNewsPage(newsId: newsItem.id!)
                                ),
                              );
                            })
                      ],
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Naviguer vers la page d'ajout de nouvelles
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const AjoutPage(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
