import 'package:cloud_firestore/cloud_firestore.dart';
import '../variables/menu_models.dart';

class MenuFetcher {
  final FirebaseFirestore _firestore;

  MenuFetcher({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  Future<List<Menu>> fetchMenus() async {
    try {
      final DocumentSnapshot snapshot = await _firestore
          .collection('food')
          .doc('food_menu')
          .get();

      if (!snapshot.exists) {
        print("Menu document not found");
        return [];
      }

      final data = snapshot.data() as Map<String, dynamic>;
      List<Menu> menuList = [];

      // Iterate through all fields in the document
      data.forEach((key, value) {
        if (key.startsWith('menu_') && value is Map<String, dynamic>) {
          menuList.add(Menu.fromMap(value));
        }
      });

      return menuList;
    } catch (e) {
      print("Error fetching menus: $e");
      return [];
    }
  }
}