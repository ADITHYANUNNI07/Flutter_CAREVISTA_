import 'package:carevista_ver05/SCREEN/login.dart';
import 'package:flutter/material.dart';

class ChangePwd extends StatelessWidget {
  const ChangePwd({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF04FBC3),
      child: SafeArea(
        child: Scaffold(
            body: Stack(
          children: [
            Positioned(
              child: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(Icons.arrow_back, size: 34),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(35),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  //crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset('Assets/images/Reset_Pwd_pic.png'),
                    const SizedBox(height: 25),
                    const Text(
                      'Change Password',
                      style: TextStyle(fontFamily: 'brandon_H', fontSize: 45),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Reset your password.',
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                    const SizedBox(height: 20),
                    const TextField(
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.lock),
                        border: OutlineInputBorder(),
                        label: Text('Password'),
                      ),
                    ),
                    const SizedBox(height: 10),
                    const TextField(
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.lock_reset_outlined),
                        border: OutlineInputBorder(),
                        label: Text('Confirm Password'),
                      ),
                    ),
                    const SizedBox(height: 10),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => LoginScreen()));
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 13),
                        ),
                        child: const Text('Change'),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        )),
      ),
    );
  }
}
