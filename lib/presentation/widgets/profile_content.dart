import 'package:flutter/material.dart';
import 'package:threads_clone/domain/entities/post.dart';
import 'package:threads_clone/domain/entities/user.dart';

class ProfileContent extends StatelessWidget {
  const ProfileContent({
    super.key,
    required this.user,
    required this.posts,
    required this.isOwnProfile,
  });

  final User user;
  final List<Post> posts;
  final bool isOwnProfile;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(16, 16, 16, 0),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Text(
                          user.username,
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: 16),
                        CircleAvatar(
                          radius: 38,
                          backgroundColor: Colors.grey.shade900,
                          child: Text(user.username[0]),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
