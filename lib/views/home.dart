import 'package:flutter/material.dart';
import '../containers/cards.dart';
import '../containers/newTile.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('News'),
            Text('App', style: TextStyle(color: Colors.yellow)),
          ],
        ),
        centerTitle: true,
      ),
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: CardsList(),
          ),
          SliverToBoxAdapter(
            child: SizedBox(height: 40),
          ),
          ListtNews(category: 'general'),
        ],
      ),
    );
  }
}
