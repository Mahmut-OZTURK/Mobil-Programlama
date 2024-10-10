 
import 'dart:io';
class Ogrenci {
  String ad;
  String soyad;
  List<int> notlar = [];

  Ogrenci(this.ad, this.soyad);

  void notEkle(int not) {
    notlar.add(not);
  }

  double ortalamaHesapla() {
    int toplam = 0;
    for (int not in notlar) {
      toplam += not;
    }
    return toplam / notlar.length;
  }
}

void main() {
  print("Öğrencinin adı:");
  String? ad = stdin.readLineSync();

  print("Öğrencinin soyadı:");
  String? soyad = stdin.readLineSync();

  Ogrenci ogrenci = Ogrenci(ad ?? "Girilmedi", soyad ?? "Girilmedi");

  while (true) {
    print("Bir not giriniz (Çıkış için 'c' yaz):");
    String? girdi = stdin.readLineSync();

    if (girdi == 'c') {
      break;
    }

    int? not = int.tryParse(girdi ?? "");
    if (not != null && not >= 0 && not <= 100) {
      ogrenci.notEkle(not);
    } else {
      print("Geçersiz not.  0 ile 100 arasında bir değer giriniz.");
    }
  }

  print("${ogrenci.ad} ${ogrenci.soyad} isimli öğrencinin notları: ${ogrenci.notlar}");
  print("Not ortalaması: ${ogrenci.ortalamaHesapla()}");
}
