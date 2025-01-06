import 'package:cloud_firestore/cloud_firestore.dart';
import '../variables/banner_models.dart';

class BannerFetcher {
  final FirebaseFirestore _firestore;

  BannerFetcher({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  Future<List<Banner>> fetchBanners() async {
    try {
      final DocumentSnapshot snapshot = await _firestore
          .collection('food')
          .doc('banners')
          .get();

      
      if (!snapshot.exists) {
        print("Banner document not found");
        return [];
      }

      final data = snapshot.data() as Map<String, dynamic>;
      List<Banner> bannerList = [];

      data.forEach((key, value) {
        if (key.startsWith('banner_') && value is Map<String, dynamic>) {
          bannerList.add(Banner.fromMap(value));
        }
      });

      return bannerList;

    } catch (e) {
      print("Error fetching menus: $e");
      return [];
    }
  }
}