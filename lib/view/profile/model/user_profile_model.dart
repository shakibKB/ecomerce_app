class UserProfileModel {
  final String name;
  final String email;
  final String membershipBadge;
  final int orderCount;
  final int couponCount;

  const UserProfileModel({
    required this.name,
    required this.email,
    required this.membershipBadge,
    required this.orderCount,
    required this.couponCount,
  });

  static const UserProfileModel defaultUser = UserProfileModel(
    name: "Alex Mercer",
    email: "alex.mercer@gmail.com",
    membershipBadge: "VIP Gold Member 👑",
    orderCount: 12,
    couponCount: 4,
  );
}
