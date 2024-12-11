class Student {
  final int id;
  final String name;
  final String surname;
  final int departmentId;

  Student({required this.id, required this.name, required this.surname, required this.departmentId});

  factory Student.fromJson(Map<String, dynamic> json) {
    return Student(
      id: json['ogrenciID'],
      name: json['ad'],
      surname: json['soyad'],
      departmentId: json['BolumId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ad': name,
      'soyad': surname,
      'BolumId': departmentId,
    };
  }
}
