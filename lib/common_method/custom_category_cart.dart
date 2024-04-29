import 'package:flutter/material.dart';

class CustomCategoryCart extends StatelessWidget {
  const CustomCategoryCart({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      height: 150,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      padding: const EdgeInsets.all(10.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 60,
            padding: const EdgeInsets.all(5.0),
            child: Image.network(
              'https://via.placeholder.com/150',
               // Adjust the height as needed
              fit: BoxFit.cover, // Use BoxFit.cover to ensure the image fits within the container
            ),

          ),
          SizedBox(height: 10), // Adding some space between image and custom container

          Text(
            'Your Text Here',
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }
}

