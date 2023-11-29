import 'dart:convert';
import 'package:http/http.dart' as http;

Future<void> searchProductByName(String productName, {String language = 'en'}) async {
  final String apiUrl = 'https://world.openfoodfacts.org/cgi/search.pl';

  // You can customize the parameters based on your needs
  final Map<String, String> params = {
    'action': 'process',
    'json': '1',
    'search_terms': productName,
    'lang': language, // Set the language parameter
  };

  final Uri uri = Uri.parse(apiUrl).replace(queryParameters: params);

  final http.Response response = await http.get(uri);

  if (response.statusCode == 200) {
    // Parse the JSON response
    final Map<String, dynamic> data = json.decode(response.body);

    // Access the product information from the response
    // The structure may vary, so check the API documentation for details
    final products = data['products'];
    if (products != null && products is List && products.isNotEmpty) {
      final firstProduct = products[0];
      // Access product details as needed
      print('Product Name: ${firstProduct['product_name']}');
      print('Ingredients: ${firstProduct['ingredients_text']}');
      Map<String, dynamic> ecoscore = firstProduct['ecoscore_data'];
      // Accessing data within adjustments
      Map<String, dynamic> adjustments = ecoscore['adjustments'];
      Map<String, dynamic> originsOfIngredients = adjustments['origins_of_ingredients'];

      // Accessing data within agribalyse
      Map<String, dynamic> agribalyse = ecoscore['agribalyse'];

      if (ecoscore != null) {
        final co2Score = ecoscore['grade'];
        double co2Agriculture = agribalyse['co2_agriculture'];
        print('CO2 Agriculture: $co2Agriculture');
        print('CO2 Score: $co2Score');
      } else {
        print('CO2 Score not available for this product.');
      }
    } else {
      print('No product found for the given name.');
    }
  } else {
    print('Error: ${response.statusCode}');
  }
}
