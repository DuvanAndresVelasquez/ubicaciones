import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:prueba/presentation/routes.dart';
import '../../domain/usecases/friends/add_friend.dart';
import '../../domain/usecases/friends/get_friends.dart';
import '../widgets/friend_card.dart';
import '../../data/datasources/local/database_helper.dart';
import '../../data/datasources/local/friend_local_datasource.dart';
import '../../data/repositories/friends_repsoitory_impl.dart';
import '../../presentation/stores/friend_store.dart';
import 'create_friend.dart';

class FriendsPage extends StatefulWidget {
  const FriendsPage({Key? key}) : super(key: key);

  @override
  _FriendsPageState createState() => _FriendsPageState();
}

class _FriendsPageState extends State<FriendsPage> {
  late FriendStore friendStore;

  @override
  void initState() {
    super.initState();
    final dbHelper = DatabaseHelper();
    final localDataSource = FriendLocalDataSource(dbHelper);
    final repository = FriendsRepsoitoryImpl(localDataSource);
    final getFriendsUseCase = GetFriends(repository);
    final addFriendUseCase = AddAmigo(repository);
    friendStore = FriendStore(getFriendsUseCase, addFriendUseCase);
    friendStore.cargarAmigos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Lista de Amigos'),
        centerTitle: true,
        actions: [

          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () {

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddFriendPage(friendStore: friendStore),
                ),
              );
              //Navigator.pushNamed(context, Routes.agregarAmigo);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Observer(
          builder: (context) {
            if (friendStore.amigos.isEmpty) {
              return const Center(child: Text("No hay amigos registrados aún."));
            }
            return ListView.builder(
              itemCount: friendStore.amigos.length,
              itemBuilder: (context, index) {
                final friend = friendStore.amigos[index];
                return CardWidget(
                  name: friend.name,
                  lastName: friend.last_name,
                  email: friend.email,
                  phone: friend.phone,
                  photo: friend.photo ?? "",
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      '/friend_detail',
                      arguments: friend,
                    );
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }
}
