import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:threads_clone/presentation/bloc/comments/comments_cubit.dart';
import 'package:threads_clone/presentation/bloc/comments/comments_state.dart';

class CommentInput extends StatefulWidget {
  const CommentInput({super.key});

  @override
  State<CommentInput> createState() => _CommentInputState();
}

class _CommentInputState extends State<CommentInput> {
  late TextEditingController _controller;

  @override
  void initState() {
    _controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Row(
        children: [
          const CircleAvatar(radius: 20, child: Icon(Icons.person)),
          Expanded(
            child: TextFormField(
              controller: _controller,
              onChanged: context.read<CommentsCubit>().inputChanged,
              decoration: InputDecoration(
                hintText: 'Комментарий...',
                border: InputBorder.none,
                hintStyle: TextStyle(fontSize: 14),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
              ),
            ),
          ),

          BlocBuilder<CommentsCubit, CommentsState>(
            builder: (context, state) {
              return IconButton(
                icon: const Icon(Icons.send),
                onPressed: state.canSubmit
                    ? () {
                        context.read<CommentsCubit>().addComment();
                        _controller.clear();
                      }
                    : null,
              );
            },
          ),
        ],
      ),
    );
  }
}
