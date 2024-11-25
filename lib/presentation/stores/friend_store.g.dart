// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'friend_store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$FriendStore on _FriendStoreBase, Store {
  late final _$amigosAtom =
      Atom(name: '_FriendStoreBase.amigos', context: context);

  @override
  ObservableList<Friend> get amigos {
    _$amigosAtom.reportRead();
    return super.amigos;
  }

  @override
  set amigos(ObservableList<Friend> value) {
    _$amigosAtom.reportWrite(value, super.amigos, () {
      super.amigos = value;
    });
  }

  late final _$cargarAmigosAsyncAction =
      AsyncAction('_FriendStoreBase.cargarAmigos', context: context);

  @override
  Future<void> cargarAmigos() {
    return _$cargarAmigosAsyncAction.run(() => super.cargarAmigos());
  }

  late final _$agregarAmigoAsyncAction =
      AsyncAction('_FriendStoreBase.agregarAmigo', context: context);

  @override
  Future<void> agregarAmigo(Friend amigo) {
    return _$agregarAmigoAsyncAction.run(() => super.agregarAmigo(amigo));
  }

  @override
  String toString() {
    return '''
amigos: ${amigos}
    ''';
  }
}
