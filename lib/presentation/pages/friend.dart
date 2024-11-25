import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import '../../data/datasources/local/database_helper.dart';
import '../../data/datasources/local/friend_local_datasource.dart';
import '../../data/repositories/friends_repsoitory_impl.dart';
import '../../domain/usecases/friends/add_friend.dart';
import '../../domain/usecases/friends/get_friends.dart';
import '../stores/friend_store.dart';
import '../widgets/friend_card.dart';
import 'create_friend.dart';

class FriendsPage extends StatefulWidget {
  const FriendsPage({Key? key}) : super(key: key);

  @override
  _FriendsPageState createState() => _FriendsPageState();
}

class _FriendsPageState extends State<FriendsPage> {
  late FriendStore friendStore;
  String searchText = "";

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
            },
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(50),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: const InputDecoration(
                hintText: 'Buscar amigo...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
                filled: true,
                fillColor: Colors.white,
              ),
              onChanged: (value) {
                setState(() {
                  searchText = value.toLowerCase();
                });
              },
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Observer(
          builder: (context) {
            if (friendStore.amigos.isEmpty) {
              return const Center(child: Text("No hay amigos registrados aún."));
            }


            final filteredFriends = friendStore.amigos.where((friend) {
              final fullName = '${friend.name} ${friend.last_name}'.toLowerCase();
              return fullName.contains(searchText);
            }).toList();

            if (filteredFriends.isEmpty) {
              return const Center(child: Text("No se encontraron coincidencias."));
            }

            return ListView.builder(
              itemCount: filteredFriends.length,
              itemBuilder: (context, index) {
                final friend = filteredFriends[index];
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
