import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:homestay_raya_281917/mainpage.dart';
import 'package:homestay_raya_281917/registerpage.dart';

import 'EnterExitRoute.dart';

class login extends StatefulWidget {
  const login({super.key});

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async => false,
        child: Scaffold(
            appBar: AppBar(
              title: const Text("Register"),
              actions: [
                IconButton(
                    onPressed: _registrationButton,
                    icon: const Icon(Icons.app_registration))
              ],
            ),
            body: const Center(
              child: Text("Registrations"),
            ),
            drawer: Drawer(
              child: ListView(children: [
                UserAccountsDrawerHeader(
                  accountEmail: const Text('Test@gmail.com'),
                  accountName: Row(
                    children: <Widget>[
                      Container(
                        width: 150,
                        height: 200,
                        decoration: const BoxDecoration(shape: BoxShape.circle),
                        child: const CircleAvatar(
                            radius: 64,
                            backgroundColor: Colors.blueGrey,
                            child: const Icon(
                              Icons.check,
                            )),
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          const Text('User'),
                          const Text('@User'),
                        ],
                      ),
                    ],
                  ),
                ),
                ListTile(
                  title: const Text("Login"),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                        context,
                        EnterExitRoute(
                            exitPage: MainScreen(), enterPage: MainScreen()));
                  },
                ),
                ListTile(
                  title: const Text("Register"),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                        context,
                        EnterExitRoute(
                            exitPage: MainScreen(), enterPage: registration()));
                  },
                )
              ]),
            )));
  }

  void _registrationButton() {
    Navigator.push(
        context, MaterialPageRoute(builder: (content) => const registration()));
  }
}
