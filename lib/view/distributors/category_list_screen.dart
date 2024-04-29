import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:testsgprojukti/view/distributors/prodcut_list_screen.dart';
import '../../global_widgets/own_title_app_bar.dart';

class CategoryListScreen extends StatefulWidget {

  static String routeName = '/';
  const CategoryListScreen({super.key, required this.categoryList});
  final List categoryList;

  @override
  State<CategoryListScreen> createState() => _CategoryListScreenState();
}

class _CategoryListScreenState extends State<CategoryListScreen> {

  bool isLoading = false;
  List? subCategoryList;
  String categorySlug = '';

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {

        if(subCategoryList == null) {
          return Future(() => true);
        }
        subCategoryList=null;
        setState(() {

        });
        return Future(() => false);
      },
      child: Scaffold(
        // backgroundColor:  Colors.white12,
        appBar: const OwnTitleAppBar(
          title: "Category List",
        ),
        body: Builder(
          builder: (context) {

            if(subCategoryList != null && widget.categoryList.isNotEmpty) {

              if(subCategoryList!.isEmpty) {
                return Center(
                  child: Text(
                   "No sub category found"
                  )
                );
              }

              return ListView.separated(
                  itemBuilder: (context, index) {
                    return ListTile(
                      leading: subCategoryList![index]['logo'] != null ? Image.network("${subCategoryList![index]['logo']}") : Icon(Icons.category),
                      title: Text("${subCategoryList![index]['name']}"),
                      onTap: () {
                        Get.to(ProductListScreen(data: subCategoryList![index], category: categorySlug,));
                      },
                    );
                  },
                  separatorBuilder: (context, index) {
                    return const Gap(5);
                  },
                  itemCount: subCategoryList!.length
              );
            }

            return ListView.separated(
                itemBuilder: (context, index) {
                  return ListTile(
                    leading: Image.network("${widget.categoryList[index]['logo']}"),
                    title: Text("${widget.categoryList[index]['name']}"),
                    onTap: () {
                      subCategoryList = widget.categoryList[index]['subcategories'];
                      categorySlug = widget.categoryList[index]['slug'] ?? '';
                      setState(() {

                      });
                    },
                  );
                },
                separatorBuilder: (context, index) {
                  return const Gap(5);
                },
                itemCount: widget.categoryList.length
            );
          }
        ),
      ),
    );
  }


  enableLoading() => setState(() => isLoading = true);

  disableLoading() => setState(() => isLoading = false);

}
