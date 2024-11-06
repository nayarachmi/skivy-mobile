# Tugas 7
## Membuat Program Flutter Baru
Pertama saya membuka terminal dan mengarahkannya pada direktori tertentu, lalu membuat proyek flutter dengan perintah `flutter create skivy_mobile` setelah proyek berhasil dibuat, saya membukanya dengan VSCode

## Membuat 3 Tombol Sederhana dengan Ikon & Teks
Didalam widget `MyHomePage` saya membuat 3 tombol dengan fungsi `InfoCard` dan `ItemCard` untuk menampilkan ikon & teks. Daftar produk akan tampil dalam bentuk `GridView` dan tombol akan diletakkan di dalamnya menggunakan data `List<ItemHomepage>`

``` dart
final List<ItemHomepage> items = [
  ItemHomepage("Lihat Product", Icons.shopping_bag),
  ItemHomepage("Tambah Product", Icons.add_circle),
  ItemHomepage("Logout", Icons.exit_to_app),
];
```

## Implementasi Warna Berbeda Untuk Setiap Tombol
didalam `ItemCard` saya menambahkan kode berikut untuk memberikan warna yang berbeda pada tiap tombol berdasarkan nama tombol tersebut

``` dart
class ItemCard extends StatelessWidget {
  final ItemHomepage item; 
  const ItemCard(this.item, {super.key}); 

  @override
  Widget build(BuildContext context) {
    Color buttonColor;
    switch (item.name) {
      case 'Lihat Product':
        buttonColor = Colors.pink[200]!;
        break;
      case 'Tambah Product':
        buttonColor = Colors.green[200]!;
        break;
      case 'Logout':
        buttonColor = Colors.red[200]!;
        break;
      default:
        buttonColor = Theme.of(context).colorScheme.secondary;
    }

    return Material(
      color: buttonColor,
      borderRadius: BorderRadius.circular(12),
      child: InkWell(
        onTap: () {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(content: Text("Kamu telah menekan tombol ${item.name}!"))
            );
        },
        child: Container(
          padding: const EdgeInsets.all(8),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  item.icon,
                  color: Colors.white,
                  size: 30.0,
                ),
                const Padding(padding: EdgeInsets.all(3)),
                Text(
                  item.name,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
```

## Menampilkan Snackbar dengan Pesan yang Sesuai
Snackbar di-trigger ketika tombol ditekan dalam widget `ItemCard`, Pesan sesuai dengan nama tombol yang ditekan

``` dart
onTap: () {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(content: Text("Kamu telah menekan tombol ${item.name}!"))
    );
},
```

## Menjawab Pertanyaan
### Apa yang dimaksud dengan `StatelessWidget` dan `StatefulWidget` dan perbedaannya
- `StatelessWidget`: widget yang tidak memiliki "state" (keadaan) yang bisa berubah setelah widget tersebut dibuat. Artinya, tampilan atau data yang ditampilkan oleh widget ini tetap sama selama runtime. Widget ini cocok digunakan untuk konten yang tidak berubah atau tidak memerlukan pembaruan UI setelah widget ditampilkan. Contoh: Text, Icon, atau widget statis seperti Container dengan konten tetap
- `StatefulWidget `: widget yang memiliki "state" dan dapat berubah selama runtime. Widget ini bisa merespon interaksi pengguna, data yang diperbarui, atau event lain yang mengubah tampilan atau logika. Widget ini digunakan ketika bagian dari UI perlu diperbarui atau direfresh ketika ada perubahan data. Contoh: Widget yang mengandalkan input pengguna, seperti TextField atau Checkbox
- Perbedaan:  `StatelessWidget` bersifat statis, sedangkan `StatefulWidget ` bersifat dinamis karena statenya yg bisa berubah, lalu pada `StatefulWidget ` kita menggunakan `setState()` untuk memperbarui UI, sedangkan pada `StatelessWidget` tidak ada metode untuk memperbarui tampilan karena tampilannya tetap

### Widget apa saja yang saya gunakan pada proyek ini dan fungsinya
- Scaffold: Menyediakan struktur dasar untuk halaman Flutter, dengan AppBar di atas dan body untuk konten utama
- AppBar: Menampilkan header di bagian atas halaman, termasuk judul aplikasi
- Column: Menyusun widget secara vertikal
- Row: Menyusun widget secara horizontal, digunakan di sini untuk menempatkan InfoCard dalam satu baris
- Card: Menampilkan konten dalam kotak dengan shadow, memberikan efek "kartu"
- GridView: Membuat grid untuk menampilkan item secara teratur, digunakan untuk menyusun ItemCard dalam grid tiga kolom
- Material: Membungkus ItemCard untuk menerapkan efek material design, seperti InkWell
- InkWell: Menambahkan efek klik pada widget yang dibungkusnya, di sini digunakan untuk menampilkan SnackBar ketika ItemCard ditekan
- SnackBar: Menampilkan pesan sementara di bagian bawah layar ketika aksi dilakukan, seperti menekan tombol
- Icon: Menampilkan ikon dalam ItemCard sesuai dengan fungsi tombol
- Text: Menampilkan teks, digunakan di hampir semua widget untuk memberi label atau informasi

### Fungsi dari `setState()` dan variabel yang dapat terdampak
metode yang digunakan dalam StatefulWidget untuk memberi tahu Flutter bahwa ada perubahan pada "state" yang memerlukan pembaruan UI. Ketika setState() dipanggil, Flutter akan me-refresh bagian UI yang terpengaruh dengan perubahan data, sehingga tampilan terbaru bisa muncul

Hanya variabel atau properti yang berada dalam State dari StatefulWidget yang dapat diperbarui menggunakan setState().
Contoh variabel yang mungkin terpengaruh: teks yang perlu diubah, nilai dari form input, status checkbox, dan lainnya yang berada di dalam "state"

### Perbedaan antara `const` dengan `final`
- `const`: digunakan untuk variabel atau objek yang diketahui nilainya pada waktu kompilasi dan tidak akan berubah. Semua nilai atau properti dari objek const juga harus bersifat konstan dan tidak dapat berubah setelah inisialisasi. Contoh: const String title = "My App";
- `final`: digunakan untuk variabel atau objek yang nilainya hanya bisa diinisialisasi sekali dan bersifat tetap setelah itu, tetapi nilai tersebut bisa ditentukan saat runtime. Variabel final tidak perlu diketahui nilainya pada waktu kompilasi seperti const. Contoh: final int currentTime = DateTime.now().millisecondsSinceEpoch;
