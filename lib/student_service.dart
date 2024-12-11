import 'dart:convert';
import 'package:http/http.dart' as http;
import 'student.dart';

class StudentService {
  static const String baseUrl = 'http://localhost:3000';

  static Future<List<Student>> getStudents() async {
    final response = await http.get(Uri.parse('$baseUrl/ogrenciler'));

    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = json.decode(response.body);
      return jsonResponse.map((data) => Student.fromJson(data)).toList();
    } else {
      throw Exception('Failed to load students');
    }
  }

  static Future<Student> getStudent(int id) async {
    final response = await http.get(Uri.parse('$baseUrl/ogrenci/$id'));

    if (response.statusCode == 200) {
      return Student.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load student');
    }
  }

  static Future<void> addStudent(Student student) async {
    final response = await http.post(
      Uri.parse('$baseUrl/ogrenci'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(student.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to add student');
    }
  }

  static Future<void> updateStudent(int id, Student student) async {
    final response = await http.put(
      Uri.parse('$baseUrl/ogrenci/$id'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(student.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update student');
    }
  }

  static Future<void> deleteStudent(int id) async {
    final response = await http.delete(Uri.parse('$baseUrl/ogrenci/$id'));

    if (response.statusCode != 200) {
      throw Exception('Failed to delete student');
    }
  }
}
