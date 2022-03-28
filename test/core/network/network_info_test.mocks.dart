// Mocks generated by Mockito 5.1.0 from annotations
// in number_app/test/core/network/network_info_test.dart.
// Do not manually edit this file.

import 'dart:async' as _i4;

import 'package:internet_connection_checker/internet_connection_checker.dart'
    as _i2;
import 'package:mockito/mockito.dart' as _i1;

import 'network_info_test.dart' as _i3;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types

class _FakeDuration_0 extends _i1.Fake implements Duration {}

class _FakeAddressCheckResult_1 extends _i1.Fake
    implements _i2.AddressCheckResult {}

/// A class which mocks [MockInternetConnectionChecker].
///
/// See the documentation for Mockito's code generation for more information.
class MockMockInternetConnectionChecker extends _i1.Mock
    implements _i3.MockInternetConnectionChecker {
  MockMockInternetConnectionChecker() {
    _i1.throwOnMissingStub(this);
  }

  @override
  List<_i2.AddressCheckOptions> get addresses =>
      (super.noSuchMethod(Invocation.getter(#addresses),
              returnValue: <_i2.AddressCheckOptions>[])
          as List<_i2.AddressCheckOptions>);
  @override
  set addresses(List<_i2.AddressCheckOptions>? _addresses) =>
      super.noSuchMethod(Invocation.setter(#addresses, _addresses),
          returnValueForMissingStub: null);
  @override
  Duration get checkInterval =>
      (super.noSuchMethod(Invocation.getter(#checkInterval),
          returnValue: _FakeDuration_0()) as Duration);
  @override
  set checkInterval(Duration? _checkInterval) =>
      super.noSuchMethod(Invocation.setter(#checkInterval, _checkInterval),
          returnValueForMissingStub: null);
  @override
  _i4.Future<bool> get hasConnection =>
      (super.noSuchMethod(Invocation.getter(#hasConnection),
          returnValue: Future<bool>.value(false)) as _i4.Future<bool>);
  @override
  _i4.Future<_i2.InternetConnectionStatus> get connectionStatus =>
      (super.noSuchMethod(Invocation.getter(#connectionStatus),
              returnValue: Future<_i2.InternetConnectionStatus>.value(
                  _i2.InternetConnectionStatus.connected))
          as _i4.Future<_i2.InternetConnectionStatus>);
  @override
  _i4.Stream<_i2.InternetConnectionStatus> get onStatusChange =>
      (super.noSuchMethod(Invocation.getter(#onStatusChange),
              returnValue: Stream<_i2.InternetConnectionStatus>.empty())
          as _i4.Stream<_i2.InternetConnectionStatus>);
  @override
  bool get hasListeners =>
      (super.noSuchMethod(Invocation.getter(#hasListeners), returnValue: false)
          as bool);
  @override
  bool get isActivelyChecking =>
      (super.noSuchMethod(Invocation.getter(#isActivelyChecking),
          returnValue: false) as bool);
  @override
  _i4.Future<_i2.AddressCheckResult> isHostReachable(
          _i2.AddressCheckOptions? options) =>
      (super.noSuchMethod(Invocation.method(#isHostReachable, [options]),
              returnValue: Future<_i2.AddressCheckResult>.value(
                  _FakeAddressCheckResult_1()))
          as _i4.Future<_i2.AddressCheckResult>);
}
