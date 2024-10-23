import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: FirmaEkrani(),
    );
  }
}

class FirmaEkrani extends StatelessWidget {
  const FirmaEkrani({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade700,
        title: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () {
                // Geri butonuna basıldığında yapılacak işlem
              },
            ),
            const SizedBox(width: 8.0), // Geri butonu ile metin arasındaki boşluk
            const Text('Firmalar', style: TextStyle(color: Colors.white)),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Sağlık yazısı ve ikonu mavi arka planda
            Container(
              color: Colors.blue.shade700, // Arka plan rengi
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.rectangle,
                      color: Colors.redAccent[700], // ikon arka plan rengi
                      borderRadius: BorderRadius.circular(8.0), // Kenarları yuvarlatma
                    ),
                    padding: const EdgeInsets.all(5.0), // İkonun etrafındaki boşluk
                    child: const Icon(
                      Icons.add, // Artı ikonu
                      color: Colors.white, // İkon rengi
                    ),
                  ),
                  const SizedBox(width: 105.0), // İkon ile metin arasındaki boşluk
                  const Text(
                    'Sağlık',
                    style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold), // Kalın yazı
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16.0),
            // Firma arama alanı
            const TextField(
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: 'Firma Ara',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(Radius.circular(30.0)),
                ),
              ),
            ),
            const SizedBox(height: 16.0),
            // Yardımcı metin
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'İstediğiniz firmada indirim yakalama fırsatı...',
                style: TextStyle(color: Colors.grey),
              ),
            ),
            const SizedBox(height: 16.0),
            // Başlık ekle
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Firmalar',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 8.0),
            // Firma listesi
            Expanded(
              child: ListView.builder(
                itemCount: 5,
                itemBuilder: (context, index) {
                  return const FirmaCard(); // FirmaCard widget'ı burada çağrılıyor.
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Firma bilgisi
class FirmaCard extends StatelessWidget {
  const FirmaCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: ListTile(
        leading: const Icon(Icons.local_offer, color: Colors.blue),
        title: const Text('Firma Adı Uzun Firma Adı'),
        trailing: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Colors.blue.shade700, Colors.blue.shade300],
            ),
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: const Text(
            '%10',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
