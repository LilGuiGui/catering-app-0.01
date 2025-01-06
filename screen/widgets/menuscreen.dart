import 'package:flutter/material.dart';
import '../../../variables/menu_models.dart';
import '../../service/menufetch.dart';

class MenuScreen extends StatefulWidget {
  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  final MenuFetcher _menuFetcher = MenuFetcher();
  late Future<List<Menu>> _menusFuture;

  @override
  void initState() {
    super.initState();
    _menusFuture = _menuFetcher.fetchMenus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: FutureBuilder<List<Menu>>(
        future: _menusFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final menus = snapshot.data ?? [];
          
          if (menus.isEmpty) {
            return const Center(child: Text('No menus available'));
          }

          return SingleChildScrollView(
            child: Column(
              children: menus.map((menu) {
                return Card(
                  margin: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Image.network(
                        menu.imageUrl ?? '',
                        height: 200,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => const Icon(
                          Icons.broken_image,
                          size: 200,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              menu.name ?? 'Unnamed Item',
                              style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text('Price: \$${menu.price?.toStringAsFixed(2) ?? '0.00'}'),
                            Text(menu.availability ?? false ? 'Available' : 'Not Available'),
                            const SizedBox(height: 5),
                            Text(
                              menu.description ?? 'No description available',
                              style: const TextStyle(color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          );
        },
      ),
    );
  }
}