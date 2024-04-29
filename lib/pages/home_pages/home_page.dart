import 'package:flutter/material.dart';

import '../../common_method/custom_category_cart.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text("Category's"),
      ),

      body: SingleChildScrollView(
        child: Column(
          children: List.generate(
            ((6 / 3).ceil()), // Calculate the number of rows needed
                (rowIndex) {
              return Row(
                children: List.generate(
                  (rowIndex == 0 ? 3 : 3), // Set 2 items for the first row, and 3 items for subsequent rows
                      (columnIndex) {
                    return Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: CustomCategoryCart(),
                    );
                  },
                ),
              );
            },
          ),
        ),
      ),


    );
  }
}
