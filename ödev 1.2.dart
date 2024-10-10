
import 'dart:io';

void main() {
  print("bana 10 tane sayı gir");
  List<int> listem = [];
  List<int> ciftListem = [];
  /* for (int i = 0; i < 10; i++) {
    int? sayi = int.tryParse(stdin.readLineSync()!);
    if (sayi == null) {
      print("hatali sayi, tam sayi girin");
      return;
    } else {
      listem.add(sayi);
    }
  } */
  if (!sayiGiris(listem)) {
    print("hatali işlem , tam sayi girin");
    return;
  }
  for (int j = 0; j < listem.length; j++) {
    if (listem[j] % 2 == 0) {
      ciftListem.add(listem[j]);
    }
  }
  if (ciftListem.isEmpty) {
    print(" cift girmediniz");
  } else {
    var sayis = Set.from(ciftListem);
    print("${sayis}");
  }
}

bool sayiGiris(List<int> listem) {
  for (int i = 0; i < 10; i++) {
    int? sayi = int.tryParse(stdin.readLineSync()!);
    if (sayi == null) {
      return false;
    } else {
      listem.add(sayi);
    }
  }
  return true;
}
