import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:news_app/services/NewsService.dart';
import '../models/ArticleModel.dart';

// Cached network image
class NewsTile extends StatelessWidget {
  const NewsTile({Key? key, required this.articleModel}) : super(key: key);

  final ArticleModel articleModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(6),
          child: Image.network(
            articleModel.image ?? 'Not Found', // Assuming articleModel.image is a valid URL
            height: 150,
            width: 350,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(
          height: 16,
        ),
        Padding(
          padding: const EdgeInsets.all(20.0),
          child: Text(
            articleModel.title ?? '',
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: Colors.black87,
              fontSize: 20,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),

        Padding(
          padding: const EdgeInsets.only(left: 18.0),
          child: Text(
            articleModel.subTitle ?? '',
            maxLines: 2,
            style: const TextStyle(color: Colors.grey, fontSize: 16),
          ),
        ),
        SizedBox(height: 30,)
      ],
    );
  }
}

class ListtNews extends StatelessWidget {
  const ListtNews({Key? key, required this.category}) : super(key: key);

  final String category;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<ArticleModel>>(
      future: NewsService(Dio()).getNews(category),
      builder: (BuildContext context, AsyncSnapshot<List<ArticleModel>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return SliverToBoxAdapter(
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (snapshot.hasError) {
          return SliverToBoxAdapter(
            child: Center(
              child: Text('Error: ${snapshot.error}'),
            ),
          );
        } else {
          return SliverList(
            delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                return NewsTile(articleModel: snapshot.data![index]);
              },
              childCount: snapshot.data!.length,
            ),
          );
        }
      },
    );
  }
}
