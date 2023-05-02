import 'dart:io';

import 'package:birthday_calender/helpers/contact_helo.dart';
import 'package:birthday_calender/ui/birthday_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ContactHelper helper = ContactHelper();

  List<Birthday> data = [];
  @override
  void initState() {
    super.initState();

    _getAllContacts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text('Birthdays'),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        onPressed: () {
          _showBirthdayPage();
        },
        child: const Icon(Icons.add),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(10),
        itemCount: data.length,
        itemBuilder: (context, index) {
          return _birtdhayCard(context, index);
        },
      ),
    );
  }

  Widget _birtdhayCard(BuildContext context, int index) {
    return GestureDetector(
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              Container(
                width: 80,
                height: 80,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: data[index].image != null
                            ? FileImage(File(data[index].image))
                            : const AssetImage('images/person.png'),
                        fit: BoxFit.cover)),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Column(
                  children: [
                    Text(
                      data[index].name ?? "",
                      style: const TextStyle(
                          fontSize: 22, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      data[index].birthday ?? "",
                      style: const TextStyle(fontSize: 18),
                    ),
                    Text(
                      data[index].phone ?? "",
                      style: const TextStyle(fontSize: 18),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      onTap: () {
        showOptions(context, index);
      },
    );
  }

  void showOptions(BuildContext context, int index) {
    showModalBottomSheet(
        context: context,
        builder: (context) {
          return BottomSheet(
            onClosing: () {},
            builder: (context) {
              return Container(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: TextButton(
                        onPressed: () {},
                        child: const Text(
                          'Ligar',
                          style: TextStyle(color: Colors.black, fontSize: 20.0),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: TextButton(
                        onPressed: () {},
                        child: const Text(
                          'Editar',
                          style: TextStyle(color: Colors.black, fontSize: 20.0),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: TextButton(
                        onPressed: () {},
                        child: const Text(
                          'Excluir',
                          style: TextStyle(color: Colors.black, fontSize: 20.0),
                        ),
                      ),
                    )
                  ],
                ),
              );
            },
          );
        });
  }

  void _showBirthdayPage({Birthday birthday}) async {
    final recBirthday = await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => BirthdayPage(
                  birthday: birthday,
                )));
    if (recBirthday != null) {
      if (birthday != null) {
        await helper.update(recBirthday);
      } else {
        await helper.saveContact(recBirthday);
      }
      _getAllContacts();
    }
  }

  void _getAllContacts() {
    helper.getAllContacts().then((list) {
      setState(() {
        data = list;
      });
    });
  }
}
