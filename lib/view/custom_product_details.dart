import 'package:flutter/material.dart';

class CustomProductDetails extends StatefulWidget {
  final String? productName;
  final String? discountPrice;
  final String? orginalPrice;
  final String? description;
  final String? imageUrl; // New parameter for product image URL
  final VoidCallback? onPressed; // New parameter for onPressed function

  const CustomProductDetails({
    Key? key,
    this.productName,
    this.discountPrice,
    this.orginalPrice,
    this.description,
    this.imageUrl, // New parameter for product image URL
    this.onPressed, // New parameter for onPressed function
  }) : super(key: key);

  @override
  State<CustomProductDetails> createState() => _CustomProductDetailsState();
}

class _CustomProductDetailsState extends State<CustomProductDetails> {
  ScrollController? _scrollController;
  int _selectedImageIndex = 0;

  List<String> imageAssets = [
    'assets/logo.png',
    'assets/logo1.png',
  ];

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController?.dispose();
    super.dispose();
  }

  void _scrollToTop() {
    _scrollController!.animateTo(
      0.0,
      duration: Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  void _scrollToBottom() {
    _scrollController!.animateTo(
      _scrollController!.position.maxScrollExtent,
      duration: Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Column(
      children: [
        Container(
          height: screenHeight * 0.4,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  height: 300,
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Image.network( // Using Image.network to load image from URL
                      widget.imageUrl ?? imageAssets[_selectedImageIndex],
                      height: 400,
                      width: MediaQuery.of(context).size.width,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10),
                child: SizedBox(
                  height: 270,
                  width: 70,
                  child: ListView.builder(
                    controller: _scrollController,
                    scrollDirection: Axis.vertical,
                    itemCount: 20,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedImageIndex = index % imageAssets.length;
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                          child: Container(
                            width: 30,
                            height: 60,
                            color: _selectedImageIndex == index % imageAssets.length
                                ? Colors.white
                                : Colors.white24,
                            padding: const EdgeInsets.all(10.0),
                            child: Image.asset(
                              imageAssets[index % imageAssets.length],
                              height: 60,
                              width: 20,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              )
            ],
          ),
        ),
        Expanded(
          child: Container(
            padding: EdgeInsets.all(10),
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(topRight: Radius.circular(80)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  widget.productName ?? "Product Name",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: "Price :",
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      TextSpan(
                        text: widget.discountPrice ?? "1000",
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, decoration: TextDecoration.lineThrough),
                      ),
                    ],
                  ),
                ),
                Text(
                  "Price: ${widget.orginalPrice ?? "800"}",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: 'Description: ',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      TextSpan(
                        text: widget.description ?? "asdfghjkl",
                        style: TextStyle(fontSize: 18),
                      ),
                    ],
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 100,
                ),

                SizedBox(height: 50,),

                ElevatedButton(
                  onPressed: widget.onPressed,
                  child: Text('Add to Cart', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Color(0xff191F39)),
                  ),
                ),

              ],
            ),
          ),
        ),
      ],
    );
  }
}
