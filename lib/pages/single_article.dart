import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:html/dom.dart' as dom;
import 'package:icilome_mobile/common/screen_arguments.dart';
import 'package:icilome_mobile/pages/comments.dart';
import 'package:share/share.dart';

class SingleArticle extends StatefulWidget {
  @override
  _SingleArticleState createState() => _SingleArticleState();
}

class _SingleArticleState extends State<SingleArticle> {
  @override
  Widget build(BuildContext context) {
    final SingleArticleScreenArguments args =
        ModalRoute.of(context).settings.arguments;

    final article = args.article;
    final heroId = args.heroId;

    return Scaffold(
      body: Container(
          decoration: BoxDecoration(color: Colors.white70),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: <Widget>[
                Stack(
                  children: <Widget>[
                    Container(
                      child: Hero(
                        tag: heroId,
                        child: ClipRRect(
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(60.0)),
                          child: ColorFiltered(
                              colorFilter: ColorFilter.mode(
                                  Colors.black.withOpacity(0.3),
                                  BlendMode.overlay),
                              child: Image.network(
                                article.image,
                                fit: BoxFit.cover,
                              )),
                        ),
                      ),
                    ),
                    Positioned(
                      top: MediaQuery.of(context).padding.top,
                      child: IconButton(
                        icon: Icon(Icons.arrow_back),
                        color: Colors.white,
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ),
                  ],
                ),
                Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Html(
                          data: "<h1>" + article.title + "</h1>",
                          padding: EdgeInsets.fromLTRB(16, 16, 16, 8),
                          customTextStyle:
                              (dom.Node node, TextStyle baseStyle) {
                            if (node is dom.Element) {
                              switch (node.localName) {
                                case "h1":
                                  return baseStyle.merge(TextStyle(
                                      fontSize: 16,
                                      fontFamily: "Poppins",
                                      color: Colors.black,
                                      fontWeight: FontWeight.w500));
                              }
                            }
                            return baseStyle;
                          }),
                      Container(
                        height: 5,
                        width: 75,
                        margin: EdgeInsets.fromLTRB(18, 0, 16, 8),
                        alignment: Alignment.topLeft,
                        decoration: BoxDecoration(color: Colors.blueAccent),
                      ),
                      Container(
                        decoration: BoxDecoration(color: Colors.black),
                        margin: EdgeInsets.fromLTRB(18, 8, 16, 8),
                        padding: EdgeInsets.fromLTRB(8, 4, 8, 4),
                        child: Text(
                          article.category,
                          style: TextStyle(color: Colors.white, fontSize: 12),
                        ),
                      ),
                      SizedBox(
                        height: 45,
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(article.avatar),
                          ),
                          title: Text(
                            "By " + article.author,
                            style: TextStyle(fontSize: 12),
                          ),
                          subtitle: Text(
                            article.date,
                            style: TextStyle(fontSize: 11),
                          ),
                        ),
                      ),
                      Html(
                          data: "<div>" + article.content + "</div>",
                          padding: EdgeInsets.fromLTRB(16, 36, 16, 50),
                          customTextStyle:
                              (dom.Node node, TextStyle baseStyle) {
                            if (node is dom.Element) {
                              switch (node.localName) {
                                case "div":
                                  return baseStyle.merge(TextStyle(
                                      fontSize: 15,
                                      color: Colors.black87,
                                      fontFamily: "Nunito"));
                              }
                            }
                            return baseStyle;
                          }),
                    ],
                  ),
                )
              ],
            ),
          )),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          decoration: BoxDecoration(color: Colors.white10),
          height: 50,
          padding: EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              Container(
                decoration: BoxDecoration(),
                child: IconButton(
                  padding: EdgeInsets.all(0),
                  icon: Icon(
                    Icons.favorite_border,
                    color: Colors.red,
                    size: 24.0,
                  ),
                  onPressed: () {
                    // Favourite post
                  },
                ),
              ),
              Container(
                child: IconButton(
                  padding: EdgeInsets.all(0),
                  icon: Icon(
                    Icons.comment,
                    color: Colors.blue,
                    size: 24.0,
                  ),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Comments(),
                            fullscreenDialog: true,
                            settings: RouteSettings(
                              arguments: CommentScreenArguments(article.id),
                            )));
                  },
                ),
              ),
              Container(
                child: IconButton(
                  padding: EdgeInsets.all(0),
                  icon: Icon(
                    Icons.share,
                    color: Colors.green,
                    size: 24.0,
                  ),
                  onPressed: () {
                    Share.share('check out my website https://example.com');
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
