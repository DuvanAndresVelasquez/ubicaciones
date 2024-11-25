// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$LocationStore on _LocationStoreBase, Store {
  late final _$ubicacionesAtom =
      Atom(name: '_UbicacionStoreBase.ubicaciones', context: context);

  @override
  ObservableList<Location> get ubicaciones {
    _$ubicacionesAtom.reportRead();
    return super.locations;
  }

  @override
  set ubicaciones(ObservableList<Location> value) {
    _$ubicacionesAtom.reportWrite(value, super.locations, () {
      super.locations = value;
    });
  }

  late final _$cargarUbicacionesAsyncAction =
      AsyncAction('_UbicacionStoreBase.cargarUbicaciones', context: context);

  @override
  Future<void> cargarUbicaciones() {
    return _$cargarUbicacionesAsyncAction.run(() => super.cargarUbicaciones());
  }

  late final _$agregarUbicacionAsyncAction =
      AsyncAction('_UbicacionStoreBase.agregarUbicacion', context: context);

  @override
  Future<void> agregarUbicacion(Location ubicacion) {
    return _$agregarUbicacionAsyncAction
        .run(() => super.agregarUbicacion(ubicacion));
  }

  @override
  String toString() {
    return '''
locations: ${ubicaciones}
    ''';
  }
}
