import 'dart:convert';
import 'package:http/http.dart' as http;

Future<void> searchIngredients(List<String> ingredients) async {
  final String apiUrl = 'https://world.openfoodfacts.org/cgi/search.pl';

  for (final ingredient in ingredients) {
    final Map<String, String> params = {
      'action': 'process',
      'json': '1',
      'search_terms': ingredient,
    };

    final Uri uri = Uri.parse(apiUrl).replace(queryParameters: params);

    final http.Response response = await http.get(uri);

    if (response.statusCode == 200) {
      // Parse the JSON response
      final Map<String, dynamic> data = json.decode(response.body);

      // Access the product information from the response
      final products = data['products'];
      if (products != null && products is List && products.isNotEmpty) {
        final firstProduct = products[0];
        // Access product details as needed
        print('Ingredient: $ingredient');
        print('Product Name: ${firstProduct['product_name']}');
        print('Ingredients: ${firstProduct['ingredients_text']}');
        Map<String, dynamic> ecoscore = firstProduct['ecoscore_data'];
        Map<String, dynamic> agribalyse = ecoscore['agribalyse'];
        final co2Score = agribalyse['co2_agriculture']; 
        print('Co2 agricultur, $co2Score '); 
        // Add more fields as needed
      } else {
        print('No product found for the ingredient: $ingredient');
      }
    } else {
      print('Error: ${response.statusCode}');
    }
  }
}
