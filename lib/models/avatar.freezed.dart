// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'avatar.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Avatar _$AvatarFromJson(Map<String, dynamic> json) {
  return _Avatar.fromJson(json);
}

/// @nodoc
mixin _$Avatar {
  AvatarHead get head => throw _privateConstructorUsedError;
  AvatarTorso get torso => throw _privateConstructorUsedError;
  AvatarArms get arms => throw _privateConstructorUsedError;
  AvatarLegs get legs => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AvatarCopyWith<Avatar> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AvatarCopyWith<$Res> {
  factory $AvatarCopyWith(Avatar value, $Res Function(Avatar) then) =
      _$AvatarCopyWithImpl<$Res, Avatar>;
  @useResult
  $Res call(
      {AvatarHead head, AvatarTorso torso, AvatarArms arms, AvatarLegs legs});
}

/// @nodoc
class _$AvatarCopyWithImpl<$Res, $Val extends Avatar>
    implements $AvatarCopyWith<$Res> {
  _$AvatarCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? head = null,
    Object? torso = null,
    Object? arms = null,
    Object? legs = null,
  }) {
    return _then(_value.copyWith(
      head: null == head
          ? _value.head
          : head // ignore: cast_nullable_to_non_nullable
              as AvatarHead,
      torso: null == torso
          ? _value.torso
          : torso // ignore: cast_nullable_to_non_nullable
              as AvatarTorso,
      arms: null == arms
          ? _value.arms
          : arms // ignore: cast_nullable_to_non_nullable
              as AvatarArms,
      legs: null == legs
          ? _value.legs
          : legs // ignore: cast_nullable_to_non_nullable
              as AvatarLegs,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AvatarImplCopyWith<$Res> implements $AvatarCopyWith<$Res> {
  factory _$$AvatarImplCopyWith(
          _$AvatarImpl value, $Res Function(_$AvatarImpl) then) =
      __$$AvatarImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {AvatarHead head, AvatarTorso torso, AvatarArms arms, AvatarLegs legs});
}

/// @nodoc
class __$$AvatarImplCopyWithImpl<$Res>
    extends _$AvatarCopyWithImpl<$Res, _$AvatarImpl>
    implements _$$AvatarImplCopyWith<$Res> {
  __$$AvatarImplCopyWithImpl(
      _$AvatarImpl _value, $Res Function(_$AvatarImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? head = null,
    Object? torso = null,
    Object? arms = null,
    Object? legs = null,
  }) {
    return _then(_$AvatarImpl(
      head: null == head
          ? _value.head
          : head // ignore: cast_nullable_to_non_nullable
              as AvatarHead,
      torso: null == torso
          ? _value.torso
          : torso // ignore: cast_nullable_to_non_nullable
              as AvatarTorso,
      arms: null == arms
          ? _value.arms
          : arms // ignore: cast_nullable_to_non_nullable
              as AvatarArms,
      legs: null == legs
          ? _value.legs
          : legs // ignore: cast_nullable_to_non_nullable
              as AvatarLegs,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AvatarImpl extends _Avatar {
  const _$AvatarImpl(
      {required this.head,
      required this.torso,
      required this.arms,
      required this.legs})
      : super._();

  factory _$AvatarImpl.fromJson(Map<String, dynamic> json) =>
      _$$AvatarImplFromJson(json);

  @override
  final AvatarHead head;
  @override
  final AvatarTorso torso;
  @override
  final AvatarArms arms;
  @override
  final AvatarLegs legs;

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AvatarImpl &&
            (identical(other.head, head) || other.head == head) &&
            (identical(other.torso, torso) || other.torso == torso) &&
            (identical(other.arms, arms) || other.arms == arms) &&
            (identical(other.legs, legs) || other.legs == legs));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, head, torso, arms, legs);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AvatarImplCopyWith<_$AvatarImpl> get copyWith =>
      __$$AvatarImplCopyWithImpl<_$AvatarImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AvatarImplToJson(
      this,
    );
  }
}

abstract class _Avatar extends Avatar {
  const factory _Avatar(
      {required final AvatarHead head,
      required final AvatarTorso torso,
      required final AvatarArms arms,
      required final AvatarLegs legs}) = _$AvatarImpl;
  const _Avatar._() : super._();

  factory _Avatar.fromJson(Map<String, dynamic> json) = _$AvatarImpl.fromJson;

  @override
  AvatarHead get head;
  @override
  AvatarTorso get torso;
  @override
  AvatarArms get arms;
  @override
  AvatarLegs get legs;
  @override
  @JsonKey(ignore: true)
  _$$AvatarImplCopyWith<_$AvatarImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
