import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import 'package:newsapp/src/models/category_model.dart';
import 'package:newsapp/src/models/news_models.dart';
import 'package:http/http.dart' as http;

final _URL_NEWS = 'https://newsapi.org/v2/';
final _APIKEY = '4066781f82ea4dd2a7ad77cf0aba0c42';

class NewsService with ChangeNotifier{


  List<Article> headlines = [];
  String _selectedCategory = 'business';
  List<Category> categories = [
      Category(FontAwesomeIcons.building, 'business'),
      Category(FontAwesomeIcons.tv, 'entertainment'),
      Category(FontAwesomeIcons.addressCard, 'general'),
      Category(FontAwesomeIcons.headSideVirus, 'health'),
      Category(FontAwesomeIcons.vials, 'science'),
      Category(FontAwesomeIcons.volleyball, 'sports'),
      Category(FontAwesomeIcons.memory, 'technology'),
  ];
  
  Map<String, List<Article>> categoryArticles = {};

  NewsService(){
    getTopHeadlines();
    for (var item in categories) {
      categoryArticles[item.name] = <Article>[];
     }
  }
  String get selectedCategory => _selectedCategory;

  set selectedCategory(String valor){
    _selectedCategory = valor;
    getArticlesByCategory(valor);
    notifyListeners();
  }

  getTopHeadlines() async{
    final url = '$_URL_NEWS/top-headlines?apiKey=$_APIKEY&country=us';
    final resp = await http.get(Uri.parse(url));

    final newsResponse = newsResponseFromJson(resp.body);
    headlines.addAll(newsResponse.articles);
    notifyListeners();
     
  }
  get getArticulosCategoriaSeleccionada
   =>  categoryArticles[selectedCategory]; 

  getArticlesByCategory(String category) async{
   if (categoryArticles[category]!.isNotEmpty) {
    return categoryArticles[category];
  }
    final url = '$_URL_NEWS/top-headlines?apiKey=$_APIKEY&country=us&category=$category';
    final resp = await http.get(Uri.parse(url));

    final newsResponse = newsResponseFromJson(resp.body);
     categoryArticles[category]!.addAll(newsResponse.articles);
    
    notifyListeners();
  }

}