import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/features/daily_news/presentation/bloc/article/remote/remote_article_bloc.dart';
import 'package:news/features/daily_news/presentation/bloc/article/remote/remote_article_state.dart';
import 'package:news/features/daily_news/presentation/widgets/article_widget.dart';

import '../../../domain/entities/article.dart';
import '../article_details/article_detail.dart';
import '../saved_article/saved_article.dart';

class DailyNews extends StatelessWidget {
  const DailyNews({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppbar(context),
      body: _buildBody(),
    );
  }

  _buildAppbar(BuildContext context) {
    return AppBar(
      title: const Text(
        'Daily News',
        style: TextStyle(color: Colors.black),
      ),
      actions: [
        IconButton(
          onPressed: () => _onShowSavedArticlesViewTapped(context),
          icon: const Icon(Icons.bookmark, color: Colors.black),
        ),
      ],
    );
  }

  _buildBody() {
    return BlocBuilder<RemoteArticlesBloc, RemoteArticlesState>(
      builder: (buildContext, state) {
        if (state is RemoteArticlesLoadingState) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is RemoteArticlesErrorState) {
          return const Center(child: Icon(Icons.refresh));
        }
        if (state is RemoteArticlesDoneState) {
          return ListView.builder(
            itemBuilder: (context, index) {
              return ArticleWidget(
                article: state.articles![index],
                onArticlePressed: (article) =>
                    _onArticlePressed(context, article),
              );
            },
            itemCount: state.articles?.length ?? 0,
          );
        }
        return const SizedBox();
      },
    );
  }

  void _onArticlePressed(BuildContext context, ArticleEntity article) {
    // Navigator.pushNamed(context, '/ArticleDetails', arguments: article);
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => ArticleDetailsView(article: article,)));
  }

  void _onShowSavedArticlesViewTapped(BuildContext context) {
    Navigator.push(
        context, MaterialPageRoute(builder: (context) => SavedArticles()));
    // Navigator.pushNamed(context, '/SavedArticles');
  }
}
