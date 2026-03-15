import 'package:flutter/material.dart';
import 'package:threads_clone/data/models/post_model.dart';
import 'package:threads_clone/domain/entities/post.dart';
import 'package:threads_clone/presentation/screens/feed_screen.dart';
import 'package:hive_ce_flutter/hive_ce_flutter.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();
  Hive.registerAdapter(PostModelAdapter());
  await _seedData();

  runApp(const MyApp());
}

Future<void> _seedData() async {
  final box = await Hive.openBox<PostModel>('posts');

  final posts = [
    Post(
      id: '1',
      content: 'Красивый день в Астане',
      authorId: '1',
      createdAt: DateTime.now().toString(),
      likes: 3,
    ),
    Post(
      id: '2',
      content: 'Working on my Flutter project!',
      authorId: '2',
      createdAt: DateTime.now().toString(),
      likes: 6,
    ),
    Post(
      id: '3',
      content: 'Знакомтесь это мой новый пост!',
      authorId: '3',
      createdAt: DateTime.now().toString(),
      likes: 9,
    ),
  ];

  await box.putAll(
    posts.asMap().map(
      (key, post) => MapEntry(post.id, PostModel.fromEntity(post)),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple)),
      home: FeedScreen(),
    );
  }
}
