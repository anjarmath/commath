import 'package:commath/features/domain/entity/topic_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'topic_model.freezed.dart';
part 'topic_model.g.dart';

@freezed
class TopicModel extends TopicEntity with _$TopicModel {
  factory TopicModel({
    required String id,
    required String name,
  }) = _TopicModel;

  factory TopicModel.fromJson(Map<String, dynamic> json) =>
      _$TopicModelFromJson(json);
}
