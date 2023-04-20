import 'package:birthday_calender/helpers/contact_helo.dart';
import 'package:flutter/material.dart';

class BirthdayPage extends StatefulWidget {
  final Birthday? birthday;

  const BirthdayPage({super.key, this.birthday});

  @override
  State<BirthdayPage> createState() => _BirthdayPageState();
}

class _BirthdayPageState extends State<BirthdayPage> {
  bool _userEdited = false;

  final _nameController = TextEditingController();
  final _birthdayController = TextEditingController();
  final _phoneController = TextEditingController();

  Birthday? _editBirtday;

  @override
  void initState() {
    super.initState();
    if (widget.birthday == null) {
      _editBirtday = Birthday();
    } else {
      _editBirtday = Birthday.fromMap(widget.birthday!.toMap());

      _nameController.text = _editBirtday.name;
      _birthdayController.text = _editBirtday.birthday;
      _phoneController.text = _editBirtday.phone
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text(_editBirtday?.name ?? "Salvar aniversário"),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: [
              GestureDetector(
                child: Container(
                  width: 80,
                  height: 80,
                  decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                          image: AssetImage('images/person.png'),
                          fit: BoxFit.cover)),
                ),
              ),
              TextField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: "Nome"),
                onChanged: (text) {
                  _userEdited = true;
                  setState(() {
                    _editBirtday!.name = text;
                  });
                },
              ),
              TextField(
                controller: _birthdayController,
                decoration: const InputDecoration(labelText: "Aniversário"),
                onChanged: (text) {
                  _userEdited = true;
                  _editBirtday!.birthday = text;
                },
              ),
              TextField(
                controller: _phoneController,
                decoration: const InputDecoration(labelText: "Telefone"),
                onChanged: (text) {
                  _userEdited = true;
                  _editBirtday!.phone = text;
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
