import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:flutter_html/flutter_html.dart';
import '../config/api_routes.dart';
import '../services/network/http_requests.dart';
import 'custom_product_details.dart';

class ProductDetailsPage extends StatefulWidget {
  const ProductDetailsPage({Key? key, required this.slug}) : super(key: key);
  final String slug;

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  ScrollController? _scrollController;
  int _selectedImageIndex = 0;

  List imageAssets = [];
  bool isLoading = false;
  List groupList = [];
  Map<String, dynamic> productVariant = {};

  @override
  void initState() {
    fetchCategory();
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
    return Scaffold(
      backgroundColor: Color(0xff191F39),
      appBar: AppBar(
        backgroundColor: Color(0xff191F39),
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_back_ios, color: Colors.white),
        ),
        title: Text(
          "Product Details",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Builder(
        builder: (context) {
          if(isLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
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
                            imageAssets[_selectedImageIndex],
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
                          itemCount: imageAssets.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  _selectedImageIndex = index;
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
                                  child: Image.network(
                                    imageAssets[index],
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
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "${productVariant['name']}",
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 2,
                        ),
                        Text(
                          "Price: ${productVariant['selling_price']}",
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                        SizedBox(height: 30,),

                        ElevatedButton(
                          onPressed: () {

                          },
                          child: Text('Add to Cart', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),
                          style: ButtonStyle(
                            backgroundColor: MaterialStateProperty.all<Color>(Color(0xff191F39)),
                          ),
                        ),
                        Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: '\nDescription: ',
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                              ),
                            ],
                          ),
                          overflow: TextOverflow.ellipsis,
                          maxLines: 100,
                        ),
                              
                        Html(data: productVariant['meta']['short_description'],),

                        Gap(20),
                        Text("Specification",style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                        Html(data: productVariant['meta']['description'],)
                              
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        }
      ),
    );
  }

  void fetchCategory() async {
    enableLoading();
    var result = await HttpRequests.get(ApiRoutes.getProductVariant(widget.slug));
    productVariant = result['data']['variant_list'][0];
    imageAssets = productVariant['images'];

    print("productVariant: $productVariant");
    print("imageAssets: $imageAssets");
    disableLoading();
  }

  enableLoading() => setState(() => isLoading = true);

  disableLoading() => setState(() => isLoading = false);
}
