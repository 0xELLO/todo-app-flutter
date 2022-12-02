import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';
import 'package:todo_app_flutter/models/AuthStateModel.dart';
import 'package:todo_app_flutter/services/IdentityService.dart';

class LoginScreenWidget extends StatefulWidget {
  const LoginScreenWidget({Key? key}) : super(key: key);

  @override
  State<LoginScreenWidget> createState() => _LoginScreenWidgetState();
}
 
class _LoginScreenWidgetState extends State<LoginScreenWidget> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final storage = new FlutterSecureStorage();
  final _formKey = GlobalKey<FormState>();
  @override 
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login' + Provider.of<AuthStateModel>(context).value.toString()),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                child: TextFormField(
                  decoration: const InputDecoration(
                    labelText: "Email",
                    border: OutlineInputBorder()
                  ),
                  controller: nameController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Invalid email address';
                  }
                  return null;
                },
                )
              ),
              Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 10),
                child: TextFormField(
                  decoration: const InputDecoration(
                    labelText: "Password",
                    border: OutlineInputBorder()
                  ),
                  obscureText: true,
                  controller: passwordController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Invalid password';
                  }
                  return null;
                },
                )
              ),
              Container(
                height: 50,
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: ElevatedButton(
                  child: const Text('Login'),
                  onPressed: () async {
                    if (_formKey.currentState!.validate()) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Processing Data')),
                      );

                      final identityService = new IdentityService();
                      final res = await identityService.login(nameController.text, passwordController.text);
                      if (res) {
                        Provider.of<AuthStateModel>(context, listen: false).set(true);
                      } else {
                        
                      }
                      
                    }
                  },
                )
              )
              
            ],
            
          )
          ),
      )      
    );
  }

  // @override
  // Widget build(BuildContext context) {
  //   return Padding(
  //       padding: const EdgeInsets.all(10),
  //       child: ListView(
  //         children: <Widget>[
  //           Container(
  //               alignment: Alignment.center,
  //               padding: const EdgeInsets.all(10),
  //               child: const Text(
  //                 'Sign in',
  //                 style: TextStyle(fontSize: 20),
  //               )),
  //           Container(
  //             padding: const EdgeInsets.all(10),
  //             child: TextField(
  //               controller: nameController,
  //               decoration: const InputDecoration(
  //                 border: OutlineInputBorder(),
  //                 labelText: 'User Name',
  //               ),
  //             ),
  //           ),
  //           Container(
  //             padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
  //             child: TextField(
  //               obscureText: true,
  //               controller: passwordController,
  //               decoration: const InputDecoration(
  //                 border: OutlineInputBorder(),
  //                 labelText: 'Password',
  //               ),
  //             ),
  //           ),
  //           Container(
  //               height: 50,
  //               padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
  //               child: ElevatedButton(
  //                 child: const Text('Login'),
  //                 onPressed: () {
  //                   print(nameController.text);
  //                   print(passwordController.text);
  //                 },
  //               )
  //           ),
  //           Row(
  //             mainAxisAlignment: MainAxisAlignment.center,
  //             children: <Widget>[
  //               const Text('Does not have account?'),
  //               TextButton(
  //                 child: const Text(
  //                   'Sign in',
  //                   style: TextStyle(fontSize: 20),
  //                 ),
  //                 onPressed: () {
  //                   //signup screen
  //                 },
  //               )
  //             ],
  //           ),
  //         ],
  //       ));
  // }
}