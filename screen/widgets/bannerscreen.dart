import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import '../../service/bannerfetch.dart'; // Update the path to match your project

class BannerCarousel extends StatefulWidget {
  final double height;
  final bool autoPlay;
  final Duration autoPlayInterval;

  const BannerCarousel({
    super.key,
    this.height = 200,
    this.autoPlay = true,
    this.autoPlayInterval = const Duration(seconds: 5),
  });

  @override
  State<BannerCarousel> createState() => _BannerCarouselState();
}

class _BannerCarouselState extends State<BannerCarousel> {
  final BannerFetcher _bannerFetcher = BannerFetcher();
  late Future<List<String?>> _imageUrlsFuture;

  @override
  void initState() {
    super.initState();
    _imageUrlsFuture = _fetchImageUrls();
  }

  Future<List<String?>> _fetchImageUrls() async {
    final banners = await _bannerFetcher.fetchBanners();
    return banners.map((banner) => banner.imageUrl).toList();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<String?>>(
      future: _imageUrlsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return SizedBox(
            height: widget.height,
            child: const Center(child: CircularProgressIndicator()),
          );
        }

        if (snapshot.hasError) {
          return SizedBox(
            height: widget.height,
            child: Center(
              child: Text(
                'Error: ${snapshot.error}',
                style: TextStyle(color: Colors.red[700]),
              ),
            ),
          );
        }

        final imageUrls = snapshot.data ?? [];
        if (imageUrls.isEmpty) {
          return SizedBox(
            height: widget.height,
            child: const Center(child: Text('No banners available')),
          );
        }

        return CarouselSlider.builder(
          itemCount: imageUrls.length,
          itemBuilder: (context, index, realIndex) {
            final imageUrl = imageUrls[index];
            return ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                imageUrl ?? '',
                fit: BoxFit.cover,
                width: double.infinity,
                errorBuilder: (context, error, stackTrace) => Container(
                  color: Colors.grey[300],
                  child: const Icon(Icons.broken_image, size: 50),
                ),
              ),
            );
          },
          options: CarouselOptions(
            height: widget.height,
            autoPlay: widget.autoPlay,
            autoPlayInterval: widget.autoPlayInterval,
            viewportFraction: 0.85,
            enlargeCenterPage: true,
          ),
        );
      },
    );
  }
}
