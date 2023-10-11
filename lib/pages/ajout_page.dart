import 'package:flutter/material.dart';
import 'package:news/http_helper/news_http.dart';
import 'package:news/models/news.dart';
//import 'package:news/pages/home_page.dart';

class AjoutPage extends StatefulWidget {
 // const AjoutPage({super.key});
  final NewsModel?
      newsData; // Recevoir les données de la news à modifier, null pour ajouter une nouvelle news

  const AjoutPage({super.key, this.newsData});

  @override
  State<AjoutPage> createState() => _AjoutPageState();
}

class _AjoutPageState extends State<AjoutPage> {
  var newsHttp = NewsHttp();
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _detailController = TextEditingController();
  bool _isEditMode = false; // Ajoutez un booléen pour le mode "modification"
   
   createNews(data) async {
     var response = await newsHttp.createNews(data);
     setState(() {});
   }

   updateNews(int id,data) async {
    var response = await newsHttp.updateNews(id , data);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    // Vérifiez si des données de news ont été passées pour déterminer si vous êtes en mode "modification"
    if (widget.newsData != null) {
      _isEditMode = true;
      // Pré-remplir les champs avec les données de la news
      _titleController.text = widget.newsData!.title ?? '';
      _detailController.text = widget.newsData!.detail ?? '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isEditMode ? 'Modifier la News' : 'Ajouter une News'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              TextFormField(
                controller: _titleController,
                decoration: const InputDecoration(labelText: 'Titre'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Veuillez saisir un titre';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _detailController,
                decoration: const InputDecoration(labelText: 'Détail'),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Veuillez saisir un détail';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    // Les données du formulaire sont valides, vous pouvez ajouter/modifier la news ici
                    final title = _titleController.text;
                    final detail = _detailController.text;

                    // Créez un Map avec les données à envoyer
                    final data = {
                      'title': title,
                      'detail': detail,
                    };

                    if (_isEditMode) {
                      // Si en mode "modification", utilisez la fonction de modification ici
                      // Appelez la fonction pour mettre à jour la news avec les données saisies
                      updateNews(widget.newsData!.id!,
                          data); // Utilisez votre fonction de mise à jour
                    } else {
                      // Si en mode "ajout", utilisez la fonction d'ajout ici
                      // Appelez la fonction pour créer la nouvelle news avec les données saisies
                      createNews(data); // Utilisez votre fonction d'ajout
                    }

                    // Revenez à la page précédente
                    Navigator.of(context).pop();
                  }
                },
                child: Text(_isEditMode ? 'Modifier' : 'Ajouter'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

