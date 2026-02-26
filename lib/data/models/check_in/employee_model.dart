import 'package:json_annotation/json_annotation.dart';

part 'employee_model.g.dart';

@JsonSerializable()
class EmployeeModel {
  final int? id;
  final String? name;

  EmployeeModel({
    this.id,
    this.name,
  });

  factory EmployeeModel.fromJson(Map<String, dynamic> json) => _$EmployeeModelFromJson(json);
  Map<String, dynamic> toJson() => _$EmployeeModelToJson(this);
}