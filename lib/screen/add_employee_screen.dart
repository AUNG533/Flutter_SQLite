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
          CustomTextFormField(
              controller: _userNameController, txtLabel: 'User Name'),
          const SizedBox(height: 8.0),
          CustomTextFormField(
              controller: _firstNameController, txtLabel: 'First Name'),
          const SizedBox(height: 8.0),
          CustomTextFormField(
              controller: _lastNameController, txtLabel: 'Last Name'),
          const SizedBox(height: 8.0),
          TextFormField(
            controller: _dateOdBirthController,
            keyboardType: TextInputType.name,
            decoration: const InputDecoration(
              border: OutlineInputBorder(),
              label: Text('Date of Birth'),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Date of birth cannot be empty';
              }
              return null;
            },
            onTap: () => pickDateOfBirth(context),
          ),
        ]),
      ),
    );
  }

  Future<void> pickDateOfBirth(BuildContext context) async {
    final initialDate = DateTime.now();
    final newDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(DateTime.now().year - 100),
      lastDate: DateTime(DateTime.now().year + 1),
      builder: (context, child) => Theme(
        data: ThemeData().copyWith(
          colorScheme: const ColorScheme.light(
            primary: Colors.pink,
            onPrimary: Colors.white,
            onSurface: Colors.black,
          ),
          dialogBackgroundColor: Colors.white,
        ),
        child: child ?? const Text('Error'),
      ),
    );
    if (newDate == null) {
      return;
    }
    setState(() {
      _dateOdBirthController.text = newDate.toString();
    });
  }
}
