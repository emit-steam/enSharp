import 'package:json_annotation/json_annotation.dart';

part 'contact_model.g.dart';

@JsonSerializable()
class ContactModel {
  ///// 기수
  @JsonKey(defaultValue: '')
  final String year;

  ///// 이름
  @JsonKey(defaultValue: '')
  final String name;

  ///// 졸업 여부
  @JsonKey(defaultValue: '')
  final String isGraduation;

  ///// 핸드폰번호
  @JsonKey(defaultValue: '')
  final String phoneNumber;

  ///// 분야
  @JsonKey(defaultValue: '')
  final String field;

  ///// 기술
  @JsonKey(defaultValue: '')
  final String skill;

  ///// 키워드
  @JsonKey(defaultValue: '')
  final String keyword;

  ContactModel({
    this.year,
    this.name,
    this.isGraduation,
    this.phoneNumber,
    this.field,
    this.skill,
    this.keyword,
  });

  /// map에서 새로운 User 인스턴스를 생성하기 위해 필요한 팩토리 생성자입니다.
  /// 생성된 `_$UserFromJson()` 생성자에게 map을 전달해줍니다.
  /// 생성자의 이름은 클래스의 이름을 따릅니다. 본 예제의 경우 User를 따릅니다.
  factory ContactModel.fromJson(Map<String, dynamic> json) => _$ContactModelFromJson(json);

  /// `toJson`은 클래스가 JSON 인코딩의 지원을 선언하는 규칙입니다.
  /// 이의 구현은 생성된 private 헬퍼 메서드 `_$UserToJson`을 단순히 호출합니다.
  Map<String, dynamic> toJson() => _$ContactModelToJson(this);
}
