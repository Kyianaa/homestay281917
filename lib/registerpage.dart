import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:homestay_raya_281917/mainpage.dart';
import 'package:http/http.dart' as http;

class registration extends StatefulWidget {
  const registration({super.key});

  @override
  State<registration> createState() => _registrationState();
}

class _registrationState extends State<registration> {
  @override
  void initState() {
    super.initState();
    loadEula();
  }

  final TextEditingController _nameEditingController = TextEditingController();
  final TextEditingController _emailditingController = TextEditingController();
  final TextEditingController _phoneEditingController = TextEditingController();
  final TextEditingController _passEditingController = TextEditingController();
  final TextEditingController _pass2EditingController = TextEditingController();
  bool _isChecked = false;
  bool _passwordVisible = true;
  String eula = "";
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Registration Form")),
        body: Center(
            child: SingleChildScrollView(
          child: Card(
            elevation: 8,
            margin: const EdgeInsets.all(8),
            child: Container(
              padding: const EdgeInsets.all(16),
              child: Form(
                key: _formKey,
                child: Column(children: [
                  TextFormField(
                    controller: _nameEditingController,
                    keyboardType: TextInputType.text,
                    validator: (val) => val!.isEmpty || (val.length < 3)
                        ? "name must be longer than 3"
                        : null,
                    decoration: const InputDecoration(
                        labelText: 'Name',
                        labelStyle: TextStyle(),
                        icon: Icon(Icons.person),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(width: 2.0))),
                  ),
                  TextFormField(
                    controller: _emailditingController,
                    keyboardType: TextInputType.text,
                    validator: (val) =>
                        val!.isEmpty || !val.contains("@") || !val.contains(".")
                            ? "enter a valid email"
                            : null,
                    decoration: const InputDecoration(
                        labelText: 'Email',
                        labelStyle: TextStyle(),
                        icon: Icon(Icons.email),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(width: 2.0))),
                  ),
                  TextFormField(
                    controller: _phoneEditingController,
                    keyboardType: TextInputType.text,
                    decoration: const InputDecoration(
                        labelText: 'Phone',
                        labelStyle: TextStyle(),
                        icon: Icon(Icons.phone),
                        focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(width: 2.0))),
                  ),
                  TextFormField(
                    controller: _passEditingController,
                    keyboardType: TextInputType.visiblePassword,
                    validator: ((val) => validatePassword(val.toString())),
                    obscureText: _passwordVisible,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      labelStyle: const TextStyle(),
                      icon: const Icon(Icons.password),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(width: 2.0),
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _passwordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() {
                            _passwordVisible = !_passwordVisible;
                          });
                        },
                      ),
                    ),
                  ),
                  TextFormField(
                      controller: _pass2EditingController,
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: _passwordVisible,
                      decoration: InputDecoration(
                        labelText: 'Re-Password',
                        labelStyle: const TextStyle(),
                        icon: const Icon(Icons.password),
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(width: 2.0),
                        ),
                        suffixIcon: IconButton(
                          icon: Icon(
                            _passwordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                          ),
                          onPressed: () {
                            setState(() {
                              _passwordVisible = !_passwordVisible;
                            });
                          },
                        ),
                      )),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Checkbox(
                          value: _isChecked,
                          onChanged: (bool? value) {
                            setState(() {
                              _isChecked = value!;
                            });
                          }),
                      Flexible(
                        child: GestureDetector(
                          onTap: showEula,
                          child: const Text('Agree with term',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              )),
                        ),
                      ),
                      MaterialButton(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0)),
                        minWidth: 115,
                        height: 50,
                        elevation: 10,
                        onPressed: _registerAccount,
                        child: const Text('Register'),
                      ),
                    ],
                  ),
                ]),
              ),
            ),
          ),
        )));
  }

  void _registerAccount() {
    String name = _nameEditingController.text;
    String email = _emailditingController.text;
    String phone = _phoneEditingController.text;
    String passa = _passEditingController.text;
    String passb = _pass2EditingController.text;
    if (!_formKey.currentState!.validate() && !_isChecked) {
      Fluttertoast.showToast(
          msg: "Please complete the registration form first",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          fontSize: 14.0);
      return;
    }
    if (passa != passb) {
      Fluttertoast.showToast(
          msg: "Your password doesn't match",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          fontSize: 14.0);
      return;
    }
    if (!_isChecked) {
      Fluttertoast.showToast(
          msg: "Please accept the terms and conditions",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          fontSize: 14.0);
      return;
    }
    //OK , proceed dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0))),
          title: const Text(
            "Register new account?",
            style: TextStyle(),
          ),
          content: const Text("Are you sure?", style: TextStyle()),
          actions: <Widget>[
            TextButton(
              child: const Text(
                "Yes",
                style: TextStyle(),
              ),
              onPressed: () {
                Navigator.of(context).pop();
                _registerUser(name, email, phone, passa);
              },
            ),
            TextButton(
              child: const Text(
                "No",
                style: TextStyle(),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  loadEula() async {
    WidgetsFlutterBinding.ensureInitialized();
    eula = await rootBundle.loadString('assets/images/eula.txt');
    print(eula);
  }

  showEula() {
    loadEula();
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(
            "EULA",
            style: TextStyle(),
          ),
          content: SizedBox(
            height: 200,
            child: Column(
              children: <Widget>[
                Expanded(
                  flex: 1,
                  child: SingleChildScrollView(
                      child: RichText(
                          softWrap: true,
                          textAlign: TextAlign.justify,
                          text: TextSpan(
                              style: const TextStyle(
                                color: Colors.black,
                                fontSize: 12.0,
                              ),
                              text: eula))),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text(
                "Close",
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            )
          ],
        );
      },
    );
  }

  String? validatePassword(String value) {
    String pattern = r'^(?=.*[A-Z])(?=.*[a-z])(?=.[0-9]){6,}$';
    RegExp regex = RegExp(pattern);
    if (value.isEmpty) {
      return 'Please enter password';
    } else {
      return null;
    }
  }

  void _registerUser(String name, String email, String phone, String passa) {
    AlertDialog alert = AlertDialog(
      content: Row(children: [
        CircularProgressIndicator(
          backgroundColor: Colors.red,
        ),
        Container(
            margin: EdgeInsets.only(left: 7), child: Text("Register success")),
      ]),
    );
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
    http.post(
        Uri.parse("http://10.31.72.145/homestay281917/php/register_user.php"),
        body: {
          "name": name,
          "email": email,
          "phone": phone,
          "password": passa
        }).then((response) {
      print(response.body);
    });
    Navigator.pop(context);
    _gohome();
  }

  void _gohome() {
    Navigator.push(
        context, MaterialPageRoute(builder: (content) => const MainScreen()));
  }
}
