import 'package:flutter/material.dart';
import '../models/product.dart';  // Make sure this is the correct import for your Product model
import '../services/api_services.dart';  // Import for your API service to fetch products

class ProductSearchDelegate extends SearchDelegate {
  final ApiService apiService = ApiService();

  @override
  List<Widget> buildActions(BuildContext context) {
    // The actions for the search bar (e.g., clear button)
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = ''; // Clear the search query when the icon is pressed
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    // The leading widget (e.g., back button) in the search bar
    return IconButton(
      icon: Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null); // Close the search view
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    // This is where we display the results after the user submits the search query
    return FutureBuilder<List<Product>>(
      future: apiService.fetchProducts(),  // Fetch products from API
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        // Filter the products based on the search query
        final results = snapshot.data?.where((product) {
          return product.title.toLowerCase().contains(query.toLowerCase());
        }).toList() ?? [];

        // Display the results in a list
        return ListView.builder(
          itemCount: results.length,
          itemBuilder: (context, index) {
            final product = results[index];
            return ListTile(
              title: Text(product.title),
              subtitle: Text('\$${product.price.toString()}'),
              onTap: () {
                // Here you can define the action when the user taps on a product
                showProductDetails(product);
              },
            );
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    // This method displays suggestions while the user is typing
    return FutureBuilder<List<Product>>(
      future: apiService.fetchProducts(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        // Filter the suggestions based on the query as the user types
        final suggestions = snapshot.data?.where((product) {
          return product.title.toLowerCase().startsWith(query.toLowerCase());
        }).toList() ?? [];

        return ListView.builder(
          itemCount: suggestions.length,
          itemBuilder: (context, index) {
            final product = suggestions[index];
            return ListTile(
              title: Text(product.title),
              onTap: () {
                query = product.title;
                showResults(context); // Show full results when the suggestion is tapped
              },
            );
          },
        );
      },
    );
  }

  void showProductDetails(Product product) {
    // Implement the navigation logic to show product details
    // For example, you could navigate to a product detail page:
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(builder: (context) => ProductDetailPage(product: product)),
    // );
  }
}
