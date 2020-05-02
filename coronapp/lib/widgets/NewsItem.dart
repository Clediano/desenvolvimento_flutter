import 'package:coronapp/models/news.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewsItem extends StatelessWidget {
  final News news;

  NewsItem(this.news);

  @override
  Widget build(BuildContext context) {
    return Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                ListTile(
                  leading: CircleAvatar(
                    child: Image.network(news.imageUrl == null ? "https://tudoparasuaempresa.com.br/assets/img/!product-image.jpg" : news.imageUrl),
                    backgroundColor: Colors.transparent,
                    maxRadius: 32,
                  ),
                  title: Text(
                    "Título: ${news.title}(${news.author})",
                    overflow: TextOverflow.ellipsis,
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "Data da publicação: ${DateFormat('dd/MM/yyyy').format(DateTime.parse(news.publishedAt))}",
                        textAlign: TextAlign.start,
                      ),
                      Text(
                        "Conteúdo: ${news.content}",
                        textAlign: TextAlign.start,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 4,
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                      child: Text(
                        "Fonte: ${news.source.name}",
                        textAlign: TextAlign.start,
                        softWrap: true,
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                Divider(),
              ],
            ),
          );
  }
}
