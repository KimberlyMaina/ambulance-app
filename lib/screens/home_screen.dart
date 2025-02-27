import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'login_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  Future<void> _handleLogout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    if (context.mounted) {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const LoginScreen()),
            (Route<dynamic> route) => false,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 1,
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu, color: Colors.black),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications, color: Colors.black),
            onPressed: () {
              // Handle notifications
            },
          ),
          const CircleAvatar(
            radius: 15,
            backgroundColor: Colors.grey,
            child: Icon(Icons.person, color: Colors.white),
          ),
          const SizedBox(width: 10),
        ],
      ),
      drawer: DrawerMenu(
        email: user?.email ?? 'No email',
        onLogout: () => _handleLogout(context),
      ),
      // Replace the recursive reference with the actual content
      body: const Center(
        child: Text(
          'Welcome to Home Screen!',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}

// Updated DrawerMenu class
class DrawerMenu extends StatelessWidget {
  final String email;
  final VoidCallback onLogout;

  const DrawerMenu({
    super.key,
    required this.email,
    required this.onLogout,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: const Text('User'),
            accountEmail: Text(email),
            currentAccountPicture: const CircleAvatar(
              backgroundColor: Colors.white,
              child: Icon(Icons.person),
            ),
            decoration: BoxDecoration(color: Theme.of(context).primaryColor),
          ),
          _drawerItem(icon: Icons.person, text: 'Profile', onTap: () {}),
          _drawerItem(icon: Icons.payment, text: 'Payment Methods', onTap: () {}),
          _drawerItem(icon: Icons.settings, text: 'Settings', onTap: () {}),
          _drawerItem(icon: Icons.help, text: 'Support', onTap: () {}),
          _drawerItem(icon: Icons.logout, text: 'Logout', onTap: onLogout),
        ],
      ),
    );
  }

  Widget _drawerItem({
    required IconData icon,
    required String text,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon),
      title: Text(text),
      onTap: onTap,
    );
  }
}
