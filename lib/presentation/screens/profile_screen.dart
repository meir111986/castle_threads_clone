import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:threads_clone/domain/repositories/post_repository.dart';
import 'package:threads_clone/presentation/bloc/profile/profile_cubit.dart';
import 'package:threads_clone/presentation/bloc/profile/profile_state.dart';
import 'package:threads_clone/presentation/widgets/profile_content.dart';
import 'package:threads_clone/presentation/widgets/profile_header.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key, required this.userId});

  final String userId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ProfileCubit(context.read<PostRepository>())..loadProfile(userId),

      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: BlocBuilder<ProfileCubit, ProfileState>(
            builder: (context, state) {
              if (state.status == ProfileStatus.loaded && state.user != null) {
                return Text(
                  state.user!.username,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                );
              }
              return const Text(
                'Профиль',
                style: TextStyle(fontWeight: FontWeight.bold),
              );
            },
          ),
        ),
        body: BlocBuilder<ProfileCubit, ProfileState>(
          builder: (context, state) {
            if (state.status == ProfileStatus.loading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state.status == ProfileStatus.failuer) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.error_outline,
                      size: 48,
                      color: Colors.grey.shade400,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      state.errorMessage ?? 'Не удалось загрузить профиль',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey.shade600,
                      ),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () {
                        context.read<ProfileCubit>().loadProfile(userId);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        foregroundColor: Colors.white,
                      ),
                      child: const Text('Повторить'),
                    ),
                  ],
                ),
              );
            }

            if (state.status == ProfileStatus.loaded) {
              if (state.user == null) {
                return const Center(
                  child: Text('Данные пользователя не найдены'),
                );
              }
            }

            final isOwnProfile = state.user!.id == 'me';

            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ProfileHeader(user: state.user!, isOwnProfile: isOwnProfile),
                  const SizedBox(height: 8),
                  ProfileContent(
                    posts: state.posts,
                    isOwnProfile: isOwnProfile,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
