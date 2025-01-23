import 'package:json_annotation/json_annotation.dart';

part 'response_model.g.dart'; // 파일 이름에 맞게 설정

@JsonSerializable()
class ResponseModel {
  Map<String, dynamic> originJson;
  int? code;
  int? total;
  int? page;
  int? count;
  String? errorMsg;
  ErrorBean? error;

  ResponseModel({
    this.originJson = const {},
    this.code,
    this.total,
    this.errorMsg,
    this.error,
  });

  factory ResponseModel.fromJson(Map<String, dynamic> json) => _$ResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseModelToJson(this);
}

@JsonSerializable()
class ErrorBean {
  final String errorMessage;
  final int errorCode;

  ErrorBean({
    this.errorMessage = '',
    this.errorCode = 0,
  });

  factory ErrorBean.fromJson(Map<String, dynamic> json) => _$ErrorBeanFromJson(json);

  Map<String, dynamic> toJson() => _$ErrorBeanToJson(this);
}
