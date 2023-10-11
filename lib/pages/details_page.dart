import 'package:flutter/material.dart';
import 'package:news/http_helper/news_http.dart';
import 'package:news/models/news.dart';

class DetailNewsPage extends StatefulWidget {
  final int newsId;

  const DetailNewsPage({Key? key, required this.newsId}) : super(key: key);


  @override
  State<DetailNewsPage> createState() => _DetailNewsPageState();
}

class _DetailNewsPageState extends State<DetailNewsPage> {
  NewsModel? newsItem;
  var newsHttp = NewsHttp();

  @override
  void initState() {
    getNewsDetails();
    super.initState();
  }

// Future<void> getNewsDetails() async {
//     try {
//       final response = await newsHttp.getNewsById(widget.newsId);
//       setState(() {
//         newsItem = response;
//       });
//     } catch (e) {
//       print('Erreur lors de la récupération des détails de la news : $e');
//     }
//   }

getNewsDetails() async {
    final response = await newsHttp.getNewsById(widget.newsId);
    setState(() {
       newsItem = response;
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Détails de la News'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: newsItem != null
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    newsItem!.title ?? '',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 24.0,
                    ),
                  ),
                  const SizedBox(height: 16.0),
                  Text(
                    newsItem!.detail ?? '',
                    style: const TextStyle(fontSize: 18.0),
                  ),
                  const SizedBox(height: 32.0),
                  ElevatedButton(
                    onPressed: () {
                      // Revenir à la page précédente
                      Navigator.pop(context);
                    },
                    child: const Text('Retour'),
                  ),
                ],
              )
            : const Center(
                child: CircularProgressIndicator(),
              ),
      ),
    );
  }
}
