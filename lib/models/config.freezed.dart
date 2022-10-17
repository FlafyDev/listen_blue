// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'config.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$Config {
  Color? get backgroundColor => throw _privateConstructorUsedError;
  Color? get primaryColor => throw _privateConstructorUsedError;
  List<Playlist> get playlists => throw _privateConstructorUsedError;
  List<Directory> get mediaDirectories => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ConfigCopyWith<Config> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ConfigCopyWith<$Res> {
  factory $ConfigCopyWith(Config value, $Res Function(Config) then) =
      _$ConfigCopyWithImpl<$Res>;
  $Res call(
      {Color? backgroundColor,
      Color? primaryColor,
      List<Playlist> playlists,
      List<Directory> mediaDirectories});
}

/// @nodoc
class _$ConfigCopyWithImpl<$Res> implements $ConfigCopyWith<$Res> {
  _$ConfigCopyWithImpl(this._value, this._then);

  final Config _value;
  // ignore: unused_field
  final $Res Function(Config) _then;

  @override
  $Res call({
    Object? backgroundColor = freezed,
    Object? primaryColor = freezed,
    Object? playlists = freezed,
    Object? mediaDirectories = freezed,
  }) {
    return _then(_value.copyWith(
      backgroundColor: backgroundColor == freezed
          ? _value.backgroundColor
          : backgroundColor // ignore: cast_nullable_to_non_nullable
              as Color?,
      primaryColor: primaryColor == freezed
          ? _value.primaryColor
          : primaryColor // ignore: cast_nullable_to_non_nullable
              as Color?,
      playlists: playlists == freezed
          ? _value.playlists
          : playlists // ignore: cast_nullable_to_non_nullable
              as List<Playlist>,
      mediaDirectories: mediaDirectories == freezed
          ? _value.mediaDirectories
          : mediaDirectories // ignore: cast_nullable_to_non_nullable
              as List<Directory>,
    ));
  }
}

/// @nodoc
abstract class _$$_ConfigCopyWith<$Res> implements $ConfigCopyWith<$Res> {
  factory _$$_ConfigCopyWith(_$_Config value, $Res Function(_$_Config) then) =
      __$$_ConfigCopyWithImpl<$Res>;
  @override
  $Res call(
      {Color? backgroundColor,
      Color? primaryColor,
      List<Playlist> playlists,
      List<Directory> mediaDirectories});
}

/// @nodoc
class __$$_ConfigCopyWithImpl<$Res> extends _$ConfigCopyWithImpl<$Res>
    implements _$$_ConfigCopyWith<$Res> {
  __$$_ConfigCopyWithImpl(_$_Config _value, $Res Function(_$_Config) _then)
      : super(_value, (v) => _then(v as _$_Config));

  @override
  _$_Config get _value => super._value as _$_Config;

  @override
  $Res call({
    Object? backgroundColor = freezed,
    Object? primaryColor = freezed,
    Object? playlists = freezed,
    Object? mediaDirectories = freezed,
  }) {
    return _then(_$_Config(
      backgroundColor: backgroundColor == freezed
          ? _value.backgroundColor
          : backgroundColor // ignore: cast_nullable_to_non_nullable
              as Color?,
      primaryColor: primaryColor == freezed
          ? _value.primaryColor
          : primaryColor // ignore: cast_nullable_to_non_nullable
              as Color?,
      playlists: playlists == freezed
          ? _value._playlists
          : playlists // ignore: cast_nullable_to_non_nullable
              as List<Playlist>,
      mediaDirectories: mediaDirectories == freezed
          ? _value._mediaDirectories
          : mediaDirectories // ignore: cast_nullable_to_non_nullable
              as List<Directory>,
    ));
  }
}

/// @nodoc

class _$_Config implements _Config {
  const _$_Config(
      {required this.backgroundColor,
      required this.primaryColor,
      required final List<Playlist> playlists,
      required final List<Directory> mediaDirectories})
      : _playlists = playlists,
        _mediaDirectories = mediaDirectories;

  @override
  final Color? backgroundColor;
  @override
  final Color? primaryColor;
  final List<Playlist> _playlists;
  @override
  List<Playlist> get playlists {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_playlists);
  }

  final List<Directory> _mediaDirectories;
  @override
  List<Directory> get mediaDirectories {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_mediaDirectories);
  }

  @override
  String toString() {
    return 'Config(backgroundColor: $backgroundColor, primaryColor: $primaryColor, playlists: $playlists, mediaDirectories: $mediaDirectories)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Config &&
            const DeepCollectionEquality()
                .equals(other.backgroundColor, backgroundColor) &&
            const DeepCollectionEquality()
                .equals(other.primaryColor, primaryColor) &&
            const DeepCollectionEquality()
                .equals(other._playlists, _playlists) &&
            const DeepCollectionEquality()
                .equals(other._mediaDirectories, _mediaDirectories));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(backgroundColor),
      const DeepCollectionEquality().hash(primaryColor),
      const DeepCollectionEquality().hash(_playlists),
      const DeepCollectionEquality().hash(_mediaDirectories));

  @JsonKey(ignore: true)
  @override
  _$$_ConfigCopyWith<_$_Config> get copyWith =>
      __$$_ConfigCopyWithImpl<_$_Config>(this, _$identity);
}

abstract class _Config implements Config {
  const factory _Config(
      {required final Color? backgroundColor,
      required final Color? primaryColor,
      required final List<Playlist> playlists,
      required final List<Directory> mediaDirectories}) = _$_Config;

  @override
  Color? get backgroundColor;
  @override
  Color? get primaryColor;
  @override
  List<Playlist> get playlists;
  @override
  List<Directory> get mediaDirectories;
  @override
  @JsonKey(ignore: true)
  _$$_ConfigCopyWith<_$_Config> get copyWith =>
      throw _privateConstructorUsedError;
}
