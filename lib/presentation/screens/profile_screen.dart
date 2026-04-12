import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:threads_clone/data/datasources/local_post_data_source.dart';
import 'package:threads_clone/data/repositories/post_repository_impl.dart';
import 'package:threads_clone/domain/repositories/post_repository.dart';
import 'package:threads_clone/locator.dart';
import 'package:threads_clone/presentation/bloc/profile/profile_cubit.dart';
import 'package:threads_clone/presentation/bloc/profile/profile_state.dart';
import 'package:threads_clone/presentation/widgets/profile_content.dart';
import 'package:threads_clone/presentation/widgets/profile_header.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key, required this.userId});

  final String userId;

  static MaterialPageRoute route(BuildContext context, String userId) {
    return MaterialPageRoute(
      builder: (context) {
        return BlocProvider(
          create: (_) =>
              // ProfileCubit(PostRepositoryImpl(LocalPostDataSource()))
              ProfileCubit(locator<PostRepository>())..loadProfile(userId),
          child: ProfileScreen(userId: userId),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: BlocBuilder<ProfileCubit, ProfileState>(
          builder: (context, state) {
            return Text(
              state.user?.username ?? 'default',
              style: TextStyle(fontWeight: FontWeight.bold),
            );
          },
        ),
      ),
      body: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, state) {
          if (state.status == ProfileStatus.loading) {
            return CircularProgressIndicator();
          }

          if (state.status == ProfileStatus.failuer) {
            return Column(
              children: [
                Text(
                  state.errorMessage ?? 'Ошибка при загрузке',
                  style: TextStyle(fontSize: 16, color: Colors.grey.shade600),
                ),
                const SizedBox(height: 12),
                ElevatedButton(
                  onPressed: () {
                    context.read<ProfileCubit>().loadProfile(userId);
                  },
                  child: Text('Повторить'),
                ),
              ],
            );
          }

          return Column(
            children: [
              ProfileHeader(user: state.user!, isOwnProfile: userId == 'me'),
              ProfileContent(posts: state.posts, isOwnProfile: userId == 'me'),
            ],
          );
        },
      ),
    );
  }
}
