import 'dart:io';

import 'package:birthday_calender/helpers/contact_helo.dart';
import 'package:flutter/material.dart';

class BirthdayPage extends StatefulWidget {
  final Birthday birthday;

  const BirthdayPage({Key key, this.birthday}) : super(key: key);

  @override
  State<BirthdayPage> createState() => _BirthdayPageState();
}

class _BirthdayPageState extends State<BirthdayPage> {
  final _nameController = TextEditingController();
  final _birthdayController = TextEditingController();
  final _phoneController = TextEditingController();

  Birthday _editBirtday;

  bool _userEdited = false;

  DateTime _dateTime;

  @override
  void initState() {
    super.initState();
    if (widget.birthday == null) {
      _editBirtday = Birthday();
    } else {
      _editBirtday = Birthday.fromMap(widget.birthday.toMap());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text(_editBirtday.name ?? "Saved Birthday"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              GestureDetector(
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: _editBirtday.image != null
                              ? FileImage(File(_editBirtday.image))
                              : const AssetImage("images/person.png"),
                          fit: BoxFit.cover)),
                ),
              ),
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: "Name"),
                onChanged: (text) {
                  _userEdited = true;
                  setState(() {
                    _editBirtday.name = text;
                  });
                },
              ),
              TextField(
                controller: _birthdayController,
                decoration: const InputDecoration(labelText: "Birthday"),
                onChanged: (text) {
                  _userEdited = true;
                  _editBirtday.birthday = text;
                },
              ),
              TextField(
                controller: _phoneController,
                decoration: const InputDecoration(labelText: "Phone"),
                onChanged: (text) {
                  _userEdited = true;
                  _editBirtday.phone = text;
                },
                keyboardType: TextInputType.phone,
              )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.green,
        child: const Icon(Icons.save),
      ),
    );
  }
}
