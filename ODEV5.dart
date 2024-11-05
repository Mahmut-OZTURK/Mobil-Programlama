import 'package:flutter/material.dart';

void main() => runApp(const ProductApp());

class ProductApp extends StatefulWidget {
  const ProductApp({super.key});

  @override
  _ProductAppState createState() => _ProductAppState();
}

class _ProductAppState extends State<ProductApp> {
  bool isDarkTheme = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: isDarkTheme ? _darkTheme : _lightTheme,
      home: ProductPage(
        onThemeToggle: () {
          setState(() {
            isDarkTheme = !isDarkTheme;
          });
        },
      ),
    );
  }

  final ThemeData _lightTheme = ThemeData(
    primarySwatch: Colors.deepPurple,
    brightness: Brightness.light,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.deepPurple,
    ),
    buttonTheme: const ButtonThemeData(
      buttonColor: Colors.deepPurple,
      textTheme: ButtonTextTheme.primary,
    ),
  );

  final ThemeData _darkTheme = ThemeData(
    primarySwatch: Colors.deepPurple,
    brightness: Brightness.dark,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.black87,
    ),
    buttonTheme: const ButtonThemeData(
      buttonColor: Colors.deepPurple,
      textTheme: ButtonTextTheme.primary,
    ),
  );
}

class ProductPage extends StatefulWidget {
  final VoidCallback onThemeToggle;

  const ProductPage({required this.onThemeToggle, super.key});

  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final List<Map<String, dynamic>> products = [
    {'name': 'Laptop', 'price': 1200},
    {'name': 'Phone', 'price': 800},
    {'name': 'Headphones', 'price': 150},
    {'name': 'Camera', 'price': 600},
    {'name': 'Keyboard', 'price': 70},
    {'name': 'Mouse', 'price': 40},
  ];

  String? selectedProductName;

  @override
  Widget build(BuildContext context) {
    Color containerColor = Theme.of(context).brightness == Brightness.dark
        ? Colors.grey[800]!
        : Colors.grey[300]!;
    Color selectedContainerColor = Theme.of(context).brightness == Brightness.dark
        ? Colors.deepPurple[700]!
        : Colors.deepPurple[200]!;

    return Scaffold(
      appBar: AppBar(
        title: const Text("                  Product Selection"),
        actions: [
          IconButton(
            icon: Icon(
              Theme.of(context).brightness == Brightness.dark
                  ? Icons.light_mode
                  : Icons.dark_mode,
            ),
            onPressed: widget.onThemeToggle,
          ),
        ],
      ),
      body: Column(
        children: [
          // Horizontal ListView for product names
          SizedBox(
            height: 70,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedProductName = product['name'];
                    });
                  },
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 3, vertical: 12),
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    decoration: BoxDecoration(
                      color: selectedProductName == product['name']
                          ? selectedContainerColor
                          : containerColor,
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Center(
                      child: Text(
                        product['name'],
                        style: TextStyle(
                          color: selectedProductName == product['name']
                              ? Colors.white
                              : Colors.black87,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          // Expanded GridView for product details
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(10),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 3 / 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
              ),
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                bool isSelected = selectedProductName == product['name'];
                return Container(
                  decoration: BoxDecoration(
                    color: isSelected ? selectedContainerColor : containerColor,
                    border: Border.all(
                      color: isSelected
                          ? Theme.of(context).primaryColor
                          : Colors.grey,
                      width: 2,
                    ),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  padding: const EdgeInsets.all(12),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        product['name'],
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: isSelected
                              ? Colors.white
                              : Theme.of(context).textTheme.bodyLarge!.color,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "\$${product['price']}",
                        style: TextStyle(
                          fontSize: 16,
                          color: isSelected
                              ? Colors.white70
                              : Theme.of(context).textTheme.bodyMedium!.color,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
