import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news/features/daily_news/presentation/bloc/article/remote/remote_article_bloc.dart';
import 'package:news/features/daily_news/presentation/bloc/article/remote/remote_article_event.dart';
import 'package:news/features/daily_news/presentation/pages/home/daily_news.dart';

import 'di/di.dart';
import 'news_observer.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDependencies();
  Bloc.observer=const NewsBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider<RemoteArticlesBloc>(
      create: (BuildContext context) => sl( )..add(GetArticlesEvent()),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(

          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: DailyNews(),
      ),
    );
  }
}
