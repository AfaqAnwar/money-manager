import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:moneymanager/data/user.dart';
import 'package:moneymanager/utils/colors.dart';
import 'package:moneymanager/utils/constants.dart';
import 'package:moneymanager/widgets/connection_manager.dart';
import 'package:moneymanager/widgets/profile_manager.dart';
import 'package:moneymanager/widgets/xen_card.dart';
import 'package:xen_popup_card/xen_card.dart';

// Profile Tab
class ProfileTab extends StatefulWidget {
  const ProfileTab({super.key});

  @override
  State<ProfileTab> createState() => _ProfileTabState();
}

Future updateInfo() async {
  return CurrentUser.noCodeMatch();
}

class _ProfileTabState extends State<ProfileTab> {
  String firstName = CurrentUser.getFirstName;
  String lastName = CurrentUser.getLastName;
  String email = CurrentUser.getEmail;
  String code = CurrentUser.getCode;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(defaultSpacing),
          child: Column(
            children: [
              Center(
                child: Column(
                  children: [
                    Container(
                        margin: const EdgeInsets.only(top: defaultSpacing * 2),
                        width: 50,
                        height: 50,
                        child: ClipRRect(
                            borderRadius: const BorderRadius.all(
                                Radius.circular(defaultRadius)),
                            child: Image.asset("assets/icons/user-big.png"))),
                    Padding(
                      padding: const EdgeInsets.only(top: defaultSpacing / 2),
                      child: Text("$firstName $lastName"),
                    ),
                    const SizedBox(
                      height: defaultSpacing * 0.25,
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(bottom: defaultSpacing / 2),
                      child: Text(email),
                    )
                  ],
                ),
              ),
              const SizedBox(
                height: defaultSpacing * 1.25,
              ),
              Expanded(
                  child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: defaultSpacing * 2,
                    ),
                    InkWell(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (builder) => XenPopupCard(
                                  appBar: null,
                                  body: Column(
                                      children: [buildProfileManager(context)]),
                                  gutter: null,
                                )).then((value) => setState(
                              () {
                                firstName = CurrentUser.getFirstName;
                                lastName = CurrentUser.getLastName;
                                email = CurrentUser.getEmail;

                                if (code != CurrentUser.getCode &&
                                    CurrentUser.accountType == "Parent") {
                                  CurrentUser.updateConnectedUsers();
                                }
                                code = CurrentUser.getCode;
                              },
                            ));
                      },
                      child: buildProfileTile(
                        context,
                        imageUrl: "assets/icons/user-1.png",
                        title: "My Account",
                      ),
                    ),
                    const SizedBox(
                      height: defaultSpacing * 1.5,
                    ),
                    FutureBuilder(
                      future: updateInfo(),
                      builder: (BuildContext context,
                          AsyncSnapshot<dynamic> snapshot) {
                        if (snapshot.data == false) {
                          return InkWell(
                            onTap: () {
                              showDialog(
                                  context: context,
                                  builder: (builder) => XenPopupCard(
                                        appBar: null,
                                        body: Column(children: [
                                          buildConnectionManager(context)
                                        ]),
                                        gutter: null,
                                      ));
                            },
                            child: buildProfileTile(
                              context,
                              imageUrl: "assets/icons/connection.png",
                              title: "My Connections",
                            ),
                          );
                        } else {
                          return InkWell(
                            onTap: () {
                              showDialog(
                                  context: context,
                                  builder: (builder) => XenPopupCard(
                                        appBar: null,
                                        body: Column(children: [
                                          Text(
                                            'Your Connections',
                                            style: GoogleFonts.bebasNeue(
                                                fontSize: 32,
                                                color:
                                                    AppColor.customLightGreen),
                                          ),
                                          Expanded(
                                            child: Scaffold(
                                              backgroundColor: Colors.white,
                                              body: Center(
                                                child: SingleChildScrollView(
                                                  child: Column(children: [
                                                    const SizedBox(height: 20),
                                                    Text(
                                                      'You are a ${CurrentUser.accountType}',
                                                      style: GoogleFonts.roboto(
                                                          fontSize: 16),
                                                    ),
                                                    const SizedBox(height: 10),
                                                    Text(
                                                      'You have no connections.',
                                                      style: GoogleFonts.roboto(
                                                          fontSize: 16),
                                                    ),
                                                  ]),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ]),
                                        gutter: null,
                                      ));
                            },
                            child: buildProfileTile(
                              context,
                              imageUrl: "assets/icons/connection.png",
                              title: "My Connections",
                            ),
                          );
                        }
                      },
                    ),
                    const SizedBox(
                      height: defaultSpacing * 1.5,
                    ),
                    buildProfileTile(
                      context,
                      imageUrl: "assets/icons/bell.png",
                      title: "Notification",
                    ),
                    const SizedBox(
                      height: defaultSpacing * 1.5,
                    ),
                    buildProfileTile(
                      context,
                      imageUrl: "assets/icons/lock-on.png",
                      title: "Privacy",
                    ),
                    const SizedBox(
                      height: defaultSpacing * 1.5,
                    ),
                    InkWell(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (builder) => XenPopupCard(
                                  appBar: null,
                                  body: Column(children: [
                                    Text(
                                      'About Us',
                                      style: GoogleFonts.bebasNeue(
                                          fontSize: 36,
                                          color: AppColor.customLightGreen),
                                    ),
                                    Expanded(
                                      child: Scaffold(
                                        backgroundColor: Colors.white,
                                        body: SingleChildScrollView(
                                            child: Text(
                                                'Money Manager is a money management application designed to educate users about finance. In addition, we also offer tracking services with relation to tracking your income and expenses. We\'ve also made it easy to connect children with their parents and teachers through the "My Connections" feature. We hope you enjoy this application."',
                                                style: GoogleFonts.roboto(
                                                    fontSize: 20,
                                                    color: Colors.black,
                                                    height: 2),
                                                textAlign: TextAlign.start)),
                                      ),
                                    ),
                                  ]),
                                  gutter: getGutter("Okay"),
                                ));
                      },
                      child: buildProfileTile(
                        context,
                        imageUrl: "assets/icons/info-circle.png",
                        title: "About",
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MaterialButton(
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(15.0))),
                            onPressed: (() {
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
                                        title: const Text('Confirm Sign Out'),
                                        content: const Text(
                                            'Are you sure you want to sign out?'),
                                        actions: [
                                          TextButton(
                                              onPressed: () {
                                                FirebaseAuth.instance.signOut();
                                                Navigator.pop(context);
                                              },
                                              child: Text("Yes",
                                                  style: GoogleFonts.roboto(
                                                      color: AppColor
                                                          .customDarkGreen,
                                                      fontWeight:
                                                          FontWeight.w600))),
                                          TextButton(
                                            onPressed: () =>
                                                Navigator.pop(context),
                                            child: Text("Cancel",
                                                style: GoogleFonts.roboto(
                                                    color: AppColor
                                                        .customDarkGreen,
                                                    fontWeight:
                                                        FontWeight.w600)),
                                          )
                                        ],
                                      ));
                            }),
                            color: AppColor.customDarkGreen,
                            child: Text(
                              "Sign Out",
                              textAlign: TextAlign.center,
                              style: GoogleFonts.roboto(
                                fontSize: 17,
                                color: Colors.white,
                                fontWeight: FontWeight.w500,
                              ),
                            )),
                      ],
                    )
                  ],
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }

  Widget buildProfileTile(BuildContext context,
      {required String imageUrl, required String title, String? subtitle}) {
    return ListTile(
        leading: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: defaultSpacing,
          ),
          child: Image.asset(imageUrl),
        ),
        title: Text(title,
            style: Theme.of(context)
                .textTheme
                .subtitle2
                ?.copyWith(color: fontHeading, fontWeight: FontWeight.w600)),
        subtitle: Text(subtitle ?? "",
            style: Theme.of(context)
                .textTheme
                .bodyText2
                ?.copyWith(color: fontSubHeading, fontWeight: FontWeight.w400)),
        trailing: const Padding(
          padding: EdgeInsets.symmetric(horizontal: defaultSpacing),
          child: Icon(
            Icons.arrow_forward_ios_rounded,
            size: 20,
            color: Colors.black26,
          ),
        ));
  }
}
