import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:joistic_assignment/model/company_model.dart';
import 'package:joistic_assignment/utils/utils.dart';

class CompanyDetailsView extends StatefulWidget {
  const CompanyDetailsView({super.key, required this.data});

  final CompanyModel data;

  @override
  State<CompanyDetailsView> createState() => _CompanyDetailsViewState();
}

class _CompanyDetailsViewState extends State<CompanyDetailsView> {
  bool isApplied = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 20,
      ),
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10),
            topRight: Radius.circular(10),
          ),
          color: Colors.white),
      width: double.infinity,
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              //Company Logo
              SizedBox(
                height: 60,
                width: 60,
                child: widget.data.thumbnailUrl == null
                    ? const Icon(Icons.home_work_outlined)
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: CachedNetworkImage(
                          imageUrl: widget.data.thumbnailUrl ?? '',
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
                          errorWidget: (context, url, error) => const Icon(
                            Icons.home_work_outlined,
                          ),
                        ),
                      ),
              ),
              const SizedBox(
                height: 15,
              ),
              Text(
                Utils().getFirstTwoWords(
                  widget.data.title ?? '',
                ),
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              const Text(
                'United kingdom, London',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Designation',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              const Text(
                'Senior UI/UX Designer',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'Job Description',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              const Expanded(
                child: SingleChildScrollView(
                  child: Text(
                    Utils.jobDescription,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Container(
            margin: const EdgeInsets.only(bottom: 10),
            height: 40,
            width: 300,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)),
                  elevation: 5,
                  backgroundColor:
                      isApplied ? Colors.green : const Color(0xFF645efc)),
              onPressed: isApplied == true
                  ? () {}
                  : () {
                      setState(() {
                        if (isApplied == false) isApplied = true;
                        Get.showSnackbar(
                          const GetSnackBar(
                            duration: Duration(seconds: 2),
                            messageText: Text(
                              'Job Applied Successfully',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        );
                      });
                    },
              child: Center(
                child: Text(
                  isApplied == false ? "Apply Now" : "Applied",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
