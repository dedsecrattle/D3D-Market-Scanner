import 'package:d3d_market_scanner_app/side-menu/side_menu_widget.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:html/dom.dart' as dom;
import 'package:url_launcher/url_launcher.dart';

class ForexNews extends StatefulWidget {
  const ForexNews({super.key});

  @override
  State<ForexNews> createState() => _ForexNewsState();
}

class _ForexNewsState extends State<ForexNews> {
  List<Article> articles = [];

  @override
  void initState() {
    super.initState();
    getForexNews();
  }

  Future getForexNews() async {
    final url = Uri.parse("https://www.fxempire.com/news/forex-news");
    final response = await http.get(url);
    dom.Document html = dom.Document.html(response.body);
    final titles = html
        .querySelectorAll('a > h3 > div')
        .map((e) => e.innerHtml.trim())
        .toList();

    final images = html
        .querySelectorAll('picture > img')
        .map((e) => e.attributes['src']!)
        .toList();
    final descriptions =
        html.querySelectorAll('p').map((e) => e.innerHtml.trim()).toList();

    setState(() {
      articles = List.generate(
          titles.length,
          (index) => Article(
              title: titles[index],
              image: images[index],
              description: descriptions[index]));
    });
  }

  Future<void> launchURL(Uri url) async {
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Forex News"),
        backgroundColor: Colors.pink,
        leading: const SideMenuWidget(),
      ),
      body: ListView.builder(
          padding: const EdgeInsets.all(12),
          itemCount: articles.length,
          itemBuilder: (context, index) {
            final article = articles[index];
            return ListTile(
              contentPadding: const EdgeInsets.all(10),
              onTap: () => launchURL(Uri.parse("https//www.fxempire.com")),
              leading: Image.network(
                article.image,
                fit: BoxFit.fitHeight,
                width: 70,
              ),
              title: Text(article.title),
              subtitle: Text(article.description),
            );
          }),
    );
  }
}

class Article {
  final String title;
  final String image;
  final String description;
  const Article(
      {required this.title, required this.image, required this.description});
}
