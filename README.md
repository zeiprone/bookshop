# 📚 İkinci El Kitap Al-Sat Uygulaması
## Second-hand Book Buy-Sell Application

Flutter Haftalık Eğitim Programı kapsamında geliştirilen professional mobil uygulaması.

### 📋 Proje Açıklaması

Bu proje, Flutter ve Dart kullanarak basit fakat profesyonel bir **İkinci El Kitap Al-Sat Uygulaması** geliştirmeyi hedeflemektedir.

Uygulama aşağıdaki özellikleri içermektedir:
- **Ana Sayfa**: Kitap listesi ve kategori filtreleme
- **Kitap Detay Sayfası**: Kitap hakkında detaylı bilgiler
- **Sepet Sistemi**: Kitapları sepete ekleme ve yönetme
- **Navigasyon**: Sayfalar arasında geçiş (Navigator)
- **Responsive Tasarım**: Material Design kullanarak profesyonel UI

### 🛠 Kullanılan Araçlar

| Araç | Versiyon |
|------|---------|
| **Flutter SDK** | 3.44.1 |
| **Dart SDK** | 3.12.1 |
| **IDE** | Visual Studio Code / Android Studio |
| **Emulator** | Android Emulator / Fiziksel Cihaz |

### 📦 Gerekli Paketler

- **material.dart** (Varsayılan) - Material Design bileşenleri
- Ek paket kullanılmamıştır

### 🚀 Çalıştırma Adımları

#### 1. Ortamı Kontrol Etme
```bash
flutter --version
dart --version
```

#### 2. Proje Klasörüne Gitme
```bash
cd /Users/emirtakir/Desktop/softwarePersona/bookshop
```

#### 3. Bağımlılıkları Yükleme
```bash
flutter pub get
```

#### 4. Uygulamayı Çalıştırma

**macOS üzerinde:**
```bash
flutter run -d macos
```

**Android Emulator üzerinde:**
```bash
flutter run -d emulator-5554
```

**Fiziksel Android Cihaz üzerinde:**
```bash
flutter run
```

### 📂 Proje Yapısı

```
lib/
├── main.dart                 # Ana giriş noktası ve routing
├── models/
│   ├── book.dart            # Kitap veri modeli (Book class)
│   ├── book_data.dart       # Örnek kitap verileri (JSON simülasyonu)
│   ├── cart.dart            # Sepet ve sepet öğesi modelleri
│   └── index.dart           # Modelleri dışa aktarma
├── screens/
│   ├── home_screen.dart     # Ana sayfa (kitap listesi)
│   ├── book_detail_screen.dart  # Kitap detay sayfası
│   ├── cart_screen.dart     # Sepet sayfası
│   └── index.dart           # Ekranları dışa aktarma
├── widgets/
│   ├── app_header.dart      # Özel başlık widget'ı
│   ├── book_card.dart       # Kitap kartı widget'ı
│   └── index.dart           # Widget'ları dışa aktarma
└── assets/
    ├── images/              # Resim varlıkları
    └── data/                # JSON veri dosyaları
```

### 🎯 Eğitim Hedefleri

Bu proje aşağıdaki Flutter konseptlerini öğretmeyi hedeflemektedir:

#### Gün 1: Flutter'a Giriş
- ✅ Flutter mimarisi ve Dart neden seçildi
- ✅ Stateless ve Stateful widget'lar
- ✅ Proje oluşturma ve yapısı

#### Gün 2: Dart Temelleri ve Widget'lar
- ✅ Dart değişkenleri ve veri tipleri
- ✅ Collection yapıları (List, Map)
- ✅ Text, Container, Row, Column, Card, Button

#### Gün 3: Navigasyon
- ✅ Widget ağacı ve context
- ✅ Navigator.push / pop
- ✅ Named Routes (MaterialPageRoute)
- ✅ Route Arguments ile veri taşıma

#### Gün 4: JSON ve Listeleme
- ✅ Model sınıfı oluşturma (Book class)
- ✅ fromJson / toJson metodları
- ✅ `assets/data/books.json` dosyasından gerçek JSON okuma
- ✅ GridView ile dinamik liste oluşturma
- ✅ Basit arama (başlık/yazar) ve kategori filtreleme

#### Gün 5: Mini Katalog Uygulaması
- ✅ Ekran tasarımı (Ana sayfa, Detay, Sepet)
- ✅ Arama kutusu + kategori filtreleme
- ✅ Basit state güncelleme (Sepet sistemi)
- ✅ Responsive UI tasarımı

### 🎨 Uygulama Özellikleri

#### 1. Ana Sayfa
- Kategoriye göre filtreleme
- GridView ile 2 sütunlu kart düzeni
- Sepet sayacı (Floating Action Button)
- Pull-to-refresh özelliği (ileri versiyona hazır)

#### 2. Kitap Detay Sayfası
- Kitap görseli, başlığı, fiyatı
- Durum bilgisi (Excellent, Good, Fair)
- Detaylı açıklama
- Satıcı iletişim bilgileri
- Satın alma seçenekleri

#### 3. Sepet Sayfası
- Sepetteki öğeleri listeleme
- Miktar artırma/azaltma
- Öğeyi sepetten kaldırma
- Toplam fiyat hesabı
- Satın alma simülasyonu

### 📊 Örnek Veriler

Uygulama 8 adet örnek kitap içermektedir:
- Kürk Mantı Kolağası - Sabahattin Ali
- Bir Mühendisten Notları - Oğuz Atay
- Dune - Frank Herbert
- 1984 - George Orwell
- Suç ve Ceza - Fyodor Dostoyevski
- Sefiller - Victor Hugo
- Sapiens - Yuval Noah Harari
- Hayaller Büyüsü - Paulo Coelho

### 🔗 API/Veri Kaynakları

Bu eğitim projesi aşağıdaki kaynakları referans almaktadır:
- Banner: https://wantapi.com/assets/banner.png
- Ürün Verileri: https://wantapi.com/products.php

**Not**: Kullanılan veriler eğitim amaçlıdır. Gerçek uygulamada API entegrasyonu yapılabilir.

### ⭐ Temel Dart Konseptleri

```dart
// 1. Model Sınıfı ve fromJson/toJson
class Book {
  final String title;
  factory Book.fromJson(Map<String, dynamic> json) { ... }
  Map<String, dynamic> toJson() { ... }
}

// 2. Collection Yapıları
List<Book> books = BookData.getAllBooks();
List<String> categories = BookData.getCategories();

// 3. Null Safety
late Book? book;
String? description;

// 4. Fonksiyonlar
void addToCart(Book book) { ... }
List<Book> filterByCategory(String category) { ... }
```

### 🎮 Kullanıcı Akışı

```
Ana Sayfa
  ├── Kategori Seç → Filtreli Liste
  ├── Kitap Kartına Tıkla → Detay Sayfası
  │   ├── Sepete Ekle → Sepet Güncelleme
  │   └── Satıcı İletişim → Dialog Göster
  └── Sepet Butonu → Sepet Sayfası
      ├── Miktar Ayarla
      ├── Öğeyi Sil
      └── Satın Alma
```

### 🔄 State Yönetimi

Uygulama şu anda **Stateful Widget** kullanarak state yönetimine sahiptir:
- `Cart` singleton pattern ile uygulanan global sepet
- `HomeScreen` kategori filtreleme state'i
- `CartScreen` dinamik sepet güncellemeleri

### 🚀 İleri Özellikler (Gelecek Sürüm)

- [ ] Provider / GetX state management
- [ ] Backend API entegrasyonu
- [ ] Gerçek ödeme sistemi
- [ ] Kullanıcı hesabı ve oturum açma
- [ ] Beğeniler / Favorites
- [ ] Yorum ve puanlandırma
- [ ] Push notifikasyonlar

### 📚 Kaynaklar

- [Flutter Official Documentation](https://flutter.dev)
- [Dart Language Guide](https://dart.dev/guides)
- [Material Design Guidelines](https://material.io/design)
- [Flutter Widgets Catalog](https://flutter.dev/docs/development/ui/widgets)

### 👨‍💻 Geliştirici Bilgileri

**Proje Türü**: Flutter Haftalık Eğitim Projesi
**Eğitim Kapsamı**: Gün 1-5 (5 Günlük Komplet Program)
**Oluşturulma Tarihi**: 8 Haziran 2026

### 📝 Lisans

Bu proje eğitim amaçlıdır ve açık kaynak kodludur.

### 🤝 Katkılar

Öğrenciler tarafından geliştirilen bu proje, Flutter ve Dart öğreniminin temel seviyesini temsil etmektedir.

---

**Happy Coding! 🚀**
