import 'package:employee_book/widget/custom_text_form_field.dart';
import 'package:flutter/material.dart';

class AddEmployeeScreen extends StatefulWidget {
  const AddEmployeeScreen({Key? key}) : super(key: key);

  @override
  State<AddEmployeeScreen> createState() => _AddEmployeeScreenState();
}

class _AddEmployeeScreenState extends State<AddEmployeeScreen> {
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _dateOdBirthController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Employee'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: () {
              // TODO: Save employee
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(children: [
          CustomTextFormField(controller: _userNameController, txtLabel: 'User Name'),
          const SizedBox(height: 8.0),
          CustomTextFormField(controller: _firstNameController, txtLabel: 'First Name'),
          const SizedBox(height: 8.0),
          CustomTextFormField(controller: _lastNameController, txtLabel: 'Last Name'),
          const SizedBox(height: 8.0),
          CustomTextFormField(controller: _dateOdBirthController, txtLabel: 'Date of Birth'),
          const SizedBox(height: 8.0),
        ]),
      ),
    );
  }
}

