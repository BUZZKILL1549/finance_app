import 'package:finance_app/sql/db_helper.dart';
import 'package:finance_app/src/home_page.dart';
import 'package:finance_app/widgets/gradient_appbar.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _username = TextEditingController();
  final TextEditingController _password = TextEditingController();
  bool passwordVisible = false;

  DBHelper? dbRef;

  @override
  void initState() {
    super.initState();
    passwordVisible = true;

    dbRef = DBHelper.getInstance;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const GradientAppbar(title: 'Login', leading: false),
      body: Padding(
        padding: const EdgeInsets.all(50.0),
        child: Center(
          child: Column(
            children: <Widget>[
              TextField(
                controller: _username,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.horizontal(
                      left: Radius.circular(10),
                      right: Radius.circular(10)
                    ),
                  ),
                  hoverColor: Colors.black,
                  focusColor: Colors.grey,
                  hintText: 'Enter your username',
                ),
              ),
              const SizedBox(height: 40),
              TextField(
                obscureText: passwordVisible,
                controller: _password,
                decoration: InputDecoration(
                  border: const OutlineInputBorder(
                    borderRadius: BorderRadius.horizontal(
                      left: Radius.circular(10),
                      right: Radius.circular(10),
                    ),
                  ),
                  hintText: 'Enter your password',
                  suffixIcon: IconButton(
                    icon: Icon(passwordVisible ? Icons.visibility : Icons.visibility_off),
                    onPressed: () {
                      setState(() {
                        passwordVisible = !passwordVisible;
                      });
                    },
                  ),
                  alignLabelWithHint: false,
                ),
                keyboardType: TextInputType.visiblePassword,
                textInputAction: TextInputAction.done,
              ),
              const SizedBox(height: 60),
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: <Color>[Colors.blueGrey.shade900, Colors.blueGrey.shade500],
                  ),
                  borderRadius: BorderRadius.circular(10)
                ),
                child: TextButton(
                  style: TextButton.styleFrom(
                    fixedSize: const Size(600, 60),
                    padding: const EdgeInsets.all(20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () async {
                    String uname = _username.text;
                    String pwd = _password.text;

                    List<Map<String, dynamic>> allUsers = await dbRef!.getAllUsers();
                    if (uname.isNotEmpty && pwd.isNotEmpty) {
                      for (var user in allUsers) {
                        String name = user['uname'];
                        String password = user['pwd'];

                        if (uname == name && pwd == password) {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const HomePage(),
                            )
                          );
                        } 
                      }
                    }
                  },
                  child: const Text(
                    'Login',
                    style: TextStyle(
                      color: Colors.white
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
