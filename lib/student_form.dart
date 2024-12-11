import 'package:flutter/material.dart';
import 'student.dart';
import 'student_service.dart';

class StudentFormPage extends StatefulWidget {
  final Student? student; // Null ise ekleme işlemi, dolu ise güncelleme işlemi.

  StudentFormPage({this.student});

  @override
  _StudentFormPageState createState() => _StudentFormPageState();
}

class _StudentFormPageState extends State<StudentFormPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _surnameController;
  late TextEditingController _departmentIdController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.student?.name ?? '');
    _surnameController = TextEditingController(text: widget.student?.surname ?? '');
    _departmentIdController = TextEditingController(
        text: widget.student?.departmentId.toString() ?? '');
  }

  @override
  void dispose() {
    _nameController.dispose();
    _surnameController.dispose();
    _departmentIdController.dispose();
    super.dispose();
  }

  void _saveStudent() async {
    if (_formKey.currentState!.validate()) {
      final name = _nameController.text;
      final surname = _surnameController.text;
      final departmentId = int.parse(_departmentIdController.text);

      if (widget.student == null) {
        // Yeni öğrenci ekle
        await StudentService.addStudent(
          Student(id: 0, name: name, surname: surname, departmentId: departmentId),
        );
      } else {
        // Mevcut öğrenciyi güncelle
        await StudentService.updateStudent(
          widget.student!.id,
          Student(id: widget.student!.id, name: name, surname: surname, departmentId: departmentId),
        );
      }

      Navigator.pop(context, true); // Ana sayfaya dön ve listeyi güncelle.
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.student == null ? 'Yeni Öğrenci Ekle' : 'Öğrenciyi Güncelle'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Ad'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Ad alanı boş bırakılamaz';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _surnameController,
                decoration: InputDecoration(labelText: 'Soyad'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Soyad alanı boş bırakılamaz';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _departmentIdController,
                decoration: InputDecoration(labelText: 'Bölüm ID'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Bölüm ID alanı boş bırakılamaz';
                  }
                  if (int.tryParse(value) == null) {
                    return 'Geçerli bir sayı girin';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveStudent,
                child: Text(widget.student == null ? 'Ekle' : 'Güncelle'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
