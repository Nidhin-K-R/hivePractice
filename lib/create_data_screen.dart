import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_practice/model_class.dart';

class CreateDataScreen extends StatefulWidget {
  const CreateDataScreen({super.key});

  @override
  State<CreateDataScreen> createState() => _CreateDataScreenState();
}

class _CreateDataScreenState extends State<CreateDataScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  @override
  void dispose() {
    _nameController.dispose();
    _ageController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Data"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Name'),
              ),
              SizedBox(
                height: 30,
              ),
              TextField(
                controller: _ageController,
                decoration: InputDecoration(labelText: 'Age'),
              ),
              SizedBox(
                height: 30,
              ),
              TextField(
                controller: _phoneController,
                decoration: InputDecoration(labelText: 'Phone'),
              ),
              SizedBox(
                height: 50,
              ),
              ElevatedButton(
                  onPressed: () {
                    final value = ModelClass(
                        name: _nameController.text,
                        age: int.parse(_ageController.text),
                        phone: int.parse(_phoneController.text));
                    Hive.box('PersonBox').add(value);
                    _nameController.clear();
                    _ageController.clear();
                    _phoneController.clear();
                  },
                  child: Text("Create")),
            ],
          ),
        ),
      ),
    );
  }
}
