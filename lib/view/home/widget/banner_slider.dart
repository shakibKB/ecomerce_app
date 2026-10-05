import 'package:flutter/material.dart';
import '../../../utility/app_colors.dart';
import '../../../utility/assets.dart';

class BannerSlider extends StatelessWidget {
  const BannerSlider({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 160,
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(
          colors: [
            Color(0xFF2B1D14),
            Color(0xFFFF6A00),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withValues(alpha: 0.3),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Background subtle circles
          Positioned(
            right: -20,
            bottom: -20,
            child: CircleAvatar(
              radius: 80,
              backgroundColor: Colors.white.withValues(alpha: 0.08),
            ),
          ),
          // Content
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.4),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: const Text(
                    "LIMITED DROP ⚡",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  "Get Up To 30% Off\nOn New Arrivals",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w800,
                    height: 1.2,
                  ),
                ),
                const SizedBox(height: 8),
                const Row(
                  children: [
                    Text(
                      "Use code: ",
                      style: TextStyle(color: Colors.white70, fontSize: 12),
                    ),
                    Text(
                      "NIKE30",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Shoe image overlay
          Positioned(
            right: 10,
            bottom: 10,
            child: Transform.rotate(
              angle: -0.25,
              child: Image.asset(
                Assets.nike,
                height: 110,
                fit: BoxFit.contain,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
