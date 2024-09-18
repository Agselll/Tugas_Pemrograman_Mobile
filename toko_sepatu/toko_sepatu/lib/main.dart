import 'package:flutter/material.dart';

void main() {
  runApp(TokoSepatuApp());
}

class TokoSepatuApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Toko Sepatu',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  final List<String> sepatuList = [
    'Sepatu Nike Air Max',
    'Sepatu Adidas Ultraboost',
    'Sepatu Converse All Star',
    'Sepatu Vans Old Skool',
    'Sepatu Puma Ignite',
    'Sepatu Reebok Classic',
  ];

  final List<String> sepatuImages = [
    'assets/NIKEAIRMAX-removebg-preview.png',
    'assets/ultraboost-removebg-preview.png',
    'assets/all_star-removebg-preview.png',
    'assets/old_skool-removebg-preview.png',
    'assets/ignite-removebg-preview.png',
    'assets/classic-removebg-preview.png',
  ];

  final List<String> kategoriList = [
    'Olahraga',
    'Kasual',
    'Formal',
    'Boots',
    'Sneakers',
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _getPage(int index) {
    switch (index) {
      case 0:
        return HomeContent(
          sepatuList: sepatuList,
          sepatuImages: sepatuImages,
          onTap: (index) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailSepatuPage(
                  namaSepatu: sepatuList[index],
                  gambarSepatu: sepatuImages[index],
                ),
              ),
            );
          },
        );
      case 1:
        return KategoriPage(
          kategoriList: kategoriList,
          onKategoriTap: (kategori) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    ListSepatuKategoriPage(kategori: kategori),
              ),
            );
          },
        );
      case 2:
        return KeranjangPage();
      case 3:
        return ProfilPage();
      default:
        return HomeContent(
          sepatuList: sepatuList,
          sepatuImages: sepatuImages,
          onTap: (index) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DetailSepatuPage(
                  namaSepatu: sepatuList[index],
                  gambarSepatu: sepatuImages[index],
                ),
              ),
            );
          },
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Toko Sepatu'),
      ),
      body: _getPage(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        showUnselectedLabels: true,
        unselectedItemColor: Colors.grey,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.category),
            label: 'Kategori',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Keranjang',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profil',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blue,
        onTap: _onItemTapped,
      ),
    );
  }
}

class HomeContent extends StatelessWidget {
  final List<String> sepatuList;
  final List<String> sepatuImages;
  final Function(int) onTap;

  HomeContent(
      {required this.sepatuList,
      required this.sepatuImages,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: sepatuList.length,
        itemBuilder: (context, index) {
          return Card(
            elevation: 5,
            child: Column(
              children: [
                Expanded(
                  child: Stack(
                    children: [
                      Container(
                        width: double.infinity,
                        child: Image.asset(
                          sepatuImages[index],
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned(
                        top: 10,
                        right: 10,
                        child: Container(
                          color: Colors.red,
                          padding: EdgeInsets.all(5),
                          child: Text(
                            'Diskon 20%',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  sepatuList[index],
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 5),
                Text('Rp 500.000'),
                ElevatedButton(
                  onPressed: () => onTap(index),
                  child: Text('Lihat Detail'),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class DetailSepatuPage extends StatelessWidget {
  final String namaSepatu;
  final String gambarSepatu;

  DetailSepatuPage({required this.namaSepatu, required this.gambarSepatu});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(namaSepatu),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              gambarSepatu,
              height: 300,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 16),
            Text(
              namaSepatu,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              'Deskripsi sepatu akan ditampilkan di sini.',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Text(
              'Rp 500.000',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Tambah sepatu ke keranjang
              },
              child: Text('Tambah ke Keranjang'),
            ),
          ],
        ),
      ),
    );
  }
}

class KategoriPage extends StatelessWidget {
  final List<String> kategoriList;
  final Function(String) onKategoriTap;

  KategoriPage({required this.kategoriList, required this.onKategoriTap});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: kategoriList.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(kategoriList[index]),
          onTap: () => onKategoriTap(kategoriList[index]),
        );
      },
    );
  }
}

class ListSepatuKategoriPage extends StatelessWidget {
  final String kategori;

  ListSepatuKategoriPage({required this.kategori});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Kategori: $kategori'),
      ),
      body: Center(
        child: Text(
          'Daftar sepatu untuk kategori $kategori akan ditampilkan di sini.',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}

class KeranjangPage extends StatefulWidget {
  @override
  _KeranjangPageState createState() => _KeranjangPageState();
}

class _KeranjangPageState extends State<KeranjangPage> {
  List<String> keranjangList = [
    'Sepatu Nike Air Max',
    'Sepatu Adidas Ultraboost',
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Keranjang Belanja',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: keranjangList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(keranjangList[index]),
                  trailing: IconButton(
                    icon: Icon(Icons.remove_circle),
                    onPressed: () {
                      setState(() {
                        keranjangList.removeAt(index);
                      });
                    },
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 16),
          Text(
            'Total: Rp ${keranjangList.length * 500000}',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

class ProfilPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Profil Pengguna',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16),
          Text(
            'Nama: Ibnu Gilang Praduta Cipta',
            style: TextStyle(fontSize: 18),
          ),
          SizedBox(height: 8),
          Text(
            'Email: dutaibnu16@gmail.com',
            style: TextStyle(fontSize: 18),
          ),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              // Navigasi ke halaman edit profil
            },
            child: Text('Edit Profil'),
          ),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: () {
              // Navigasi ke halaman riwayat pembelian
            },
            child: Text('Riwayat Pembelian'),
          ),
        ],
      ),
    );
  }
}
