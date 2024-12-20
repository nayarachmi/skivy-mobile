# Tugas 9
## Mengimplementasikan Fitur Registrasi Akun Pada Proyek Tugas Flutter
Membuat model pada django yang digunakan untuk registrasi lalu membuat view untuk menangani permintaan POST untuk registrasi dan menambahkan path di `urls.py` untuk mengakses view. Setelah itu pastikan django diatur agar menerima permintaan dari aplikasi Flutter dengan menambahkan `django-cors-headers` pada `INSTALLED_APPS`. Lalu membuat halaman register di Flutter dan mengimplementasikan UI nya, juga memastikan `TextFormField` untuk username dan password.

## Membuat Halaman Login Pada Proyek Tugas Flutter
Memastika bahwa proyek Django sudah memiliki model untuk menangani autentikasi. Lalu membuat endpoint di Django yang dapat menerima permintaan POST untuk login dan merespons dengan token atau cookie autentikasi dan menambahkan routing di `urls.py`. Setelahnya membuat halaman login pafa Flutter dan mengimplementasikan UI nya, juga memastikan terdapat dua `TextField` untuk input username dan password

## Mengintegrasikan Sistem Autentikasi Django dengan Proyek Tugas Flutter
Membuat `django-app` pada proyek sebelumnya dengan nama `authentication` lalu menambahlan ke `INSTALLED_APPS`, seperti yang sudah disebutkan sebelumnya menambahkan `corsheaders` juga ke `INSTALLED_APPS` dan menambahkan `corsheaders.middleware.CorsMiddleware` ke `MIDDLEWARE`. Lalu menambahkan beberapa variabel pada `settings.py`

## Membuat Model Kustom Sesuai dengan Proyek Aplikasi Django
Model dapat dibuat pada path `lib/models/` dengan bantuan JSON data item pada aplikasi Django

## Membuat Halaman yang Berisi Daftar Semua Item yang Terdapat pada Endpoint JSON di Django yang Telah Di Deploy
### Tampilkan Name, Price, dan Description dari Masing-Masing Item pada Halaman Ini
Memastikan endpoint di Django sudah mengembalikan data JSON dalam format yang benar sesuai dengan model yang diharapkan oleh Flutter. Lalu mengambil data JSON di Flutter dan menulis fungsi untuk mengambil data dari endpoint Django. Selanjutnya menampilkan data dala UI untuk menampilkan nama, deskripsi, dan harga tiap produk

## Membuat Halaman Detail untuk Setiap Item yang Terdapat Pada Halaman Daftar Item
Membuat halaman baru untuk menampilkan detail produk. Halaman ini akan menampilkan atribut lengkap dari produk yang dipilih
``` Dart
class ProductDetailPage extends StatelessWidget {
  final ProductEntry product;

  const ProductDetailPage({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product.fields.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Name: ${product.fields.name}',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text(
              'Description: ${product.fields.description}',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),
            Text(
              'Price: \$${product.fields.price}',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),
            Text(
              'Skin Type: ${product.fields.skinType}',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 10),
            Text(
              'User: ${product.fields.user}',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context); // Kembali ke halaman sebelumnya
              },
              child: Text('Back to Product List'),
            )
          ],
        ),
      ),
    );
  }
}
```
## Navigasi dari Daftar Item ke Halaman Detail
Pada halaman daftar item, menambahkan `inkwell` untuk mendeteksi tap pada item dan mengarahkan pengguna ke halaman detail produk
``` dart
ListView.builder(
  itemCount: snapshot.data!.length,
  itemBuilder: (_, index) => Container(
    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    padding: const EdgeInsets.all(20.0),
    child: GestureDetector(
      onTap: () {
        // Navigasi ke halaman detail produk
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ProductDetailPage(
              product: snapshot.data![index], // Mengirimkan produk yang dipilih
            ),
          ),
        );
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            snapshot.data![index].fields.name,
            style: const TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Text("${snapshot.data![index].fields.name}"),
          const SizedBox(height: 10),
          Text("${snapshot.data![index].fields.price}"),
          const SizedBox(height: 10),
          Text("${snapshot.data![index].fields.description}")
        ],
      ),
    ),
  ),
)
```
## Update Halaman Daftar Produk 
Pastikan bahwa halaman daftar produk tetap berjalan seperti sebelumnya tetapi dengan tambahan navigasi ke halaman detail
``` dart
class ProductEntryPage extends StatefulWidget {
  const ProductEntryPage({super.key});

  @override
  State<ProductEntryPage> createState() => _ProductEntryPageState();
}

class _ProductEntryPageState extends State<ProductEntryPage> {
  Future<List<ProductEntry>> fetchProduct(CookieRequest request) async {
    final response = await request.get('http://127.0.0.1:8000/json/');
    var data = response;
    
    List<ProductEntry> listProduct = [];
    for (var d in data) {
      if (d != null) {
        listProduct.add(ProductEntry.fromJson(d));
      }
    }
    return listProduct;
  }

  @override
  Widget build(BuildContext context) {
    final request = context.watch<CookieRequest>();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Skivy Entry List'),
      ),
      drawer: const LeftDrawer(),
      body: FutureBuilder(
        future: fetchProduct(request),
        builder: (context, AsyncSnapshot snapshot) {
          if (snapshot.data == null) {
            return const Center(child: CircularProgressIndicator());
          } else {
            if (!snapshot.hasData) {
              return const Column(
                children: [
                  Text(
                    'Belum ada data product pada Skivy.',
                    style: TextStyle(fontSize: 20, color: Color(0xff59A5D8)),
                  ),
                  SizedBox(height: 8),
                ],
              );
            } else {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (_, index) => Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  padding: const EdgeInsets.all(20.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductDetailPage(
                            product: snapshot.data![index], // Mengirimkan produk yang dipilih
                          ),
                        ),
                      );
                    },
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          snapshot.data![index].fields.name,
                          style: const TextStyle(
                            fontSize: 18.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text("${snapshot.data![index].fields.name}"),
                        const SizedBox(height: 10),
                        Text("${snapshot.data![index].fields.price}"),
                        const SizedBox(height: 10),
                        Text("${snapshot.data![index].fields.description}")
                      ],
                    ),
                  ),
                ),
              );
            }
          }
        },
      ),
    );
  }
}
```

## Melakukan Filter pada Halaman Daftar Item dengan Hanya Menampilkan Item yang Terasosiasi dengan Pengguna yang Login
Pertama menyimpan informasi pengguna yang login, pada aplikasi ini pengguna yang login akan memiliki ID atau informasi yang dapat digunakan untuk memfilter produk, kita dapat mengakses informasi pengguna yang login melalui sesi atau token yang diberikan dengan `pbp_django_auth`. Pada backend Django kita juga perlu memastikan bahwa hanya item yang terkait dengan pengguna yang login yang dikirimkan dalam respons JSON. Misalnya, jika setiap produk memiliki atribut user yang mengacu pada ID pengguna, maka kita perlu memodifikasi query API untuk hanya mengembalikan produk yang sesuai dengan ID pengguna yang aktif. Setelah mendapatkan daftar produk yang telah difilter berdasarkan pengguna yang login, kita bisa melanjutkan untuk menampilkan daftar produk tersebut


## Menjawab Pertanyaan
### Mengapa Perlu Membuat Model untuk Pengambilan atau Pengiriman Data JSON?
Model berfungsi sebagai representasi struktural dari data yang dikirim dan diterima, memastikan bahwa data yang diterima dari server atau dikirim ke server sesuai dengan format yang diharapkan. Dengan model, kita dapat memvalidasi dan mengatur data JSON menjadi objek yang mudah digunakan dalam aplikasi. Jika tidak membuat model terlebih dahulu, data yang diterima mungkin sulit diakses atau diproses, yang berpotensi menyebabkan error atau data yang tidak konsisten.

Jika kita tidak membuat model terlebih dahulu, kita tetap dapat melakukan parsing manual terhadap data JSON, tetapi ini bisa menyebabkan kode menjadi lebih kompleks, rentan terhadap kesalahan, dan sulit dikelola. Error dapat terjadi jika struktur JSON berubah atau data diakses dengan cara yang salah, karena tidak ada tipe data yang terdefinisi dengan baik.

### Fungsi Library `http`
Library `http` di Flutter berfungsi untuk mengirim dan menerima data melalui protokol HTTP. Ini memungkinkan aplikasi melakukan permintaan HTTP seperti `GET`, `POST`, `PUT`, dan `DELETE` ke server. Pada tugas ini, `http` digunakan untuk membuat koneksi ke server Django untuk mengambil data dan mengirim data seperti hasil formulir pengguna.

### Fungsi `CookieRequest` dan Pembagiannya
`CookieRequest` adalah kelas yang digunakan untuk menangani permintaan HTTP yang membutuhkan sesi berbasis cookie. Ini memudahkan pengelolaan sesi login pengguna, sehingga sesi dapat dipertahankan di seluruh aplikasi. Penting untuk membagikan instance `CookieRequest` ke semua komponen agar data sesi konsisten di seluruh aplikasi dan fitur autentikasi dapat berfungsi dengan baik, seperti melacak status login pengguna.

### Mekanisme Pengiriman Data dari Input ke Tampilan
1. Pengguna mengisi formulir di Flutter dan menekan tombol submit.
2. Aplikasi memvalidasi input dan mengirimkan data menggunakan permintaan HTTP (misalnya `POST`) melalui `CookieRequest` atau `http`.
3. Data diterima oleh server Django, diproses, dan disimpan di database.
Server mengembalikan respons (biasanya dalam format JSON) yang diolah di Flutter.
4. Data yang dikembalikan ditampilkan pada antarmuka pengguna di aplikasi Flutter.

### Mekanisme Autentikasi (Login, Register, Logout)
- Login: Pengguna memasukkan kredensial (username dan password) di Flutter. Permintaan dikirim ke server Django untuk diverifikasi. Jika berhasil, server mengembalikan cookie sesi yang disimpan oleh CookieRequest di Flutter, menandakan bahwa pengguna telah berhasil login.

- Register: Pengguna memasukkan data akun di formulir Flutter dan data dikirim ke endpoint Django untuk membuat akun baru. Jika berhasil, akun baru dibuat di database.

- Logout: Pengguna menekan tombol logout di Flutter, yang memicu permintaan ke server Django untuk menghapus sesi. Django merespons dengan menghapus cookie sesi, dan Flutter menghapus status sesi pengguna.


# Tugas 8
## Kegunaan, Keuntungan, dan Waktu Menggunakan `const` pada Flutter
`const` di Flutter digunakan untuk mendeklarasikan nilai yang konstan atau tidak berubah sepanjang eksekusi aplikasi. Ketika kita menambahkan kata kunci `const` pada sebuah widget, itu berarti widget tersebut tidak akan diubah atau diperbarui lagi setelah dibangun, yang memungkinkan Flutter untuk mengoptimalkan penggunaan memori dan rendering. Hal ini membuat aplikasi lebih cepat karena Flutter dapat memanfaatkan widget yang telah ada di memori, bukan membuat ulang widget yang sama.

Keuntungannya ialah:
- Efisiensi Memori: Flutter dapat menghindari membuat instansi baru dari widget yang sama berulang kali
- Performa Lebih Baik: Menggunakan widget `const` membantu mengurangi jumlah pembaruan pada widget tree yang meningkatkan performa aplikasi
- Menjaga Konsistensi: `const` memastikan bahwa nilai atau objek tidak berubah setelah dibuat, yang membuat kode lebih mudah untuk dipelihara

`const` sebaiknya digunakan Saat widget yang digunakan tidak perlu diperbarui setelah pertama kali dibuat, misalnya pada widget yang hanya berfungsi untuk menampilkan statis konten. Lalu `const` sebaiknya tidak digunakan Ketika widget atau objek tersebut harus berubah berdasarkan input atau state tertentu

## Penggunaan Column dan Row pada Flutter
`Column ` dan `row` adalah widget layout di Flutter yang digunakan untuk menyusun widget lainnya dalam bentuk vertikal (Column) atau horizontal (Row)

### `Column`
Digunakan untuk menyusun widget secara vertikal, widget yang ditempatkan dalam `Column` akan tampil dari atas ke bawah. Contoh implementasi:
``` dart
Column(
  children: <Widget>[
    Text('Item 1'),
    Text('Item 2'),
    Text('Item 3'),
  ],
)
```

### `Row`
Digunakan untuk menyusun widget secara horizontal, widget yang ditempatkan dalam `row` akan tampil dari kiri ke kanan. Contoh implementasi:
``` dart
Row(
  children: <Widget>[
    Icon(Icons.home),
    Icon(Icons.search),
    Icon(Icons.settings),
  ],
)
```

## Elemen Input yang Digunakan dan yang Tidak Digunakan
Elemen input yang digunakan:
- TextFormField: Digunakan untuk memasukkan nama produk, deskripsi produk, dan jumlah produk (amount). Setiap input memiliki validator untuk memastikan data yang dimasukkan valid, seperti memastikan nama dan deskripsi tidak kosong, dan jumlah berupa angka

Elemen yang tidak digunakan:
- Checkbox: Untuk pilihan biner (misalnya, status aktif/non-aktif
- Radio: Untuk pilihan tunggal dari beberapa opsi
- DropdownButton: Untuk memilih dari daftar pilihan
- Switch: Untuk status aktif/non-aktif, dapat digunakan sebagai alternatif checkbox

Keputusan Tidak Menggunakan Elemen Lain adalah karena Pada form ini, hanya diperlukan input teks dan angka, karena fokusnya adalah untuk memasukkan data produk sederhana. Elemen input lain seperti dropdown atau checkbox tidak relevan dalam konteks tugas ini.

## Cara Mengatur Konsistensi Tema dan Apakah Diimplementasikan
Menggunakan `ThemeData` untuk menetapkan tema global yang dapat diterapkan ke seluruh aplikasi. Contoh implementasi tema di aplikasi ini bisa dilihat di kode berikut:
```dart
theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.pink,
        ).copyWith(secondary: Colors.pinkAccent[100]),
        useMaterial3: true,
      ),
```
Dengan cara ini, tema yang ditetapkan akan digunakan secara konsisten di seluruh aplikasi. Pada aplikasi ini saya sudah mengimplementasikan tema menggunakan `Theme.of(context).colorScheme.primary` pada bagian `AppBar` dan tombol. Tema ini mengatur konsistensi warna di aplikasi sehingga elemen UI terlihat seragam atau sama

## Cara Menangani Navigasi dalam Aplikasi dengan Banyak Halaman pada Flutter
Navigasi antar halaman dalam Flutter bisa dilakukan dengan menggunakan `Navigator` yang memungkinkan kita berpindah antar halaman menggunakan `Navigator.push()` atau kembali ke halaman sebelumnya menggunakan `Navigator.pop()`. Contoh implementasi:
```dart
Navigator.push(
  context,
  MaterialPageRoute(builder: (context) => HalamanBaru()),
);

Navigator.pop(context);
```

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
