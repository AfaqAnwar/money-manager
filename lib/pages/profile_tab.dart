import 'package:flutter/material.dart';
import 'package:moneymanager/data/user.dart';
import 'package:moneymanager/utils/constants.dart';
import 'package:xen_popup_card/xen_card.dart';
import 'package:moneymanager/pages/home_page_tab.dart';

// Profile Tab
class ProfileTab extends StatelessWidget {
  const ProfileTab({Key? key}) : super(key: key);

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
                        margin: const EdgeInsets.only(top: defaultSpacing * 4),
                        width: 50,
                        height: 50,
                        child: ClipRRect(
                            borderRadius: const BorderRadius.all(
                                Radius.circular(defaultRadius)),
                            child: Image.asset("assets/icons/user.png"))),
                    Padding(
                      padding: const EdgeInsets.only(top: defaultSpacing / 2),
                      child: Text(
                          "${CurrentUser.getFirstName} ${CurrentUser.getLastName}"),
                    ),
                    const SizedBox(
                      height: defaultSpacing * 0.25,
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(bottom: defaultSpacing / 2),
                      child: Text(CurrentUser.firebaseUser!.email.toString()),
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
                    buildProfileTile(
                      context,
                      imageUrl: "assets/icons/user-1.png",
                      title: "My Account",
                    ),
                    const SizedBox(
                      height: defaultSpacing * 1.5,
                    ),
                    buildProfileTile(
                      context,
                      imageUrl: "assets/icons/school.png",
                      title: "School Connection",
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
                                  appBar: buildXenAppBar(text: "About Us"),
                                  body: Column(children: const [
                                    Text(
                                      "Money Manger is a product designed to help you track your expenses and income.\n",
                                      textAlign: TextAlign.center,
                                      style:
                                          TextStyle(fontSize: fontSizeHeading),
                                    ),
                                  ]),
                                  gutter: buildXenGutter(text: "Okay"),
                                ));
                      },
                      child: buildProfileTile(
                        context,
                        imageUrl: "assets/icons/info-circle.png",
                        title: "About",
                      ),
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

  XenCardAppBar buildXenAppBar({required String text}) {
    return XenCardAppBar(
      shadow: const BoxShadow(color: Colors.transparent),
      child: Text(
        text,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 28),
        textAlign: TextAlign.center,
      ), // To remove shadow from appbar
    );
  }

  XenCardGutter buildXenGutter({required String text}) {
    return XenCardGutter(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: CustomButton(text: text),
      ),
    );
  }
}
