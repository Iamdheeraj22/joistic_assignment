import 'dart:convert' as convert;
import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:joistic_assignment/model/company_model.dart';
import 'package:joistic_assignment/storage/storage_service.dart';
import 'package:joistic_assignment/utils/keys.dart';

class HomeController extends GetxController {
  final StorageService _storageService = Get.find<StorageService>();
  String? name;
  String? email;
  String? photoUrl;
  List<CompanyModel> companyList = [];
  List<CompanyModel> searchCompanyList = [];
  bool isLoading = false;
  @override
  void onInit() {
    super.onInit();
    readUser();
    getCompanyList();
  }

  void readUser() {
    name = _storageService.read(Keys.name);
    email = _storageService.read(Keys.email);
    photoUrl = _storageService.read(Keys.photoUrl);
    update();
  }

  Future<void> getCompanyList() async {
    var url = Uri.https('jsonplaceholder.typicode.com', '/albums/1/photos');
    isLoading = true;
    update();
    // Await the http get response, then decode the json-formatted response.
    try {
      var response = await http.get(url);
      if (response.statusCode == 200) {
        var jsonResponse = convert.jsonDecode(response.body) as List<dynamic>;
        companyList.addAll(jsonResponse
            .map((item) => CompanyModel.fromJson(item as Map<String, dynamic>))
            .toList());
        log('Number of company: ${companyList.length}');
        isLoading = false;
        update();
      } else {
        isLoading = false;
        log('Request failed with status: ${response.statusCode}.');
        update();
      }
    } catch (e) {
      isLoading = false;
      update();
      log('Request failed with status: ${e.toString()}');
    }
  }

  TextEditingController searchController = TextEditingController();

  ///Search company by title
  void searchCompany(String title) {
    searchCompanyList = companyList
        .where((element) =>
            element.title!.toLowerCase().contains(title.toLowerCase()))
        .toList();
    update();
  }
}
