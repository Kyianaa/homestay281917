import 'package:flutter/material.dart';
import 'package:homestay_raya_281917/loginscreen.dart';
import 'package:homestay_raya_281917/registerpage.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:homestay_raya_281917/tabpage1.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  bool _isChecked = false;
  final TextEditingController _emailditingController = TextEditingController();
  @override
  void initState() {
    super.initState();
    loadPref();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Main Page"),
          actions: [
            IconButton(
                onPressed: _registrationButton,
                icon: const Icon(Icons.app_registration))
          ],
        ),
        body: const Center(
          child: Text("MAIN PAGE"),
        ),
        drawer: Drawer(
          child: ListView(children: [
            UserAccountsDrawerHeader(
              accountEmail: Text(_emailditingController.text),
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
                    // ignore: prefer_const_literals_to_create_immutables
                    children: <Widget>[
                      Text(""),
                    ],
                  ),
                ],
              ),
            ),
            ListTile(
              title: const Text("Login"),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(context,
                    MaterialPageRoute(builder: (content) => const loginPage()));
              },
            ),
            ListTile(
              title: const Text("Register"),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (content) => const registration()));
              },
            )
          ]),
        ));
  }

  Future<void> loadPref() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String email = (prefs.getString('email')) ?? '';
    if (email.length > 1) {
      setState(() {
        _emailditingController.text = email;

        _isChecked = true;
      });
    }
  }

  void _registrationButton() {
    Navigator.push(
        context, MaterialPageRoute(builder: (content) => const registration()));
  }
}
