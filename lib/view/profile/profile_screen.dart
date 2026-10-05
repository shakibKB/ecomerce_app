import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../utility/app_colors.dart';
import '../dashboard/controller/bottom_nav_controller.dart';
import '../home/controller/home_controller.dart';
import 'controller/profile_controller.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ProfileController profileController = Get.find<ProfileController>();
    final HomeController homeController = Get.find<HomeController>();
    final BottomNavController navController = Get.find<BottomNavController>();

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        title: const Text(
          "My Profile",
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings_outlined, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        child: Column(
          children: [
            // User Avatar & Name Card
            Obx(() {
              final user = profileController.user.value;
              return Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: AppColors.card,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: AppColors.border),
                ),
                child: Row(
                  children: [
                    Stack(
                      children: [
                        const CircleAvatar(
                          radius: 36,
                          backgroundColor: AppColors.cardLight,
                          child: Icon(
                            Icons.person,
                            size: 40,
                            color: AppColors.primary,
                          ),
                        ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: const BoxDecoration(
                              color: AppColors.primary,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.edit,
                              size: 14,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            user.name,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            user.email,
                            style: const TextStyle(
                              fontSize: 13,
                              color: AppColors.textSecondary,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 3,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.primary.withValues(alpha: 0.15),
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: AppColors.primary.withValues(alpha: 0.4),
                              ),
                            ),
                            child: Text(
                              user.membershipBadge,
                              style: const TextStyle(
                                color: AppColors.primary,
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }),
            const SizedBox(height: 18),

            // Statistics Row
            Obx(() {
              final user = profileController.user.value;
              return Row(
                children: [
                  _buildStatCard(
                      "Orders", "${user.orderCount}", Icons.local_shipping_outlined),
                  const SizedBox(width: 10),
                  _buildStatCard(
                    "Wishlist",
                    "${homeController.wishlistProducts.length}",
                    Icons.favorite_outline_rounded,
                    onTap: () => navController.goToWishlist(),
                  ),
                  const SizedBox(width: 10),
                  _buildStatCard(
                      "Coupons", "${user.couponCount}", Icons.discount_outlined),
                ],
              );
            }),
            const SizedBox(height: 24),

            // Menu Section: Account
            _buildSectionHeader("Account Settings"),
            const SizedBox(height: 8),
            _buildMenuCard([
              _buildMenuItem(
                icon: Icons.receipt_long_rounded,
                title: "My Orders",
                subtitle: "View history & track packages",
                trailing: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Text(
                    "2 Active",
                    style: TextStyle(color: Colors.white, fontSize: 10),
                  ),
                ),
                onTap: () {},
              ),
              _buildMenuItem(
                icon: Icons.location_on_outlined,
                title: "Shipping Addresses",
                subtitle: "Home, Office & others",
                onTap: () {},
              ),
              _buildMenuItem(
                icon: Icons.credit_card_outlined,
                title: "Payment Methods",
                subtitle: "Cards, Apple Pay, PayPal",
                onTap: () {},
              ),
            ]),
            const SizedBox(height: 20),

            // Menu Section: Preferences
            _buildSectionHeader("Preferences"),
            const SizedBox(height: 8),
            _buildMenuCard([
              _buildMenuItem(
                icon: Icons.notifications_none_rounded,
                title: "Notifications",
                subtitle: "Discounts, order updates",
                onTap: () {},
              ),
              _buildMenuItem(
                icon: Icons.language_rounded,
                title: "Language & Currency",
                subtitle: "English (USD)",
                onTap: () {},
              ),
              _buildMenuItem(
                icon: Icons.help_outline_rounded,
                title: "Help & Support",
                subtitle: "FAQs, 24/7 customer chat",
                onTap: () {},
              ),
            ]),
            const SizedBox(height: 20),

            // Log Out Button
            GestureDetector(
              onTap: () => profileController.logout(),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 14),
                decoration: BoxDecoration(
                  color: AppColors.card,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                      color: AppColors.error.withValues(alpha: 0.3)),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.logout_rounded, color: AppColors.error, size: 20),
                    SizedBox(width: 8),
                    Text(
                      "Log Out",
                      style: TextStyle(
                        color: AppColors.error,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String label, String value, IconData icon,
      {VoidCallback? onTap}) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 10),
          decoration: BoxDecoration(
            color: AppColors.card,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(color: AppColors.border),
          ),
          child: Column(
            children: [
              Icon(icon, color: AppColors.primary, size: 22),
              const SizedBox(height: 6),
              Text(
                value,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                label,
                style: const TextStyle(
                  color: AppColors.textSecondary,
                  fontSize: 11,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 15,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  Widget _buildMenuCard(List<Widget> items) {
    return Material(
      color: AppColors.card,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: AppColors.border),
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: items,
      ),
    );
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required String subtitle,
    Widget? trailing,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Icon(icon, color: AppColors.primary, size: 20),
      ),
      title: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: const TextStyle(
          color: AppColors.textSecondary,
          fontSize: 11,
        ),
      ),
      trailing: trailing ??
          const Icon(
            Icons.arrow_forward_ios_rounded,
            size: 14,
            color: AppColors.textMuted,
          ),
      onTap: onTap,
    );
  }
}
