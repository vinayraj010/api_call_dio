import 'package:flutter/material.dart';
import 'package:flutter_application_test/model/getApiData.dart';
import '../controller/api_service.dart';

class UserListScreen extends StatefulWidget {
  @override
  _UserListScreenState createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  List<User> _users = [];

  @override
  void initState() {
    super.initState();
    _fetchUsers();
  }

  Future<void> _fetchUsers() async {
    try {
      final users = await ApiService.fetchUsers();
      setState(() {
        _users = users;
      });
    } catch (e) {
      print('Failed to load users: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User List'),
      ),
      body: _users.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _users.length,
              itemBuilder: (context, index) {
                final user = _users[index];
                return ListTile(
                  title: Text(user.name!),
                  subtitle: Text(user.phone!),
                  trailing: Text(user.company!.name.toString()),
                );
              },
            ),
    );
  }
}
