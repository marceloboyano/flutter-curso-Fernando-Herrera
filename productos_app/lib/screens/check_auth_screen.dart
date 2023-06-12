import 'package:flutter/material.dart';
import 'package:productos_app/screens/login_screen.dart';
import 'package:productos_app/services/auth_services.dart';
import 'package:provider/provider.dart';

class CheckAuthScreen extends StatelessWidget {
  const CheckAuthScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);

    return Scaffold(
      body: Center(
          child: FutureBuilder(
        future: authService.readToken(),
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          if (!snapshot.hasData) return const Text('');
          if (snapshot.data == '') {
            Future.microtask(() {
              Navigator.pushReplacementNamed(context, 'login');
              // Navigator.of(context).pushReplacementNamed('login');
            });
          } else {
            Future.microtask(() {
              Navigator.pushReplacementNamed(context, 'home');
              // Navigator.of(context).pushReplacementNamed('login');
            });
          }
          return Container();
        },
      )),
    );
  }
}
