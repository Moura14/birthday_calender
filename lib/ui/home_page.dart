import 'package:birthday_calender/helpers/contact_helo.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ContactHelper helper = ContactHelper();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Data c = Data();
    c.name = 'João';
    c.birthday = '21212';
    c.image = 'imagetest';

    helper.saveContact(c);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title: const Text('Birthdays!'),
        centerTitle: true,
      ),
    );
  }
}
