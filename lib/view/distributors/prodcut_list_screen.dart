import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:testsgprojukti/services/network/http_requests.dart';
import '../../config/api_routes.dart';
import '../../global_widgets/own_title_app_bar.dart';
import '../product_page.dart';

class ProductListScreen extends StatefulWidget {

  static String routeName = '/';
  const ProductListScreen({super.key, required this.data, required this.category});
  final Map<String, dynamic> data;
  final String category;

  @override
  State<ProductListScreen> createState() => _ProductListScreenState();
}

class _ProductListScreenState extends State<ProductListScreen> {

  bool isLoading = false;
  List productList = [];

  @override
  void initState() {
    // TODO: implement initState
    fetchCategory();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor:  Colors.white12,
      appBar: const OwnTitleAppBar(
        title: "Product List",
      ),
      body: Builder(
        builder: (context) {

          if(isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          return ListView.separated(
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Image.network("${productList[index]['images']}"),
                  title: Text("${productList[index]['name']}"),
                  onTap: () {
                    Get.to(ProductDetailsPage(slug: "${productList[index]['slug']}",));
                  },
                );
              },
              separatorBuilder: (context, index) {
                return const Gap(5);
              },
              itemCount: productList.length
          );
        }
      ),
    );
  }

  void fetchCategory() async {
    enableLoading();
    var result = await HttpRequests.get(ApiRoutes.getProductList(widget.category, widget.data['slug']));
    print("the fetch result: $result");
    if(result['data'] is List) {
      disableLoading();
      return;
    }
    productList = result['data']['data'];
    disableLoading();
  }

  enableLoading() => setState(() => isLoading = true);

  disableLoading() => setState(() => isLoading = false);

}
