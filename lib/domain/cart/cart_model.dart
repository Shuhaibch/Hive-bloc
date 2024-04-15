// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:hive/hive.dart';

part 'cart_model.g.dart';

@HiveType(typeId: 1)
class Cart {
  @HiveField(0)
  final String name;

  @HiveField(1)
  final String image;

  @HiveField(2)
  final int count;

  @HiveField(3)
  final int id;

  Cart({
    required this.name,
    required this.image,
    required this.count,
    required this.id,
  });
  Cart copyWith({
    String? name,
    String? image,
    int? count,
    int? id,
  }) =>
      Cart(
        name: name ?? this.name,
        image: image ?? this.image,
        count: count ?? this.count,
        id: id ?? this.id,
      );
}
