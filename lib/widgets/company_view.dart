import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:joistic_assignment/model/company_model.dart';
import 'package:joistic_assignment/utils/utils.dart';

class CompanyView extends StatelessWidget {
  const CompanyView({super.key, required this.data});
  final CompanyModel data;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Card(
        elevation: 5,
        shadowColor: Colors.grey,
        margin: const EdgeInsets.all(10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            children: [
              const SizedBox(
                width: 15,
              ),
              SizedBox(
                height: 50,
                width: 50,
                child: data.thumbnailUrl == null
                    ? const Icon(Icons.home_work_outlined)
                    : ClipRRect(
                        borderRadius: BorderRadius.circular(50),
                        child: CachedNetworkImage(
                          imageUrl: data.thumbnailUrl ?? '',
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
                width: 15,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      Utils().getFirstTwoWords(data.title ?? ''),
                      style: const TextStyle(
                        fontSize: 20,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      data.title ?? '',
                      style: const TextStyle(
                        fontSize: 17,
                        color: Colors.grey,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              Card(
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(500),
                ),
                shadowColor: Colors.blue,
                color: Colors.blue,
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.work,
                    color: Colors.white,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
