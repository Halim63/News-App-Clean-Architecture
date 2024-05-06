import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/core/resources/data_state.dart';
import 'package:news/features/daily_news/domain/usecases/get_article.dart';
import 'package:news/features/daily_news/presentation/bloc/article/remote/remote_article_event.dart';
import 'package:news/features/daily_news/presentation/bloc/article/remote/remote_article_state.dart';

class RemoteArticlesBloc
    extends Bloc<RemoteArticlesEvent, RemoteArticlesState> {
  final GetArticleUseCase _getArticlesUseCase;

  RemoteArticlesBloc(this._getArticlesUseCase)
      : super(const RemoteArticlesLoadingState()) {
    on<GetArticlesEvent>(onGetArticles);
  }

  void onGetArticles(
      GetArticlesEvent event, Emitter<RemoteArticlesState> emit) async {
    final dataState = await _getArticlesUseCase();
    if (dataState is DataSuccess && dataState.data!.isNotEmpty) {
      emit(RemoteArticlesDoneState(dataState.data!));
    }
    if (dataState is DataFailed) {
      print('message is : ${dataState.error!.message}');
      emit(RemoteArticlesErrorState(dataState.error!));
    }
  }
}
