import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moneymanager/pages/registration_signup/forgot_password_page.dart';
import 'package:moneymanager/utils/colors.dart';

// Login Page
class LoginPage extends StatefulWidget {
  final VoidCallback showRegisterPage;
  const LoginPage({Key? key, required this.showRegisterPage}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // Controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  Future signIn() async {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: emailController.text.trim(),
      password: passwordController.text.trim(),
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  bool checkFields() {
    if (emailController.text.trim().toString().isEmpty ||
        passwordController.text.trim().toString().isEmpty) {
      return false;
    } else {
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.customWhite,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Text(
                'Money Manager',
                style: GoogleFonts.bebasNeue(
                    fontSize: 52, color: AppColor.customLightGreen),
              ),

              const SizedBox(height: 10),

              Image.asset(
                'assets/images/logo.png',
                height: 100,
                width: 100,
              ),

              const SizedBox(height: 40),

              Text(
                'Welcome!',
                style: GoogleFonts.bebasNeue(
                  fontSize: 48,
                ),
              ),

              const SizedBox(height: 10),

              const Text(
                'Login to Get Started!',
                style: TextStyle(fontSize: 20),
              ),

              const SizedBox(height: 50),

              // email textfield
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: TextField(
                      controller: emailController,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Email',
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 10),

              // password textfield
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20.0),
                    child: TextField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Password',
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 10),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return const ForgotPasswordPage();
                        }));
                      },
                      child: Text('Forgot Password?',
                          style: TextStyle(
                            color: AppColor.customDarkGreen,
                            fontWeight: FontWeight.bold,
                          )),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 10),

              // Sign In Button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: GestureDetector(
                  onTap: () async {
                    if (checkFields() == false) {
                      showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                                shape: const RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(20.0))),
                                titleTextStyle: GoogleFonts.roboto(
                                    color: AppColor.customLightGreen,
                                    fontWeight: FontWeight.w800,
                                    fontSize: 24),
                                contentTextStyle: GoogleFonts.roboto(
                                    color: Colors.black, fontSize: 16),
                                title: const Text('Login Input Error'),
                                content: const Text(
                                    'Please fill out both your email & password before attempting to sign in.'),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: Text("Okay",
                                        style: GoogleFonts.roboto(
                                            color: AppColor.customDarkGreen,
                                            fontWeight: FontWeight.w600)),
                                  )
                                ],
                              ));
                    } else {
                      try {
                        await signIn();
                      } on FirebaseException catch (e) {
                        String errorMessage = "";
                        switch (e.code) {
                          case "invalid-email":
                            errorMessage =
                                "You entered an invalid email address.";
                            break;
                          case "wrong-password":
                            errorMessage = "Your password is wrong.";
                            break;
                          case "user-not-found":
                            errorMessage =
                                "User with this email doesn't exist.";
                            break;
                          case "user-disabled":
                            errorMessage =
                                "User with this email has been disabled.";
                            break;
                          case "too-many-requests":
                            errorMessage =
                                "Too many requests. Try again later.";
                            break;
                          case "operation-now-alllowed":
                            errorMessage =
                                "Signing in with Email and Password is not enabled.";
                            break;
                          default:
                            errorMessage = "An undefined Error happened.";
                        }
                        showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                                  shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20.0))),
                                  titleTextStyle: GoogleFonts.roboto(
                                      color: AppColor.customLightGreen,
                                      fontWeight: FontWeight.w800,
                                      fontSize: 24),
                                  contentTextStyle: GoogleFonts.roboto(
                                      color: Colors.black, fontSize: 16),
                                  title: const Text('Login Error'),
                                  content: Text(errorMessage.toString()),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: Text("Okay",
                                          style: GoogleFonts.roboto(
                                              color: AppColor.customDarkGreen,
                                              fontWeight: FontWeight.w600)),
                                    )
                                  ],
                                ));
                      }
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: AppColor.customLightGreen,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Center(
                        child: Text(
                      'Sign In',
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    )),
                  ),
                ),
              ),

              const SizedBox(height: 25),

              // Register
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Not a member?',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  GestureDetector(
                    onTap: widget.showRegisterPage,
                    child: Text(' Register Now',
                        style: TextStyle(
                          color: AppColor.customDarkGreen,
                          fontWeight: FontWeight.bold,
                        )),
                  )
                ],
              )
            ]),
          ),
        ),
      ),
    );
  }
}
