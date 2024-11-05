import 'package:flutter/material.dart';

void main() => runApp(const MyFormApp());

class MyFormApp extends StatelessWidget {
  const MyFormApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(title: const Text("Kayıt Formu")),
        body: const Padding(
          padding: EdgeInsets.all(16.0),
          child: RegistrationForm(),
        ),
      ),
    );
  }
}

class RegistrationForm extends StatefulWidget {
  const RegistrationForm({super.key});

  @override
  _RegistrationFormState createState() => _RegistrationFormState();
}

class _RegistrationFormState extends State<RegistrationForm> {
  final _formKey = GlobalKey<FormState>(); // Formun durumunu kontrol etmek için GlobalKey
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          // İsim alanı
          TextFormField(
            controller: _nameController,
            decoration: const InputDecoration(labelText: 'İsim'),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'İsim alanı boş olamaz';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),

          // E-posta alanı
          TextFormField(
            controller: _emailController,
            decoration: const InputDecoration(labelText: 'E-posta'),
            keyboardType: TextInputType.emailAddress,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'E-posta alanı boş olamaz';
              } else if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
                return 'Geçerli bir e-posta adresi girin';
              }
              return null;
            },
          ),
          const SizedBox(height: 16),

          // Şifre alanı
          TextFormField(
            controller: _passwordController,
            decoration: const InputDecoration(labelText: 'Şifre'),
            obscureText: true,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Şifre alanı boş olamaz';
              } else if (value.length < 6) {
                return 'Şifre en az 6 karakter olmalı';
              }
              return null;
            },
          ),
          const SizedBox(height: 24),

          // Gönder butonu
          ElevatedButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                // Form geçerli olduğunda
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Form başarıyla gönderildi')),
                );
              }
            },
            child: const Text('Gönder'),
          ),
        ],
      ),
    );
  }
}
