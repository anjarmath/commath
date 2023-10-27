import 'package:commath/features/domain/entity/company_entity.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'company_model.freezed.dart';
part 'company_model.g.dart';

@freezed
class CompanyModel extends CompanyEntity with _$CompanyModel {
  factory CompanyModel({
    required String id,
    required String name,
    required String profile,
    required String cover,
    required String description,
    required String problem,
    required bool verified,
  }) = _CompanyModel;

  factory CompanyModel.fromJson(Map<String, dynamic> json) =>
      _$CompanyModelFromJson(json);
}
