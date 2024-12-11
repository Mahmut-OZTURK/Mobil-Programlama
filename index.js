const express = require('express');
const mysql = require('mysql2');
const bodyParser = require('body-parser');
const cors = require('cors');

const app = express();

// Middleware
app.use(cors());
app.use(bodyParser.json());

// MySQL Veritabanı Bağlantısı
const db = mysql.createConnection({
  host: 'localhost', // MySQL sunucu adresi
  user: 'root',      // MySQL kullanıcı adı
  password: 'Istıklal06.', // MySQL şifresi
  database: 'ogrenci_db' // Kendi veritabanı adınızı girin
});

// Bağlantıyı Kontrol Et
db.connect((err) => {
  if (err) {
    console.error('MySQL bağlantı hatası:', err);
  } else {
    console.log('MySQL veritabanına başarıyla bağlanıldı.');
  }
});

// Test için bir endpoint
app.get('/', (req, res) => {
  res.send('API çalışıyor!');
});

// Sunucuyu başlat
const PORT = 3030;
app.listen(PORT, () => {
  console.log(`Sunucu ${PORT} portunda çalışıyor.`);
});

// tüm öğrencileri listele
app.get('/ogrenciler', (req, res) => {
    db.query('SELECT * FROM Ogrenci', (err, results) => {
      if (err) res.status(500).send(err);
      else {
       console.log(results); 
       res.json(results);
    }
    });
  });

//bir öğrenciyi getir
app.get('/ogrenci/:id', (req, res) => {
    const id = req.params.id;
    db.query('SELECT * FROM Ogrenci WHERE ogrenciID = ?', [id], (err, results) => {
      if (err) res.status(500).send(err);
      else res.json(results[0]);
    });
  });

  //yeni bir öğrenci ekle
app.post('/ogrenci', (req, res) => {
    const { ad, soyad, BolumId } = req.body;
    db.query(
      'INSERT INTO Ogrenci (ad, soyad, BolumId) VALUES (?, ?, ?)',
      [ad, soyad, BolumId],
      (err, results) => {
        if (err) res.status(500).send(err);
        else res.json({ id: results.insertId, ad, soyad, BolumId });
      }
    );
});
  
//öğrenciyi güncelle
app.put('/ogrenci/:id', (req, res) => {
    const { ad, soyad, BolumId } = req.body;
    const id = req.params.id;
    db.query(
      'UPDATE Ogrenci SET ad = ?, soyad = ?, BolumId = ? WHERE ogrenciID = ?',
      [ad, soyad, BolumId, id],
      (err, results) => {
        if (err) res.status(500).send(err);
        else res.json({ message: 'Öğrenci güncellendi' });
      }
    );
  });

  //öğrenciyi sil
  app.delete('/ogrenci/:id', (req, res) => {
    const id = req.params.id;
    db.query('DELETE FROM Ogrenci WHERE ogrenciID = ?', [id], (err, results) => {
      if (err) res.status(500).send(err);
      else res.json({ message: 'Öğrenci silindi' });
    });
  });
  
  