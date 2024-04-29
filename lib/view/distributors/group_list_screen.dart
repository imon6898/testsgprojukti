import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:get/get.dart';
import 'package:testsgprojukti/services/network/http_requests.dart';
import 'package:testsgprojukti/view/distributors/category_list_screen.dart';
import 'package:testsgprojukti/view/distributors/prodcut_list_screen.dart';
import '../../config/api_routes.dart';
import '../../global_widgets/own_title_app_bar.dart';

class GroupListScreen extends StatefulWidget {

  static String routeName = '/';
  const GroupListScreen({super.key});

  @override
  State<GroupListScreen> createState() => _GroupListScreenState();
}

class _GroupListScreenState extends State<GroupListScreen> {

  bool isLoading = false;
  List groupList = [];

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
        title: "Group List",
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
                  // leading: Image.network("${groupList[index]['logo']}"),
                  title: Text("${groupList[index]['name']}"),
                  onTap: () {
                    Get.to(CategoryListScreen(categoryList: groupList[index]['categories']));
                  },
                );
              },
              separatorBuilder: (context, index) {
                return const Gap(5);
              },
              itemCount: groupList.length
          );
        }
      ),
    );
  }

  void fetchCategory() async {
    enableLoading();
    var result = await HttpRequests.get(ApiRoutes.getProductGroups);
    groupList = result['data'];
    disableLoading();
  }

  enableLoading() => setState(() => isLoading = true);

  disableLoading() => setState(() => isLoading = false);

}
