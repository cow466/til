import 'package:flutter/material.dart';
import 'dart:developer' as developer;

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  static const routeName = '/profile';

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  final headerStyle = const TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
  );

  Widget createHeaderSection({required String title, required String body}) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: headerStyle,
          ),
          Text(
            body,
            style: const TextStyle(
              fontSize: 16,
            ),
          )
        ],
      ),
    );
  }

  Widget createEmailSection({required String email}) {
    String emailStatus = "Email verified";
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          email,
          style: const TextStyle(
            fontSize: 16,
          ),
        ),
        Text(
          emailStatus,
          style: const TextStyle(
            fontSize: 16,
            color: Colors.lightBlue,
          ),
        ),
      ],
    );
  }

  Widget createAboutMeSection() {
    String aboutMe = "I kinda like algorithms.";
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "About me",
          style: headerStyle,
        ),
        Text(
          aboutMe,
        ),
      ],
    );
  }

  Widget createThingsYouLearnedSection() {
    String temp = "Temp";
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Some things you learned",
          style: headerStyle,
        ),
        Text(
          temp,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const CircleAvatar(
                minRadius: 75,
                child: Icon(
                  Icons.person,
                  size: 120,
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  createHeaderSection(
                    title: "Name",
                    body: "John Foo",
                  ),
                  createHeaderSection(
                    title: "Organization",
                    body: "University of Hawaii at Manoa",
                  ),
                  createEmailSection(
                    email: "cow@hawaii.edu",
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 32,
          ),
          createAboutMeSection(),
          const SizedBox(
            height: 32,
          ),
          createThingsYouLearnedSection(),
        ],
      ),
    );
  }
}
