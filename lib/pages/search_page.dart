import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:joistic_assignment/controller/home_controller.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});
  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (v) => SafeArea(
          child: Column(
        children: [
          Row(
            children: [
              IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: const Icon(Icons.arrow_back),
              ),
              SizedBox(
                height: 40,
                width: MediaQuery.sizeOf(context).width - 100,
                child: TextFormField(
                  onChanged: (value) => v.searchCompany(
                    value,
                  ),
                  controller: v.searchController,
                  decoration: InputDecoration(
                      hintText: 'Search company',
                      contentPadding: const EdgeInsets.all(10),
                      border: const OutlineInputBorder(),
                      suffixIcon: IconButton(
                        onPressed: v.searchController.text.trim().isEmpty
                            ? null
                            : () {
                                v.searchController.clear();
                                v.searchCompany('');
                              },
                        icon: Icon(
                          color: v.searchController.text.trim().isEmpty
                              ? Colors.grey
                              : Colors.black,
                          Icons.close,
                        ),
                      )),
                ),
              )
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: v.searchCompanyList.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 5.0, horizontal: 10),
                  child: ListTile(
                    title: Text(v.searchCompanyList[index].title ?? 'Dummy'),
                    subtitle: Text(v.searchCompanyList[index].url ?? 'Dummy'),
                  ),
                );
              },
            ),
          ),
        ],
      )),
    );
  }
}
