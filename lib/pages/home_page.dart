import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:joistic_assignment/controller/home_controller.dart';
import 'package:joistic_assignment/pages/search_page.dart';
import 'package:joistic_assignment/widgets/company_details_view.dart';
import 'package:joistic_assignment/widgets/company_view.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      init: HomeController(),
      builder: (v) => Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          leading: const Icon(Icons.menu),
          title: const Text(
            'Dashboard',
            style: TextStyle(
              color: Colors.white,
              fontSize: 24,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {
                Get.to(() => const SearchPage());
              },
              icon: const Icon(
                Icons.search,
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            SizedBox(
              height: 40,
              width: 40,
              child: v.photoUrl == null
                  ? const Icon(Icons.person)
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(50),
                      child: CachedNetworkImage(
                        imageUrl: v.photoUrl!,
                        imageBuilder: (context, imageProvider) => Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: imageProvider,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        placeholder: (context, url) =>
                            const CircularProgressIndicator(),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ),
                    ),
            ),
            const SizedBox(
              width: 5,
            )
          ],
        ),
        body: SizedBox(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 20),
                child: Text(
                  'Welcome ${v.name ?? 'User'}',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              const Padding(
                padding: EdgeInsets.only(left: 15, right: 20),
                child: Text(
                  'Find your Dream\nJob today',
                  style: TextStyle(
                    fontSize: 50,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              if (v.isLoading) ...[
                const SizedBox(
                  height: 150,
                ),
                const Center(
                  child: CircularProgressIndicator(),
                ),
              ],
              if (v.companyList.isNotEmpty)
                Expanded(
                  child: ListView.builder(
                    itemCount: v.companyList.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      final company = v.companyList[index];
                      return InkWell(
                        onTap: () {
                          //Show dialog with getx
                          Get.bottomSheet(
                            CompanyDetailsView(
                              data: company,
                            ),
                          );
                        },
                        child: CompanyView(
                          data: company,
                        ),
                      );
                    },
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
