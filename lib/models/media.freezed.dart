// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'media.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$MediaCollectionFile {
  File get file => throw _privateConstructorUsedError;
  Map<String, LocalMedia> get media => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $MediaCollectionFileCopyWith<MediaCollectionFile> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MediaCollectionFileCopyWith<$Res> {
  factory $MediaCollectionFileCopyWith(
          MediaCollectionFile value, $Res Function(MediaCollectionFile) then) =
      _$MediaCollectionFileCopyWithImpl<$Res>;
  $Res call({File file, Map<String, LocalMedia> media});
}

/// @nodoc
class _$MediaCollectionFileCopyWithImpl<$Res>
    implements $MediaCollectionFileCopyWith<$Res> {
  _$MediaCollectionFileCopyWithImpl(this._value, this._then);

  final MediaCollectionFile _value;
  // ignore: unused_field
  final $Res Function(MediaCollectionFile) _then;

  @override
  $Res call({
    Object? file = freezed,
    Object? media = freezed,
  }) {
    return _then(_value.copyWith(
      file: file == freezed
          ? _value.file
          : file // ignore: cast_nullable_to_non_nullable
              as File,
      media: media == freezed
          ? _value.media
          : media // ignore: cast_nullable_to_non_nullable
              as Map<String, LocalMedia>,
    ));
  }
}

/// @nodoc
abstract class _$$_MediaCollectionFileCopyWith<$Res>
    implements $MediaCollectionFileCopyWith<$Res> {
  factory _$$_MediaCollectionFileCopyWith(_$_MediaCollectionFile value,
          $Res Function(_$_MediaCollectionFile) then) =
      __$$_MediaCollectionFileCopyWithImpl<$Res>;
  @override
  $Res call({File file, Map<String, LocalMedia> media});
}

/// @nodoc
class __$$_MediaCollectionFileCopyWithImpl<$Res>
    extends _$MediaCollectionFileCopyWithImpl<$Res>
    implements _$$_MediaCollectionFileCopyWith<$Res> {
  __$$_MediaCollectionFileCopyWithImpl(_$_MediaCollectionFile _value,
      $Res Function(_$_MediaCollectionFile) _then)
      : super(_value, (v) => _then(v as _$_MediaCollectionFile));

  @override
  _$_MediaCollectionFile get _value => super._value as _$_MediaCollectionFile;

  @override
  $Res call({
    Object? file = freezed,
    Object? media = freezed,
  }) {
    return _then(_$_MediaCollectionFile(
      file: file == freezed
          ? _value.file
          : file // ignore: cast_nullable_to_non_nullable
              as File,
      media: media == freezed
          ? _value._media
          : media // ignore: cast_nullable_to_non_nullable
              as Map<String, LocalMedia>,
    ));
  }
}

/// @nodoc

class _$_MediaCollectionFile implements _MediaCollectionFile {
  const _$_MediaCollectionFile(
      {required this.file, required final Map<String, LocalMedia> media})
      : _media = media;

  @override
  final File file;
  final Map<String, LocalMedia> _media;
  @override
  Map<String, LocalMedia> get media {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_media);
  }

  @override
  String toString() {
    return 'MediaCollectionFile(file: $file, media: $media)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_MediaCollectionFile &&
            const DeepCollectionEquality().equals(other.file, file) &&
            const DeepCollectionEquality().equals(other._media, _media));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(file),
      const DeepCollectionEquality().hash(_media));

  @JsonKey(ignore: true)
  @override
  _$$_MediaCollectionFileCopyWith<_$_MediaCollectionFile> get copyWith =>
      __$$_MediaCollectionFileCopyWithImpl<_$_MediaCollectionFile>(
          this, _$identity);
}

abstract class _MediaCollectionFile implements MediaCollectionFile {
  const factory _MediaCollectionFile(
      {required final File file,
      required final Map<String, LocalMedia> media}) = _$_MediaCollectionFile;

  @override
  File get file;
  @override
  Map<String, LocalMedia> get media;
  @override
  @JsonKey(ignore: true)
  _$$_MediaCollectionFileCopyWith<_$_MediaCollectionFile> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$MediaMetadata {
  String get title => throw _privateConstructorUsedError;
  List<String> get authors => throw _privateConstructorUsedError;
  ImageProvider<Object>? get squareImage => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $MediaMetadataCopyWith<MediaMetadata> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MediaMetadataCopyWith<$Res> {
  factory $MediaMetadataCopyWith(
          MediaMetadata value, $Res Function(MediaMetadata) then) =
      _$MediaMetadataCopyWithImpl<$Res>;
  $Res call(
      {String title, List<String> authors, ImageProvider<Object>? squareImage});
}

/// @nodoc
class _$MediaMetadataCopyWithImpl<$Res>
    implements $MediaMetadataCopyWith<$Res> {
  _$MediaMetadataCopyWithImpl(this._value, this._then);

  final MediaMetadata _value;
  // ignore: unused_field
  final $Res Function(MediaMetadata) _then;

  @override
  $Res call({
    Object? title = freezed,
    Object? authors = freezed,
    Object? squareImage = freezed,
  }) {
    return _then(_value.copyWith(
      title: title == freezed
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      authors: authors == freezed
          ? _value.authors
          : authors // ignore: cast_nullable_to_non_nullable
              as List<String>,
      squareImage: squareImage == freezed
          ? _value.squareImage
          : squareImage // ignore: cast_nullable_to_non_nullable
              as ImageProvider<Object>?,
    ));
  }
}

/// @nodoc
abstract class _$$_MediaMetadataCopyWith<$Res>
    implements $MediaMetadataCopyWith<$Res> {
  factory _$$_MediaMetadataCopyWith(
          _$_MediaMetadata value, $Res Function(_$_MediaMetadata) then) =
      __$$_MediaMetadataCopyWithImpl<$Res>;
  @override
  $Res call(
      {String title, List<String> authors, ImageProvider<Object>? squareImage});
}

/// @nodoc
class __$$_MediaMetadataCopyWithImpl<$Res>
    extends _$MediaMetadataCopyWithImpl<$Res>
    implements _$$_MediaMetadataCopyWith<$Res> {
  __$$_MediaMetadataCopyWithImpl(
      _$_MediaMetadata _value, $Res Function(_$_MediaMetadata) _then)
      : super(_value, (v) => _then(v as _$_MediaMetadata));

  @override
  _$_MediaMetadata get _value => super._value as _$_MediaMetadata;

  @override
  $Res call({
    Object? title = freezed,
    Object? authors = freezed,
    Object? squareImage = freezed,
  }) {
    return _then(_$_MediaMetadata(
      title: title == freezed
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      authors: authors == freezed
          ? _value._authors
          : authors // ignore: cast_nullable_to_non_nullable
              as List<String>,
      squareImage: squareImage == freezed
          ? _value.squareImage
          : squareImage // ignore: cast_nullable_to_non_nullable
              as ImageProvider<Object>?,
    ));
  }
}

/// @nodoc

class _$_MediaMetadata implements _MediaMetadata {
  const _$_MediaMetadata(
      {required this.title,
      required final List<String> authors,
      this.squareImage})
      : _authors = authors;

  @override
  final String title;
  final List<String> _authors;
  @override
  List<String> get authors {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_authors);
  }

  @override
  final ImageProvider<Object>? squareImage;

  @override
  String toString() {
    return 'MediaMetadata(title: $title, authors: $authors, squareImage: $squareImage)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_MediaMetadata &&
            const DeepCollectionEquality().equals(other.title, title) &&
            const DeepCollectionEquality().equals(other._authors, _authors) &&
            const DeepCollectionEquality()
                .equals(other.squareImage, squareImage));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(title),
      const DeepCollectionEquality().hash(_authors),
      const DeepCollectionEquality().hash(squareImage));

  @JsonKey(ignore: true)
  @override
  _$$_MediaMetadataCopyWith<_$_MediaMetadata> get copyWith =>
      __$$_MediaMetadataCopyWithImpl<_$_MediaMetadata>(this, _$identity);
}

abstract class _MediaMetadata implements MediaMetadata {
  const factory _MediaMetadata(
      {required final String title,
      required final List<String> authors,
      final ImageProvider<Object>? squareImage}) = _$_MediaMetadata;

  @override
  String get title;
  @override
  List<String> get authors;
  @override
  ImageProvider<Object>? get squareImage;
  @override
  @JsonKey(ignore: true)
  _$$_MediaMetadataCopyWith<_$_MediaMetadata> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
mixin _$MusicPlayer {
  Duration get passed => throw _privateConstructorUsedError;
  Duration get length =>
      throw _privateConstructorUsedError; // @Default(null) PlayableMedia? currentMedia,
  List<PlayableMedia> get queue => throw _privateConstructorUsedError;
  List<PlayableMedia> get history => throw _privateConstructorUsedError;
  bool get playing => throw _privateConstructorUsedError;
  bool get shuffle => throw _privateConstructorUsedError;
  bool get loop => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $MusicPlayerCopyWith<MusicPlayer> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MusicPlayerCopyWith<$Res> {
  factory $MusicPlayerCopyWith(
          MusicPlayer value, $Res Function(MusicPlayer) then) =
      _$MusicPlayerCopyWithImpl<$Res>;
  $Res call(
      {Duration passed,
      Duration length,
      List<PlayableMedia> queue,
      List<PlayableMedia> history,
      bool playing,
      bool shuffle,
      bool loop});
}

/// @nodoc
class _$MusicPlayerCopyWithImpl<$Res> implements $MusicPlayerCopyWith<$Res> {
  _$MusicPlayerCopyWithImpl(this._value, this._then);

  final MusicPlayer _value;
  // ignore: unused_field
  final $Res Function(MusicPlayer) _then;

  @override
  $Res call({
    Object? passed = freezed,
    Object? length = freezed,
    Object? queue = freezed,
    Object? history = freezed,
    Object? playing = freezed,
    Object? shuffle = freezed,
    Object? loop = freezed,
  }) {
    return _then(_value.copyWith(
      passed: passed == freezed
          ? _value.passed
          : passed // ignore: cast_nullable_to_non_nullable
              as Duration,
      length: length == freezed
          ? _value.length
          : length // ignore: cast_nullable_to_non_nullable
              as Duration,
      queue: queue == freezed
          ? _value.queue
          : queue // ignore: cast_nullable_to_non_nullable
              as List<PlayableMedia>,
      history: history == freezed
          ? _value.history
          : history // ignore: cast_nullable_to_non_nullable
              as List<PlayableMedia>,
      playing: playing == freezed
          ? _value.playing
          : playing // ignore: cast_nullable_to_non_nullable
              as bool,
      shuffle: shuffle == freezed
          ? _value.shuffle
          : shuffle // ignore: cast_nullable_to_non_nullable
              as bool,
      loop: loop == freezed
          ? _value.loop
          : loop // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc
abstract class _$$_MusicPlayerCopyWith<$Res>
    implements $MusicPlayerCopyWith<$Res> {
  factory _$$_MusicPlayerCopyWith(
          _$_MusicPlayer value, $Res Function(_$_MusicPlayer) then) =
      __$$_MusicPlayerCopyWithImpl<$Res>;
  @override
  $Res call(
      {Duration passed,
      Duration length,
      List<PlayableMedia> queue,
      List<PlayableMedia> history,
      bool playing,
      bool shuffle,
      bool loop});
}

/// @nodoc
class __$$_MusicPlayerCopyWithImpl<$Res> extends _$MusicPlayerCopyWithImpl<$Res>
    implements _$$_MusicPlayerCopyWith<$Res> {
  __$$_MusicPlayerCopyWithImpl(
      _$_MusicPlayer _value, $Res Function(_$_MusicPlayer) _then)
      : super(_value, (v) => _then(v as _$_MusicPlayer));

  @override
  _$_MusicPlayer get _value => super._value as _$_MusicPlayer;

  @override
  $Res call({
    Object? passed = freezed,
    Object? length = freezed,
    Object? queue = freezed,
    Object? history = freezed,
    Object? playing = freezed,
    Object? shuffle = freezed,
    Object? loop = freezed,
  }) {
    return _then(_$_MusicPlayer(
      passed: passed == freezed
          ? _value.passed
          : passed // ignore: cast_nullable_to_non_nullable
              as Duration,
      length: length == freezed
          ? _value.length
          : length // ignore: cast_nullable_to_non_nullable
              as Duration,
      queue: queue == freezed
          ? _value._queue
          : queue // ignore: cast_nullable_to_non_nullable
              as List<PlayableMedia>,
      history: history == freezed
          ? _value._history
          : history // ignore: cast_nullable_to_non_nullable
              as List<PlayableMedia>,
      playing: playing == freezed
          ? _value.playing
          : playing // ignore: cast_nullable_to_non_nullable
              as bool,
      shuffle: shuffle == freezed
          ? _value.shuffle
          : shuffle // ignore: cast_nullable_to_non_nullable
              as bool,
      loop: loop == freezed
          ? _value.loop
          : loop // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$_MusicPlayer implements _MusicPlayer {
  const _$_MusicPlayer(
      {this.passed = Duration.zero,
      this.length = Duration.zero,
      final List<PlayableMedia> queue = const [],
      final List<PlayableMedia> history = const [],
      this.playing = false,
      this.shuffle = false,
      this.loop = false})
      : _queue = queue,
        _history = history;

  @override
  @JsonKey()
  final Duration passed;
  @override
  @JsonKey()
  final Duration length;
// @Default(null) PlayableMedia? currentMedia,
  final List<PlayableMedia> _queue;
// @Default(null) PlayableMedia? currentMedia,
  @override
  @JsonKey()
  List<PlayableMedia> get queue {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_queue);
  }

  final List<PlayableMedia> _history;
  @override
  @JsonKey()
  List<PlayableMedia> get history {
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_history);
  }

  @override
  @JsonKey()
  final bool playing;
  @override
  @JsonKey()
  final bool shuffle;
  @override
  @JsonKey()
  final bool loop;

  @override
  String toString() {
    return 'MusicPlayer(passed: $passed, length: $length, queue: $queue, history: $history, playing: $playing, shuffle: $shuffle, loop: $loop)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_MusicPlayer &&
            const DeepCollectionEquality().equals(other.passed, passed) &&
            const DeepCollectionEquality().equals(other.length, length) &&
            const DeepCollectionEquality().equals(other._queue, _queue) &&
            const DeepCollectionEquality().equals(other._history, _history) &&
            const DeepCollectionEquality().equals(other.playing, playing) &&
            const DeepCollectionEquality().equals(other.shuffle, shuffle) &&
            const DeepCollectionEquality().equals(other.loop, loop));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(passed),
      const DeepCollectionEquality().hash(length),
      const DeepCollectionEquality().hash(_queue),
      const DeepCollectionEquality().hash(_history),
      const DeepCollectionEquality().hash(playing),
      const DeepCollectionEquality().hash(shuffle),
      const DeepCollectionEquality().hash(loop));

  @JsonKey(ignore: true)
  @override
  _$$_MusicPlayerCopyWith<_$_MusicPlayer> get copyWith =>
      __$$_MusicPlayerCopyWithImpl<_$_MusicPlayer>(this, _$identity);
}

abstract class _MusicPlayer implements MusicPlayer {
  const factory _MusicPlayer(
      {final Duration passed,
      final Duration length,
      final List<PlayableMedia> queue,
      final List<PlayableMedia> history,
      final bool playing,
      final bool shuffle,
      final bool loop}) = _$_MusicPlayer;

  @override
  Duration get passed;
  @override
  Duration get length;
  @override // @Default(null) PlayableMedia? currentMedia,
  List<PlayableMedia> get queue;
  @override
  List<PlayableMedia> get history;
  @override
  bool get playing;
  @override
  bool get shuffle;
  @override
  bool get loop;
  @override
  @JsonKey(ignore: true)
  _$$_MusicPlayerCopyWith<_$_MusicPlayer> get copyWith =>
      throw _privateConstructorUsedError;
}
