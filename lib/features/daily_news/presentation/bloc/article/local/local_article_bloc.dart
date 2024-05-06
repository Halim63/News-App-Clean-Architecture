import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../domain/usecases/get_saved_article.dart';
import '../../../../domain/usecases/remove_article.dart';
import '../../../../domain/usecases/save_article.dart';
import 'local_article_event.dart';
import 'local_article_state.dart';

class LocalArticlesBloc extends Bloc<LocalArticlesEvent, LocalArticlesState> {
  final GetSavedArticleUseCase _getSavedArticleUseCase;
  final SaveArticleUseCase _saveArticleUseCase;
  final RemoveArticleUseCase _removeArticleUseCase;

  LocalArticlesBloc(this._getSavedArticleUseCase, this._saveArticleUseCase,
      this._removeArticleUseCase)
      : super(const LocalArticlesLoading()){
    on <GetSavedArticlesEvent> (onGetSavedArticles);
    on <RemoveArticleEvent> (onRemoveArticle);
    on <SaveArticleEvent> (onSaveArticle);
  }


  Future<void> onGetSavedArticles(GetSavedArticlesEvent event,Emitter<LocalArticlesState> emit) async {
    final articles = await _getSavedArticleUseCase();
    emit(LocalArticlesDoneState(articles));
  }

  void onRemoveArticle(RemoveArticleEvent removeArticle,Emitter<LocalArticlesState> emit) async {
    await _removeArticleUseCase(params: removeArticle.article);
    final articles = await _getSavedArticleUseCase();
    emit(LocalArticlesDoneState(articles));
  }

  void onSaveArticle(SaveArticleEvent saveArticle,Emitter<LocalArticlesState> emit) async {
    await _saveArticleUseCase(params: saveArticle.article);
    final articles = await _getSavedArticleUseCase();
    emit(LocalArticlesDoneState(articles));
  }
}