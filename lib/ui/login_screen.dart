import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_login/bloc/login/signup_bloc.dart';
import 'package:flutter_bloc_login/bloc/login/signup_event.dart';
import 'package:flutter_bloc_login/bloc/login/signup_state.dart';
import 'package:flutter_bloc_login/ui/home.dart';
import 'package:gap/gap.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();

  @override
  void dispose() {
    firstNameController.dispose();
    lastNameController.dispose();
    emailController.dispose();
    phoneNumberController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Signup'),
      ),
      body: BlocConsumer<SignupBloc, SignupState>(
        listener: (context, state) {
          if (state is SignupSuccess) {
            clearTextFields();
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const HomeScreen()),
            );
          }
        },
        builder: (context, state) {
          return Form(
            key: _formKey,
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                TextFormField(
                  controller: firstNameController,
                  validator: validateInput,
                  decoration: const InputDecoration(labelText: 'First Name'),
                ),
                const Gap(16),
                TextFormField(
                  controller: lastNameController,
                  validator: validateInput,
                  decoration: const InputDecoration(labelText: 'Last Name'),
                ),
                const Gap(16),
                TextFormField(
                  controller: emailController,
                  keyboardType: TextInputType.emailAddress,
                  validator: validateInput,
                  decoration: const InputDecoration(labelText: 'Email'),
                ),
                const Gap(16),
                TextFormField(
                  controller: phoneNumberController,
                  keyboardType: TextInputType.phone,
                  validator: validateInput,
                  decoration: const InputDecoration(
                    labelText: 'Phone Number',
                  ),
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                ),
                const Gap(16),
                Visibility(
                  visible: state is! SignupLoading,
                  replacement: const Center(child: CircularProgressIndicator()),
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        context.read<SignupBloc>().add(
                              SignupSubmitted(
                                firstName: firstNameController.text,
                                lastName: lastNameController.text,
                                email: emailController.text,
                                phoneNumber: phoneNumberController.text,
                              ),
                            );
                      }
                    },
                    child: const Text('Signup'),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  clearTextFields() {
    firstNameController.clear();
    lastNameController.clear();
    emailController.clear();
    phoneNumberController.clear();
  }
}

String? validateInput(String? value) {
  if (value == null || value.isEmpty) {
    return 'This field is required';
  }
  return null;
}
