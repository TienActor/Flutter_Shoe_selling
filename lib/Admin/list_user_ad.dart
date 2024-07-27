import 'package:flutter/material.dart';
import '../Config/api_urls.dart';
import '../data/user.dart';

class UserListPage extends StatefulWidget {
  final String token;

  const UserListPage({Key? key, required this.token}) : super(key: key);

  @override
  _UserListPageState createState() => _UserListPageState();
}

class _UserListPageState extends State<UserListPage> {
  late Future<List<User>> _futureUsers;

  @override
  void initState() {
    super.initState();
    _futureUsers = APIRepository().fetchUsers(widget.token);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Danh sách người dùng"),
        backgroundColor: Colors.red,
      ),
      body: FutureBuilder<List<User>>(
        future: _futureUsers,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          } else if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                User user = snapshot.data![index];
                return ListTile(
                  title: Text(user.fullName),
                  subtitle: Text(user.phoneNumber ),
                  leading: CircleAvatar(
                    backgroundImage: NetworkImage(user.imageURL),
                  ),
                );
              },
            );
          } else {
            return const Center(child: Text("No users found"));
          }
        },
      ),
    );
  }
}
