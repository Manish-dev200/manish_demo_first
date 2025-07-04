class ProductResModel {
  final String name;
  final String description;
  final double rating;
  final String imageUrl;
  final String price;
  final bool? isCart;
  final int quantity;

  ProductResModel({
    required this.name,
    required this.description,
    required this.rating,
    required this.imageUrl,
    required this.price,
    this.isCart = false,
    this.quantity = 1,
  });

  ProductResModel copyWith({
    String? name,
    String? description,
    double? rating,
    String? imageUrl,
    String? price,
    bool? isCart,
    int? quantity,
  }) {
    return ProductResModel(
      name: name ?? this.name,
      description: description ?? this.description,
      rating: rating ?? this.rating,
      imageUrl: imageUrl ?? this.imageUrl,
      price: price ?? this.price,
      isCart: isCart ?? this.isCart,
      quantity: quantity ?? this.quantity,
    );
  }
}
