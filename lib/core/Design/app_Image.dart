import 'dart:io';
import 'package:flutter/material.dart';

class AppImage extends StatelessWidget {
  final String image; // يمكن يكون "splash.png" أو "assets/JPG/splash.png" أو رابط http
  final double? height, width;
  final BoxFit fit;
  final double radius;
  final Color? color;
  final bool imageIsFullPath; // لو فعلاً بعتِ المسار كامل للـ asset أو ملف

  const AppImage(
      this.image, {
        super.key,
        this.height,
        this.width,
        this.fit = BoxFit.cover,
        this.radius = 0,
        this.color,
        this.imageIsFullPath = false,
      });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: Builder(builder: (context) {
        try {
          if (image.startsWith('http')) {
            return Image.network(
              image,
              height: height,
              width: width,
              fit: fit,
              color: color,
              errorBuilder: (c, e, st) => _errorWidget(e),
            );
          }

          // صورة من ملف نظام (مثال: مسار كامل في الجهاز)
          if (image.contains('com.') || File(image).existsSync()) {
            return Image.file(
              File(image),
              height: height,
              width: width,
              fit: fit,
              color: color,
              errorBuilder: (c, e, st) => _errorWidget(e),
            );
          }

          // افتراضي: asset داخل مشروع
          final assetPath = imageIsFullPath
              ? image
              : (image.startsWith('assets/') ? image : 'assets/JPG/$image');

          return Image.asset(
            assetPath,
            height: height,
            width: width,
            fit: fit,
            color: color,
            errorBuilder: (c, e, st) => _errorWidget(e),
          );
        } catch (e) {
          return _errorWidget(e);
        }
      }),
    );
  }

  Widget _errorWidget(Object? error) {
    return Container(
      color: Colors.grey[200],
      alignment: Alignment.center,
      padding: const EdgeInsets.all(8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.broken_image, size: 48),
          const SizedBox(height: 8),
          const Text('Image load error'),
          const SizedBox(height: 4),
          Text(
            error?.toString() ?? 'unknown error',
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 11),
          ),
        ],
      ),
    );
  }
}
