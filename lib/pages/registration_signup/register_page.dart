import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moneymanager/utils/colors.dart';

// Registration Page
class RegisterPage extends StatefulWidget {
  final VoidCallback showLoginPage;
  const RegisterPage({
    Key? key,
    required this.showLoginPage,
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  // Controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  String dropdownValue = "Student";
  final List<String> list = <String>['Student', 'Parent', 'Teacher', 'Regular'];
  final signUpCodeController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    firstNameController.dispose();
    lastNameController.dispose();
    signUpCodeController.dispose();
    super.dispose();
  }

  // Authenticates user data and logs to Firebase.
  Future signUp() async {
    if (passwordConfirmed()) {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
    }

    // Adds additional details to the Firestore.
    addUserDetails(
      firstNameController.text.trim(),
      lastNameController.text.trim(),
      signUpCodeController.text.trim(),
      emailController.text.trim(),
      false,
    );
  }

  // Creates a Firestore entry with the FireAuthUID.
  Future addUserDetails(String firstName, String lastName, String signUpCode,
      String email, bool hasCompletedSurvey) async {
    DocumentReference ref = FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid);
    List<dynamic> transactions = [];
    ref.set({
      'first name': firstName,
      'last name': lastName,
      'sign up code': signUpCode,
      'email': email,
      'account type': dropdownValue,
      'survey completed': hasCompletedSurvey,
      'transactions': transactions,
    });
  }

  bool passwordConfirmed() {
    if (passwordController.text.trim() ==
        confirmPasswordController.text.trim()) {
      return true;
    } else {
      return false;
    }
  }

  bool allInputFieldsFilled() {
    if (firstNameController.text.trim().isNotEmpty &&
        lastNameController.text.trim().isNotEmpty &&
        emailController.text.trim().isNotEmpty &&
        passwordController.text.trim().isNotEmpty &&
        confirmPasswordController.text.trim().isNotEmpty) {
      return true;
    } else {
      return false;
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
                'Get Started',
                style: GoogleFonts.bebasNeue(
                    fontSize: 48, color: AppColor.customLightGreen),
              ),

              const SizedBox(height: 10),

              const Text(
                'Fill Out Your Details To Continue',
                style: TextStyle(fontSize: 20),
              ),

              const SizedBox(height: 50),

              // first name textfield
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
                      controller: firstNameController,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'First Name',
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 10),

              // last name controller
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
                      controller: lastNameController,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Last Name',
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 10),

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

              // confirm password textfield
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
                      controller: confirmPasswordController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Confirm Password',
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 10),

              // sign up code textfield
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
                      controller: signUpCodeController,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: 'Connection Code (Optional)',
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Select Your Account Type',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: AppColor.customDarkGreen),
                  ),
                ],
              ),

              const SizedBox(height: 10),

              // account type dropdown
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
                    child: DropdownButton(
                      value: dropdownValue,
                      items: list.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                      hint: const Text("Are you a Student, Parent or Teacher?"),
                      onChanged: (value) {
                        setState(() {
                          dropdownValue = value!;
                        });
                      },
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Sign Up Button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: GestureDetector(
                  onTap: () async {
                    if (allInputFieldsFilled() == false) {
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
                                title: const Text('Sign Up Detail Error'),
                                content: const Text(
                                    "Please fill out all of your details."),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: Text(
                                      "Okay",
                                      style: GoogleFonts.roboto(
                                          color: AppColor.customDarkGreen,
                                          fontWeight: FontWeight.w600),
                                    ),
                                  )
                                ],
                              ));
                    } else {
                      if (passwordConfirmed() == false) {
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
                                  title: const Text("Sign Up Error"),
                                  content:
                                      const Text("Passwords do not match."),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: Text(
                                        "Okay",
                                        style: GoogleFonts.roboto(
                                            color: AppColor.customDarkGreen,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    )
                                  ],
                                ));
                      } else {
                        try {
                          await signUp();
                        } on FirebaseException catch (e) {
                          String errorMessage = "";

                          switch (e.code) {
                            case "invalid-email":
                              errorMessage = "Specified email is not valid.";
                              break;
                            case "email-already-in-use":
                              errorMessage =
                                  "Email is already in use, please try another email";
                              break;
                            case "weak-password":
                              errorMessage =
                                  "Password is weak, please choose a password that is at least 6 characters in length.";
                              break;
                            case "operation-not-allowed":
                              errorMessage = "User not allowed to sign up.";
                              break;

                            default:
                              errorMessage = "Unknown Sign Up Error";
                              break;
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
                                    title: const Text("Sign Up Error"),
                                    content: Text(errorMessage.toString()),
                                    actions: [
                                      TextButton(
                                        onPressed: () => Navigator.pop(context),
                                        child: Text(
                                          "Okay",
                                          style: GoogleFonts.roboto(
                                              color: AppColor.customDarkGreen,
                                              fontWeight: FontWeight.w600),
                                        ),
                                      )
                                    ],
                                  ));
                        }
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
                      'Sign Up',
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
                    'Already A Member?',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  GestureDetector(
                    onTap: widget.showLoginPage,
                    child: Text(' Login Now',
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
