import 'package:mobx/mobx.dart';
import 'package:prueba/domain/entities/friend.dart';
import 'package:prueba/domain/usecases/friends/friend_usecases.dart';


part 'friend_store.g.dart';

class FriendStore = _FriendStoreBase with _$FriendStore;

abstract class _FriendStoreBase with Store {
  final GetFriends getAmigos;
  final AddAmigo addAmigo;

  _FriendStoreBase(this.getAmigos, this.addAmigo);

  @observable
  ObservableList<Friend> amigos = ObservableList<Friend>();

  @action
  Future<void> cargarAmigos() async {
    final amigosCargados = await getAmigos();
    amigos = ObservableList.of(amigosCargados);
  }

  @action
  Future<void> agregarAmigo(Friend amigo) async {
    await addAmigo(amigo);
    amigos.add(amigo);
  }
}
