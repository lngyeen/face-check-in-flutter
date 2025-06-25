// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'websocket_service.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
  'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models',
);

/// @nodoc
mixin _$WebSocketConfig {
  String get url => throw _privateConstructorUsedError;
  Duration get connectionTimeout => throw _privateConstructorUsedError;

  /// Create a copy of WebSocketConfig
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $WebSocketConfigCopyWith<WebSocketConfig> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $WebSocketConfigCopyWith<$Res> {
  factory $WebSocketConfigCopyWith(
    WebSocketConfig value,
    $Res Function(WebSocketConfig) then,
  ) = _$WebSocketConfigCopyWithImpl<$Res, WebSocketConfig>;
  @useResult
  $Res call({String url, Duration connectionTimeout});
}

/// @nodoc
class _$WebSocketConfigCopyWithImpl<$Res, $Val extends WebSocketConfig>
    implements $WebSocketConfigCopyWith<$Res> {
  _$WebSocketConfigCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of WebSocketConfig
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? url = null, Object? connectionTimeout = null}) {
    return _then(
      _value.copyWith(
            url:
                null == url
                    ? _value.url
                    : url // ignore: cast_nullable_to_non_nullable
                        as String,
            connectionTimeout:
                null == connectionTimeout
                    ? _value.connectionTimeout
                    : connectionTimeout // ignore: cast_nullable_to_non_nullable
                        as Duration,
          )
          as $Val,
    );
  }
}

/// @nodoc
abstract class _$$WebSocketConfigImplCopyWith<$Res>
    implements $WebSocketConfigCopyWith<$Res> {
  factory _$$WebSocketConfigImplCopyWith(
    _$WebSocketConfigImpl value,
    $Res Function(_$WebSocketConfigImpl) then,
  ) = __$$WebSocketConfigImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String url, Duration connectionTimeout});
}

/// @nodoc
class __$$WebSocketConfigImplCopyWithImpl<$Res>
    extends _$WebSocketConfigCopyWithImpl<$Res, _$WebSocketConfigImpl>
    implements _$$WebSocketConfigImplCopyWith<$Res> {
  __$$WebSocketConfigImplCopyWithImpl(
    _$WebSocketConfigImpl _value,
    $Res Function(_$WebSocketConfigImpl) _then,
  ) : super(_value, _then);

  /// Create a copy of WebSocketConfig
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({Object? url = null, Object? connectionTimeout = null}) {
    return _then(
      _$WebSocketConfigImpl(
        url:
            null == url
                ? _value.url
                : url // ignore: cast_nullable_to_non_nullable
                    as String,
        connectionTimeout:
            null == connectionTimeout
                ? _value.connectionTimeout
                : connectionTimeout // ignore: cast_nullable_to_non_nullable
                    as Duration,
      ),
    );
  }
}

/// @nodoc

class _$WebSocketConfigImpl implements _WebSocketConfig {
  const _$WebSocketConfigImpl({
    required this.url,
    this.connectionTimeout = const Duration(seconds: 10),
  });

  @override
  final String url;
  @override
  @JsonKey()
  final Duration connectionTimeout;

  @override
  String toString() {
    return 'WebSocketConfig(url: $url, connectionTimeout: $connectionTimeout)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$WebSocketConfigImpl &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.connectionTimeout, connectionTimeout) ||
                other.connectionTimeout == connectionTimeout));
  }

  @override
  int get hashCode => Object.hash(runtimeType, url, connectionTimeout);

  /// Create a copy of WebSocketConfig
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$WebSocketConfigImplCopyWith<_$WebSocketConfigImpl> get copyWith =>
      __$$WebSocketConfigImplCopyWithImpl<_$WebSocketConfigImpl>(
        this,
        _$identity,
      );
}

abstract class _WebSocketConfig implements WebSocketConfig {
  const factory _WebSocketConfig({
    required final String url,
    final Duration connectionTimeout,
  }) = _$WebSocketConfigImpl;

  @override
  String get url;
  @override
  Duration get connectionTimeout;

  /// Create a copy of WebSocketConfig
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$WebSocketConfigImplCopyWith<_$WebSocketConfigImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
