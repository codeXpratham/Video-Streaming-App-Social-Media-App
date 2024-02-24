

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:peo_veo/views/screens/auth/login_screen.dart';

import '../../../constants/constant.dart';
import '../../widget/text_inputField.dart';

class SignupScreen extends StatelessWidget {
  SignupScreen({Key? key}) : super(key: key);

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          alignment: Alignment.center,

          child:  SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text('Peo Veo',
                  style: TextStyle(
            
                    fontSize: 35,
                    color: buttonColor,
                    fontWeight: FontWeight.w900,
            
                  ),
                ),
                Text('Register',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.w600,
            
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                Stack(
                  children:  [
                    const CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 64,
                      backgroundImage: NetworkImage('https://upload.wikimedia.org/wikipedia/commons/9/99/Sample_User_Icon.png'),
                    ),
                    Positioned(
                        bottom: -10,
                        left: 80,
                        child: IconButton(
                            onPressed: ()  => authController.pickImage(),
                            icon: const  Icon(Icons.add_a_photo),
                        )),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextInputFieldPro(
                    labelText: 'Username',
                    controller: _usernameController,
                    icon: Icons.person,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextInputFieldPro(
                    labelText: 'Email',
                    controller: _emailController,
                    icon: Icons.email,
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.symmetric(horizontal: 20),
                  child: TextInputFieldPro(
                    labelText: 'password',
                    controller: _passwordController,
                    icon: Icons.lock,
                    isObscure: true,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Container(
                  width: MediaQuery.of(context).size.width-40,
                  height: 50,
                  decoration: BoxDecoration(
                    color: buttonColor,
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  child: InkWell(
                    onTap: () => authController.registerUser(_usernameController.text, _emailController.text, _passwordController.text, authController.profilePhoto),
                    child: Center(
                      child: Text('Register user', style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
            
                      ),),
                    ),
                  ),
                ),
            
                const SizedBox(
                  height: 15,
                ),
            
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children:    [
                    const Text('Already have an account?',
                      style: TextStyle(
                        fontSize: 20,
                      ),),
                    InkWell(
                      onTap: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => LoginScreen())),
            
                      child: Text('Login',
                        style: TextStyle(
                          fontSize: 20,
                          color: buttonColor,
                        ),),
                    ),
            
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );;
  }
}
