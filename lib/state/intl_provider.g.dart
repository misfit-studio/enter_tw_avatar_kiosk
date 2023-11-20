// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'intl_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$intlStringsHash() => r'3e78fcaecdd8ce4b343b0299d613549f046a38c7';

/// See also [intlStrings].
@ProviderFor(intlStrings)
final intlStringsProvider = AutoDisposeProvider<Map<String, String>>.internal(
  intlStrings,
  name: r'intlStringsProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$intlStringsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef IntlStringsRef = AutoDisposeProviderRef<Map<String, String>>;
String _$selectedLanguageHash() => r'662e6c7a3ca6b59c6c3b8f10e6b24ee03cac31ad';

/// See also [SelectedLanguage].
@ProviderFor(SelectedLanguage)
final selectedLanguageProvider =
    NotifierProvider<SelectedLanguage, Language>.internal(
  SelectedLanguage.new,
  name: r'selectedLanguageProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$selectedLanguageHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$SelectedLanguage = Notifier<Language>;
String _$intlNotifierHash() => r'faf63c966ac15885aafb622473647431e4f7fbce';

/// See also [IntlNotifier].
@ProviderFor(IntlNotifier)
final intlNotifierProvider =
    NotifierProvider<IntlNotifier, Map<String, String>>.internal(
  IntlNotifier.new,
  name: r'intlNotifierProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$intlNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$IntlNotifier = Notifier<Map<String, String>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
