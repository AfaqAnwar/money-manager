import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moneymanager/data/user.dart';

var emailController = TextEditingController();
var currentPasswordController = TextEditingController();
var newPasswordController = TextEditingController();
var firstNameController = TextEditingController();
var lastNameController = TextEditingController();
var signUpCodeController = TextEditingController();
var reauthFailed = false;

@override
void dispose() {
  emailController.dispose();
  currentPasswordController.dispose();
  newPasswordController.dispose();
  firstNameController.dispose();
  lastNameController.dispose();
  signUpCodeController.dispose();
}

Future confirmChanges() async {
  if (currentPasswordController.text.trim().isNotEmpty &&
      newPasswordController.text.trim().isNotEmpty) {
    FirebaseAuth.instance.currentUser
        ?.updatePassword(newPasswordController.text.trim());
  }

  fillIfEmpty();

  // Adds additional details to the Firestore.
  updateUserDetails(
    firstNameController.text.trim(),
    lastNameController.text.trim(),
    signUpCodeController.text.trim(),
    emailController.text.trim(),
  );
}

Future updateUserDetails(
    String firstName, String lastName, String signUpCode, String email) async {
  FirebaseAuth.instance.currentUser?.updateEmail(email);
  DocumentReference ref = FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser!.uid);
  ref.update({
    'first name': firstName,
    'last name': lastName,
    'sign up code': signUpCode,
    'email': email,
  });
}

bool isEmpty() {
  if (firstNameController.text.trim().isEmpty &&
      lastNameController.text.trim().isEmpty &&
      emailController.text.trim().isEmpty &&
      newPasswordController.text.trim().isEmpty &&
      signUpCodeController.text.trim().isEmpty) {
    return true;
  } else {
    return false;
  }
}

bool isCurrentPasswordPresent() {
  if (currentPasswordController.text.trim().isEmpty) {
    return false;
  } else {
    return true;
  }
}

void fillIfEmpty() {
  if (firstNameController.text.trim().isEmpty) {
    firstNameController.text = CurrentUser.getFirstName;
  }
  if (lastNameController.text.trim().isEmpty) {
    lastNameController.text = CurrentUser.getLastName;
  }
  if (emailController.text.trim().isEmpty) {
    emailController.text = CurrentUser.getEmail;
  }
  if (signUpCodeController.text.trim().isEmpty) {
    signUpCodeController.text = CurrentUser.getCode;
  }
}

Future reauth() async {
  try {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: FirebaseAuth.instance.currentUser!.email.toString(),
      password: currentPasswordController.text.trim(),
    );
    reauthFailed = false;
  } catch (e) {
    reauthFailed = true;
  }
}

Widget buildProfileManager(BuildContext context) {
  return SingleChildScrollView(
    child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
      Text(
        'Profile Information',
        style: GoogleFonts.bebasNeue(fontSize: 32, color: Colors.blue),
      ),

      const SizedBox(height: 5),

      const Text(
        'Modify Your Details',
        style: TextStyle(fontSize: 16),
      ),

      const SizedBox(height: 10),

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
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "First Name: ${CurrentUser.getFirstName}",
              ),
            ),
          ),
        ),
      ),

      const SizedBox(height: 20),

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
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "Last Name ${CurrentUser.getLastName}",
              ),
            ),
          ),
        ),
      ),

      const SizedBox(height: 20),

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
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "Email: ${CurrentUser.getEmail}",
              ),
            ),
          ),
        ),
      ),

      const SizedBox(height: 20),

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
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: "Sign Up Code: ${CurrentUser.getCode}",
              ),
            ),
          ),
        ),
      ),

      const SizedBox(height: 20),

      // new password textfield
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
              controller: newPasswordController,
              obscureText: true,
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: 'New Password (Optional)',
              ),
            ),
          ),
        ),
      ),

      const SizedBox(height: 40),

      // current password textfield
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
              controller: currentPasswordController,
              obscureText: true,
              decoration: const InputDecoration(
                border: InputBorder.none,
                hintText: 'Confirm Current Password',
              ),
            ),
          ),
        ),
      ),

      const SizedBox(height: 20),

      // Sign Up Button
      MaterialButton(
          onPressed: (() async {
            if (isEmpty() == false) {
              if (isCurrentPasswordPresent()) {
                await reauth();
                if (reauthFailed == true) {
                  showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                            title: const Text('Whoops'),
                            content:
                                const Text('You current password is invalid'),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text("Try again"),
                              )
                            ],
                          ));
                } else {
                  showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                            title: const Text('Confirm Changes'),
                            content: const Text(
                                'Are you sure you want to update your profile?'),
                            actions: [
                              TextButton(
                                  onPressed: () async {
                                    confirmChanges();
                                    await CurrentUser.updateBasicUserDetails();
                                    // ignore: use_build_context_synchronously
                                    Navigator.of(context)
                                        .popUntil((route) => route.isFirst);
                                  },
                                  child: const Text("Yes")),
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text("Cancel"),
                              )
                            ],
                          ));
                }
              } else {
                showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                          title: const Text('Whoops'),
                          content: const Text(
                              'You must enter your current password to make any changes'),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text("Okay"),
                            )
                          ],
                        ));
              }
            } else {
              showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                        title: const Text('Whoops'),
                        content: const Text(
                            'You did not make any changes to your profile...'),
                        actions: [
                          TextButton(
                            onPressed: () => Navigator.pop(context),
                            child: const Text("Okay"),
                          )
                        ],
                      ));
            }
          }),
          color: const Color(0xff6200ee),
          child: const Text(
            "Confirm Changes",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 17,
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
          )),
    ]),
  );
}
