import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_ce/hive.dart';
// import 'package:threads_clone/domain/entities/post.dart';

part 'post_model.freezed.dart';
part 'post_model.g.dart';

@freezed
@HiveType(typeId: 0)
abstract class PostModel with _$PostModel {
  const factory PostModel({
    @HiveField(0) required String id,
    @HiveField(1) required String content,
    @HiveField(2) required String authorId,
    @HiveField(3) required String createdAt,
    @HiveField(4) required int likes,
  }) = _PostModel;

  factory PostModel.fromJson(Map<String, dynamic> json) =>
      _$PostModelFromJson(json);
}

// class PostModel extends HiveObject {
//   @HiveField(0)
//   final String id;
//   @HiveField(1)
//   final String content;
//   @HiveField(2)
//   final String authorId;
//   @HiveField(3)
//   final String createdAt;
//   @HiveField(4)
//   final int likes;

//   PostModel({
//     required this.id,
//     required this.content,
//     required this.authorId,
//     required this.createdAt,
//     required this.likes,
//   });

//   Post toEntity() {
//     return Post(
//       id: id,
//       content: content,
//       authorId: authorId,
//       createdAt: createdAt,
//       likes: likes,
//     );
//   }
// }
