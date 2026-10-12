import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TechExpres',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF6C4AB6)),
        useMaterial3: true,
      ),
      initialRoute: '/login',
      routes: {
        '/login': (context) => const LoginPage(),
        '/main': (context) => const MainNavigationPage(),
      },
    );
  }
}

// 1. HALAMAN LOGIN
class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F6FA),
      appBar: AppBar(
        title: const Text('Clarisya Aura'),
        centerTitle: true,
        backgroundColor: const Color(0xFFE8DDF8),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: const Color(0xFFF4EEFC),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.devices,
                  size: 68,
                  color: const Color(0xFF6C4AB6),
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Selamat Datang di TechExpres',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 10),
              const Text(
                'Temukan gadget yang cocok untuk kamu.',
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 15, color: Colors.black54),
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF6C4AB6),
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, '/main');
                  },
                  child: const Text(
                    'Masuk Aplikasi',
                    style: TextStyle(fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// 2. HALAMAN UTAMA DENGAN BOTTOM NAVIGATION
class MainNavigationPage extends StatefulWidget {
  const MainNavigationPage({super.key});

  @override
  State<MainNavigationPage> createState() => _MainNavigationPageState();
}

class _MainNavigationPageState extends State<MainNavigationPage> {
  int _selectedIndex = 0;

  final List<Widget> _pages = const [CatalogPage(), ProfilePage()];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: const Color(0xFF6C4AB6),
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.store), label: 'Katalog'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profil'),
        ],
      ),
    );
  }
}

// 3. DATA GADGET
class Gadget {
  final String nama;
  final String kategori;
  final int harga;
  final String deskripsi;
  final String gambar;

  const Gadget({
    required this.nama,
    required this.kategori,
    required this.harga,
    required this.deskripsi,
    required this.gambar,
  });
}

const List<Gadget> daftarGadget = [
  Gadget(
    nama: 'Smartphone Pro X',
    kategori: 'Handphone',
    harga: 8500000,
    deskripsi: 'Smartphone dengan kamera jernih dan performa yang cepat.',
    gambar:
        'https://images.unsplash.com/photo-1592899677977-9c10ca588bbd?w=900',
  ),
  Gadget(
    nama: 'Laptop Ultra Slim',
    kategori: 'Komputer',
    harga: 12000000,
    deskripsi: 'Laptop tipis dan ringan untuk belajar dan produktivitas.',
    gambar:
        'https://images.unsplash.com/photo-1496096265110-f83ad7f96608?w=900',
  ),
  Gadget(
    nama: 'Wireless Earbuds',
    kategori: 'Aksesoris',
    harga: 750000,
    deskripsi: 'Earbuds nirkabel dengan suara jernih untuk menemani aktivitas.',
    gambar:
        'https://images.unsplash.com/photo-1606220945770-b5b6c2c55bf1?w=900',
  ),
];

// 4. TAB KATALOG
class CatalogPage extends StatefulWidget {
  const CatalogPage({super.key});

  @override
  State<CatalogPage> createState() => _CatalogPageState();
}

class _CatalogPageState extends State<CatalogPage> {
  String kataPencarian = '';
  String kategoriDipilih = 'Semua';

  final List<String> kategori = ['Semua', 'Handphone', 'Komputer', 'Aksesori'];

  String formatRupiah(int angka) {
    final teks = angka.toString();
    final hasil = teks.replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]}.',
    );
    return 'Rp $hasil';
  }

  @override
  Widget build(BuildContext context) {
    final hasilPencarian = daftarGadget.where((gadget) {
      final cocokNama = gadget.nama.toLowerCase().contains(
        kataPencarian.toLowerCase(),
      );
      final cocokKategori =
          kategoriDipilih == 'Semua' || gadget.kategori == kategoriDipilih;
      return cocokNama && cocokKategori;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('TechExpres - Katalog'),
        backgroundColor: const Color(0xFFE8DDF8),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 12, 12, 4),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  kataPencarian = value;
                });
              },
              decoration: InputDecoration(
                hintText: 'Cari gadget...',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: const Color(0xFFF4EEFC),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          SizedBox(
            height: 48,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
              children: kategori.map((item) {
                final dipilih = kategoriDipilih == item;
                return Padding(
                  padding: const EdgeInsets.only(right: 8),
                  child: ChoiceChip(
                    label: Text(item),
                    selected: dipilih,
                    selectedColor: const Color(0xFF6C4AB6),
                    backgroundColor: const Color(0xFFF4EEFC),
                    labelStyle: TextStyle(
                      color: dipilih ? Colors.white : const Color(0xFF51436B),
                      fontWeight: FontWeight.w600,
                    ),
                    onSelected: (value) {
                      setState(() {
                        kategoriDipilih = item;
                      });
                    },
                  ),
                );
              }).toList(),
            ),
          ),
          Expanded(
            child: hasilPencarian.isEmpty
                ? const Center(child: Text('Gadget tidak ditemukan.'))
                : ListView.builder(
                    padding: const EdgeInsets.all(12),
                    itemCount: hasilPencarian.length,
                    itemBuilder: (context, index) {
                      final gadget = hasilPencarian[index];

                      return Card(
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        clipBehavior: Clip.antiAlias,
                        elevation: 2,
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(10),
                          leading: ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              gadget.gambar,
                              width: 65,
                              height: 65,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return Container(
                                  width: 65,
                                  height: 65,
                                  color: const Color(0xFFF4EEFC),
                                  child: const Icon(
                                    Icons.devices,
                                    color: const Color(0xFF6C4AB6),
                                    size: 32,
                                  ),
                                );
                              },
                            ),
                          ),
                          title: Text(
                            gadget.nama,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Text(
                            '${gadget.kategori}\n${formatRupiah(gadget.harga)}',
                          ),
                          isThreeLine: true,
                          trailing: const Icon(
                            Icons.arrow_forward_ios,
                            size: 16,
                          ),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    DetailGadgetPage(gadget: gadget),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

// 5. HALAMAN DETAIL GADGET DAN VOUCHER
class DetailGadgetPage extends StatefulWidget {
  final Gadget gadget;

  const DetailGadgetPage({super.key, required this.gadget});

  @override
  State<DetailGadgetPage> createState() => _DetailGadgetPageState();
}

class _DetailGadgetPageState extends State<DetailGadgetPage> {
  String statusVoucher = 'Belum diklaim';
  late int hargaSekarang;

  @override
  void initState() {
    super.initState();
    hargaSekarang = widget.gadget.harga;
  }

  String formatRupiah(int angka) {
    final hasil = angka.toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]}.',
    );
    return 'Rp $hasil';
  }

  @override
  Widget build(BuildContext context) {
    final gadget = widget.gadget;

    return Scaffold(
      appBar: AppBar(title: Text(gadget.nama)),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(14),
              child: Image.network(
                gadget.gambar,
                height: 190,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: 190,
                    width: double.infinity,
                    color: const Color(0xFFF4EEFC),
                    child: const Icon(
                      Icons.devices,
                      size: 80,
                      color: const Color(0xFF6C4AB6),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
            Text(
              gadget.nama,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Chip(
              label: Text(gadget.kategori),
              backgroundColor: const Color(0xFFE8DDF8),
            ),
            const SizedBox(height: 8),
            Text(
              formatRupiah(hargaSekarang),
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: const Color(0xFF168C78),
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Voucher Diskon:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(
              statusVoucher,
              style: TextStyle(
                fontSize: 15,
                color: statusVoucher == 'Belum diklaim'
                    ? Colors.grey
                    : const Color(0xFFDA6B4D),
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 12),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                icon: const Icon(Icons.local_offer),
                label: const Text('Klaim Voucher Diskon'),
                onPressed: () async {
                  final hasilVoucher = await Navigator.push<String>(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const PilihVoucherPage(),
                    ),
                  );

                  if (!mounted) return;

                  if (hasilVoucher != null) {
                    setState(() {
                      statusVoucher = 'Berhasil diklaim: $hasilVoucher';

                      if (hasilVoucher == 'Diskon 10%') {
                        hargaSekarang = gadget.harga * 90 ~/ 100;
                      } else if (hasilVoucher == 'Diskon 20%') {
                        hargaSekarang = gadget.harga * 80 ~/ 100;
                      } else if (hasilVoucher == 'Diskon 30%') {
                        hargaSekarang = gadget.harga * 70 ~/ 100;
                      }
                    });
                  }
                },
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'Deskripsi:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(
              gadget.deskripsi,
              style: const TextStyle(fontSize: 14, height: 1.4),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Kembali'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// 6. HALAMAN PILIH VOUCHER
class PilihVoucherPage extends StatelessWidget {
  const PilihVoucherPage({super.key});

  @override
  Widget build(BuildContext context) {
    const daftarVoucher = ['Diskon 10%', 'Diskon 20%', 'Diskon 30%'];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Pilih Voucher'),
        backgroundColor: const Color(0xFFE8DDF8),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(12),
        itemCount: daftarVoucher.length,
        itemBuilder: (context, index) {
          final voucher = daftarVoucher[index];

          return Card(
            child: ListTile(
              leading: const Icon(
                Icons.local_offer,
                color: const Color(0xFF6C4AB6),
              ),
              title: Text(
                voucher,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: const Text('Gunakan untuk mengurangi harga gadget'),
              trailing: const Icon(Icons.arrow_forward_ios, size: 16),
              onTap: () {
                Navigator.pop(context, voucher);
              },
            ),
          );
        },
      ),
    );
  }
}

// 7. TAB PROFIL
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil TechExpres'),
        backgroundColor: const Color(0xFFE8DDF8),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                CircleAvatar(
                  radius: 38,
                  backgroundColor: const Color(0xFF6C4AB6),
                  child: Icon(Icons.person, size: 42, color: Colors.white),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Clarisya Aura',
                        style: TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text('clarisyaaura@techexpres.com'),
                    ],
                  ),
                ),
              ],
            ),
            const Divider(height: 32),
            const Text(
              'Kode Member:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Card(
              child: ListTile(
                leading: Icon(
                  Icons.card_membership,
                  color: const Color(0xFF6C4AB6),
                ),
                title: Text('MEMBER-TECH-9988'),
                subtitle: Text('Gunakan untuk klaim voucher diskon'),
                trailing: Text(
                  'Aktif',
                  style: TextStyle(color: const Color(0xFF168C78)),
                ),
              ),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  foregroundColor: Colors.white,
                ),
                icon: const Icon(Icons.logout),
                label: const Text('Logout / Keluar'),
                onPressed: () {
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    '/login',
                    (route) => false,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
