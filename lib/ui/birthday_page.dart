import 'dart:io';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:birthday_calender/helpers/contact_helo.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
  final _nameFocus = FocusNode();

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

      _nameController.text = _editBirtday.name;
      _birthdayController.text = _editBirtday.birthday;
      _phoneController.text = _editBirtday.phone;
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _requestPop,
      child: Scaffold(
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
                  focusNode: _nameFocus,
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
                  keyboardType: TextInputType.datetime,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    DataInputFormatter()
                  ],
                  controller: _birthdayController,
                  decoration: const InputDecoration(labelText: "Birthday"),
                  onChanged: (text) {
                    _userEdited = true;
                    _editBirtday.birthday = text;
                  },
                ),
                TextField(
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    TelefoneInputFormatter()
                  ],
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
          onPressed: () {
            if (_editBirtday.name != null && _editBirtday.name.isNotEmpty) {
              Navigator.pop(context, _editBirtday);
            } else {
              FocusScope.of(context).requestFocus(_nameFocus);
            }
          },
          backgroundColor: Colors.green,
          child: const Icon(Icons.save),
        ),
      ),
    );
  }

  Future<bool> _requestPop() {
    if (_userEdited) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: const Text('Descartar Alterações?'),
              content: const Text('Se sair as alterações serão perdidas'),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text('Cancelar')),
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.pop(context);
                    },
                    child: const Text("Sim"))
              ],
            );
          });
      return Future.value(false);
    } else {
      return Future.value(true);
    }
  }
}
