import 'package:flutter/material.dart';
import 'package:front_end/controller/product/product_controller.dart';
import 'package:front_end/model/product_model.dart';
import 'package:go_router/go_router.dart';

class SearchAnchorCustom extends StatefulWidget {
  const SearchAnchorCustom({super.key});

  @override
  State<SearchAnchorCustom> createState() => _SearchAnchorCustomState();
}

class _SearchAnchorCustomState extends State<SearchAnchorCustom> {
  final List<ProductModel> _searchResults = [];

  final ProductController productController = ProductController();

  @override
  void initState() {
    super.initState();
    // Initialize any necessary data or state here
    _getdata();
  }

  void _getdata() async {
    // Fetch data from the controller or any other source
    final products = await productController.getProductsList();
    setState(() {
      // Update the state with the fetched data
      _searchResults.clear();
      _searchResults.addAll(products);
    });
  }

  @override
  Widget build(BuildContext context) {
    return SearchAnchor.bar(
      barHintText: 'Nhập tên sản phẩm',
      viewHintText: 'Tìm kiếm sản phẩm',
      searchController: SearchController(),
      suggestionsBuilder: (context, controller) {
        return _searchResults
            .where((result) => result.name
                .toLowerCase()
                .contains(controller.text.toLowerCase() 
                 ) || controller.text.isEmpty)
            .map((result) {
          return ListTile(
            leading: Image.network(result.imageUrls[0]),
            trailing: Text('${result.price} VND'),
            title: Text(result.name),
            onTap: () {
              // Handle the tap event, e.g., navigate to a product detail page
              context.push('/detail/${result.id}');
            },
          );
        }).toList();
      },
    );
  }
}