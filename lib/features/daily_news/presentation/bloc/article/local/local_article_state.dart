import 'package:equatable/equatable.dart';

import '../../../../domain/entities/article.dart';

abstract class LocalArticlesState extends Equatable {
  final List<ArticleEntity>? articles;

  const LocalArticlesState({this.articles});

  @override
  List<Object?> get props => [articles];
}

class LocalArticlesLoading extends LocalArticlesState {
  const LocalArticlesLoading();
}

class LocalArticlesDoneState extends LocalArticlesState {
  const LocalArticlesDoneState(List<ArticleEntity> article)
      : super(articles: article);
}
