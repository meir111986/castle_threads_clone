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
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(
          left: 16,
          right: 8,
          top: 8,
          bottom: MediaQuery.of(context).viewInsets.bottom > 0 ? 4 : 8,
        ),
        child: Row(
          children: [
            const CircleAvatar(
              radius: 16,
              backgroundColor: Colors.black,
              child: Text(
                'M',
                style: TextStyle(color: Colors.white, fontSize: 12),
              ),
            ),
            SizedBox(width: 20),
            Expanded(
              child: BlocBuilder<CommentsCubit, CommentsState>(
                buildWhen: (prev, curr) => prev.inputText != curr.inputText,
                builder: (context, state) {
                  return TextFormField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: 'Добавить комментарий...',
                      border: InputBorder.none,
                      hintStyle: TextStyle(color: Colors.grey.shade400),
                      contentPadding: EdgeInsets.zero,
                    ),
                    onChanged: (String value) {
                      context.read<CommentsCubit>().inputChanged(value);
                    },
                    onFieldSubmitted: (_) => _submit(context),
                  );
                },
              ),
            ),
            IconButton(
              onPressed: () {
                _submit(context);
              },
              icon: Icon(Icons.send_rounded),
            ),
          ],
        ),
      ),
    );
  }

  void _submit(BuildContext context) {
    context.read<CommentsCubit>().addComment();
    _controller.clear();
  }
}
