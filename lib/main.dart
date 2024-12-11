import 'package:flutter/material.dart';
import 'student.dart';
import 'student_service.dart';
import 'student_form.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Student CRUD App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: StudentListPage(),
    );
  }
}

class StudentListPage extends StatefulWidget {
  @override
  _StudentListPageState createState() => _StudentListPageState();
}

class _StudentListPageState extends State<StudentListPage> {
  late Future<List<Student>> students;

  @override
  void initState() {
    super.initState();
    _loadStudents();
  }

  void _loadStudents() {
    setState(() {
      students = StudentService.getStudents();
    });
  }

  Future<void> _navigateToForm({Student? student}) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => StudentFormPage(student: student),
      ),
    );

    if (result == true) {
      _loadStudents();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Student List'),
      ),
      body: FutureBuilder<List<Student>>(
        future: students,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No students found.'));
          }

          return ListView.builder(
            itemCount: snapshot.data!.length,
            itemBuilder: (context, index) {
              final student = snapshot.data![index];
              return ListTile(
                title: Text('${student.name} ${student.surname}'),
                subtitle: Text('Department ID: ${student.departmentId}'),
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () async {
                    await StudentService.deleteStudent(student.id);
                    _loadStudents();
                  },
                ),
                onTap: () => _navigateToForm(student: student), // Güncelleme için formu aç
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _navigateToForm(), // Yeni öğrenci eklemek için formu aç
        child: Icon(Icons.add),
      ),
    );
  }
}
