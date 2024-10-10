 import 'dart:io';

void main() {
  print("iki sayi girin");
  num? sayi1 = num.tryParse(stdin.readLineSync()!);
  if (sayi1 == null) {
    print("yanlış girdiniz bir sayi girin");
    return;
  }
  num? sayi2 = num.tryParse(stdin.readLineSync()!);
  if (sayi2 == null) {
    print("yanlış girdiniz bir sayi girin");
    return;
  }
  print(" yapmak istediginiz islemi(+, - , / , * , %) giriniz ");
  var islem = stdin.readLineSync();
  

  switch (islem) {
    case '*':
      print("islem sonucu: ${sayi1 * sayi2}");
      break;
    case '+':
      print("islem sonucu: ${sayi1 + sayi2}");
      break;
    case '/':
      if (sayi2 == 0) {
        print("herhangi bir sayi 0'ye bolunemezz");
        break;
      }

      print("islem sonucu: ${sayi1 / sayi2}");
      break;
    case '-':
      print("islem sonucu: ${sayi1 - sayi2}");
      break;
    case '%':
      print("islem sonucu: ${sayi1 % sayi2} ");
      break;
    default:
      print("hatali islem girdiniz, tekrar deneyin");
  }
}