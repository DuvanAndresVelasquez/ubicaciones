// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'friend_location_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$FriendLocationStore on _FriendLocationStoreBase, Store {
  late final _$locationsAtom =
      Atom(name: '_FriendLocationStoreBase.locations', context: context);

  @override
  ObservableList<FriendLocation> get locations {
    _$locationsAtom.reportRead();
    return super.locations;
  }

  @override
  set locations(ObservableList<FriendLocation> value) {
    _$locationsAtom.reportWrite(value, super.locations, () {
      super.locations = value;
    });
  }

  late final _$agregarUbicacionAsyncAction = AsyncAction(
      '_FriendLocationStoreBase.agregarUbicacion',
      context: context);

  @override
  Future<void> agregarUbicacion(FriendLocation friendLocation) {
    return _$agregarUbicacionAsyncAction
        .run(() => super.agregarUbicacion(friendLocation));
  }

  @override
  String toString() {
    return '''
locations: ${locations}
    ''';
  }
}
