import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:zariyajewllery/model/jewllerydata_model.dart';
import 'package:zariyajewllery/screen/Home/categorycard.dart';
import 'package:zariyajewllery/screen/Home/customalert.dart';
import 'package:zariyajewllery/screen/Home/jewellerycard.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController _searchController = TextEditingController();


  final dio = Dio();


  @override
  void initState() {
    super.initState();

    getHttp();

  }

  List<Datum> jewelleryList = [];
  List<String> categoryList = [];
  String selectedCategory = "All";

  Future<void> getHttp() async {
    try {
      final response = await dio.get(
        'http://192.168.1.6:8080/myproject/JewelleryPAPI/fetch_jewellery.php',
      );

      print(response);

      JewelleryData model = JewelleryData.fromJson(response.data);

      print("Status: ${model.status}");
      print("Total items: ${model.data.length}");
      print("The model is: $model");

      setState(() {
        jewelleryList = model.data;
        categoryList = jewelleryList
            .map((item) => item.jewllerycategory.trim())
            .toSet()
            .toList();

        categoryList.insert(0, "All");

        print("Duplicate remove from the category List");
        print(categoryList);
      });

      print(jewelleryList[0].jewlleryname);
    } catch (e) {
      print("API Error: $e");
    }
  }


  List<Datum> searchcode(List<Datum> list) {
    if (_searchController.text.trim().isEmpty) {
      return list;
    }

    return list.where((item) {
      return item.jewlleryname
          .toLowerCase()
          .contains(_searchController.text.toLowerCase());
    }).toList();
  }



  @override
  Widget build(BuildContext context) {

    List<Datum> filteredList = selectedCategory == "All"
        ? jewelleryList
        : jewelleryList.where((item) =>
    item.jewllerycategory.trim() == selectedCategory).toList();

    List<Datum> finalList = searchcode(filteredList);

    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 0,left: 0),
              child: Container(
                padding: const EdgeInsets.only(left: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.white.withValues(alpha: 0.08),
                      blurRadius: 8,
                      spreadRadius: 1,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Image.asset(
                      "assets/images/Frame 6.png",
                      height: 45,
                      width: 45,
                    ),
                    const SizedBox(width: 5),
                    const Text(
                      "ZARIYA JEWELS",
                      style: TextStyle(
                        fontFamily: "Lora",
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const Spacer(),

                    Container(
                      padding: const EdgeInsets.only(right:  16),
                      child: Row(
                        children: [
                            CircleAvatar(
                              radius: 18,
                              backgroundColor: const Color(0xFF000000).withValues(alpha: 0.10),
                              child: Image.asset(
                                "assets/images/material-symbols-light_favorite-outline.png",
                                height: 26 ,
                                width: 26,
                              ),
                            ),
                          SizedBox(width: 4),
                          CircleAvatar(
                            radius: 18,
                            backgroundColor: const Color(0xFF000000).withValues(alpha: 0.10),
                            child: Image.asset(
                              "assets/images/mingcute_notification-line.png",
                              height: 26 ,
                              width: 26,
                            ),
                          ),
                          SizedBox(width: 4),
                          InkWell(
                            onTap: () {
                              print("Click on the Scanner");
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return Dialog(
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Customalert(onGalleryClick: onGalleryClick, onCameraClick: onCameraClick),

                                  );
                                },
                              );
                            },
                            child: CircleAvatar(
                              radius: 18,
                              backgroundColor: const Color(0xFF000000).withValues(alpha: 0.10),
                              child: Image.asset(
                                "assets/images/iconamoon_scanner-light.png",
                                height: 26 ,
                                width: 26,
                              ),
                            ),
                          ),
                        ],
                      ) ,
                    )
                  ],
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(top: 38,left: 16,right: 40),
              child: RichText(
                text: TextSpan(
                  style: const TextStyle(
                    fontSize: 32,
                    fontFamily: "Lora",
                    fontWeight: FontWeight.w500,
                  ),
                  children: [
                    TextSpan(
                      text: "The Art of ",
                      style: TextStyle(
                        color: Colors.black,
                      ),
                    ),
                    TextSpan(
                      text: "Exceptional Jewelry",
                      style: TextStyle(
                        color: Colors.brown,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Padding(
              padding: const EdgeInsets.only(top: 19,left: 16,right: 16),
              child: Container(
                height: 50,
                width: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Colors.black.withValues(alpha: 0.20),
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Padding(
                  padding: const EdgeInsets.only(left: 8,right: 8),
                  child: Row(
                    children: [
                      Image.asset("assets/images/line-md_search.png",
                        height: 24,
                        width: 24,
                      ),
                      const SizedBox(width: 8),
                       Expanded(
                         child: TextFormField(
                           controller: _searchController,
                           onChanged: (value) {
                             setState(() {

                             });
                           },
                           keyboardType: TextInputType.name,
                           decoration: InputDecoration(
                             hintText: "Search Jewllery Products",
                             hintStyle: TextStyle(color: Colors.grey),
                             border: InputBorder.none,
                             contentPadding: EdgeInsets.symmetric(vertical: 14),
                           ),
                         ),
                       ),

                      Image.asset("assets/images/icon-park-outline_voice.png",
                        height: 24,
                        width: 24,
                      ),

                    ],
                  ),
                ),

              ),
            ),

            Padding(
              padding: const EdgeInsets.only(top: 25,left: 16,right: 16),
              child: SizedBox(
                height: 50,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: categoryList.length,
                  itemBuilder: (context, index) {
                    final category = categoryList[index];
                    print("The category is $category");
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: GestureDetector(
                        onTap: (){
                          setState(() {
                            selectedCategory = category;
                          });
                        },
                        child: Categorycard(
                          category: categoryList[index],
                          isSelected: selectedCategory == category,
                        ),
                      ),
                    );
                  },
                ),
              )
            ),
            SizedBox(height: 15),
            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: finalList.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 0.72,
                ),
                itemBuilder: (context, index) {
                  return JewelleryCard(
                    item: finalList[index],
                  );
                },
              ),
            )

          ],
        ),
      ),
    );
  }
}