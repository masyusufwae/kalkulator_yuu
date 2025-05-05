
# 📱 Kalkulator App

Aplikasi kalkulator sederhana dengan fitur riwayat perhitungan dan halaman profil. Dibuat menggunakan Flutter dan package `math_expressions`.

---

## 🧩 Struktur Utama

```dart
void main() {
  runApp(const MyApp());
}
```

Menjalankan aplikasi Flutter dengan `MyApp` sebagai root widget.

---

## 🏗️ MyApp (Root Widget)

```dart
class MyApp extends StatelessWidget {
  ...
  routes: {
    '/': (context) => HomePage(),
    '/riwayat': (context) => RiwayatPage(
        history: ModalRoute.of(context)!.settings.arguments as List<String>),
    '/profil': (context) => ProfilPage(),
  },
```

- Menyediakan tiga halaman utama:
  - `'/'`: Halaman kalkulator (`HomePage`)
  - `'/riwayat'`: Halaman riwayat kalkulasi
  - `'/profil'`: Halaman profil pengguna

---

## 🧮 HomePage (Halaman Kalkulator)

### 🧠 State dan Logika

```dart
String input = '';
List<String> history = [];
```

- `input`: Menyimpan ekspresi matematika
- `history`: Menyimpan daftar perhitungan sebelumnya

### 🔣 Evaluasi Ekspresi

```dart
double _evaluateExpression(String expression) {
  ...
}
```

Menggunakan package `math_expressions` untuk mengevaluasi input.

### 🔘 Navigasi Bottom

```dart
BottomNavigationBar(
  ...
  onTap: _onItemTapped,
)
```

Menavigasi antara halaman kalkulator, riwayat, dan profil.

### 🔢 Tombol Kalkulator

```dart
_buildButtonRow([...])
```

Menampilkan tombol dalam bentuk grid, seperti AC, DEL, angka, operator, dll.

---

## 📜 RiwayatPage

```dart
class RiwayatPage extends StatelessWidget {
  final List<String> history;
  ...
}
```

- Menampilkan daftar hasil kalkulasi dari `HomePage`.

---

## 👤 ProfilPage

```dart
class ProfilPage extends StatelessWidget {
  ...
  Text('Muhammad Yusuf'),
  Text('XI RPL 2'),
  Text('25'),
```

Menampilkan data pengguna dan foto profil dari lokal asset (`assets/profile_image.png`).

---

## 🧪 Testing (Widget Test)

```dart
testWidgets('Counter increments smoke test', (WidgetTester tester) async {
  ...
});
```

- Ini adalah sisa template dari project Flutter default. Tidak digunakan dalam aplikasi kalkulator ini dan dapat dihapus atau diperbarui agar sesuai.

---

## 📦 pubspec.yaml (Dependencies)

```yaml
dependencies:
  flutter:
    sdk: flutter
  math_expressions: ^2.0.0
```

Menggunakan `math_expressions` untuk menghitung ekspresi matematika.
