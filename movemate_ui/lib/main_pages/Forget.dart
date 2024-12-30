import 'package:flutter/material.dart';
import 'package:movemate_ui/main_pages/login.dart';

class Forget extends StatefulWidget {
  const Forget({super.key});

  @override
  State<Forget> createState() => _ForgetState();
}

class _ForgetState extends State<Forget> {
  bool Passwordhidden = true;
  bool Passwordhidden2 = true;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xffED9E59),
            Color.fromARGB(255, 223, 186, 184),
          ],
        ),
      ),
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: const Text(
            'Shipment Tracking',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Color(0xff44174E),
        ),
        body: Column(
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 50, bottom: 20),
                child: Container(
                  height: 240,
                  width: 240,
                  child: const Image(
                    image: AssetImage('assets/images/password-reset-icon.png'),
                  ),
                ),
              ),
            ),

            Container(
              width: 350,
              child: Padding(
                padding: const EdgeInsets.only(top: 25),
                child: TextField(
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 20),
                    labelText: 'Username',
                    labelStyle: const TextStyle(color: Colors.blue),
                    suffixIconColor: Colors.purple,
                    prefixIcon: const Padding(
                      padding: EdgeInsets.only(left: 25, right: 10),
                      child: Icon(Icons.supervised_user_circle_sharp),
                    ),
                    prefixIconColor: Colors.purple,
                    hintText: 'Enter your username',
                    hintStyle: const TextStyle(color: Colors.purple),
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.purple),
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
              ),
            ),

            Container(
              width: 350,
              child: Padding(
                padding: const EdgeInsets.only(top: 20),
                child: TextField(
                  obscureText: Passwordhidden,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 20),
                    labelText: 'Password',
                    labelStyle: const TextStyle(color: Colors.blue),
                    suffixIcon: IconButton(
                      icon: Icon(
                        Passwordhidden
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          Passwordhidden = !Passwordhidden;
                        });
                      },
                    ),
                    suffixIconColor: Colors.purple,
                    prefixIcon: const Padding(
                      padding: EdgeInsets.only(left: 25, right: 10),
                      child: Icon(Icons.lock),
                    ),
                    prefixIconColor: Colors.purple,
                    hintText: 'Enter your Password',
                    hintStyle: const TextStyle(color: Colors.purple),
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.purple),
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
              ),
            ),
            Container(
              width: 350,
              child: Padding(
                padding: const EdgeInsets.only(top: 25),
                child: TextField(
                  obscureText: Passwordhidden2,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 20),
                    labelText: 'New Password',
                    labelStyle: const TextStyle(color: Colors.blue),
                    suffixIcon: IconButton(
                      icon: Icon(
                        Passwordhidden2
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                      onPressed: () {
                        setState(() {
                          Passwordhidden2 = !Passwordhidden2;
                        });
                      },
                    ),
                    suffixIconColor: Colors.purple,
                    prefixIcon: const Padding(
                      padding: EdgeInsets.only(left: 25, right: 10),
                      child: Icon(Icons.lock),
                    ),
                    prefixIconColor: Colors.purple,
                    hintText: 'Enter your Password',
                    hintStyle: const TextStyle(color: Colors.purple),
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(color: Colors.purple),
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
            ),
            //
            //
            Container(
              width: 300,
              height: 45,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                gradient: const LinearGradient(
                  colors: [
                    Color.fromARGB(255, 36, 105, 255),
                    Color.fromARGB(255, 214, 19, 204),
                  ],
                ),
              ),
              child: Center(
                child: TextButton(
                  onPressed: () {
                    // Show a success message using SnackBar
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Password changed sucessfully'),
                        duration: Duration(
                            seconds: 2), // Display SnackBar for 2 seconds
                        behavior: SnackBarBehavior.floating,
                      ),
                    );

                    // Wait for 3 seconds and navigate to the login screen
                    Future.delayed(const Duration(seconds: 3), () {
                      Navigator.of(context, rootNavigator: true)
                          .pushReplacement(
                        MaterialPageRoute(builder: (context) => login()),
                      );
                    });
                  },
                  child: const Text(
                    'Confirm Password',
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 25,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
