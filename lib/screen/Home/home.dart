import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image/image.dart' as img;
import 'package:image_picker/image_picker.dart';
import 'package:tflite_flutter/tflite_flutter.dart';
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
  File? image;
  Interpreter? interpreter;
  bool modelloaded = false;
  String result = "No Prediction";
  var dismissed = false;
  List<Datum> finalList = [];

 List<String> classes = [
  "Bangles",
   "bracelet",
   "cushiondiamond",
   "Earings",
   "heartdiamond",
   "necklace",
   "ring"
];


  @override
  void initState() {
    super.initState();

    getHttp();
    loadmodel();
  }

Future loadmodel() async {

    try {

    interpreter = await Interpreter.fromAsset("assets/nasnet_image_classifiers.tflite");

    print("The interpreter is $interpreter");
    print("Model loaded successfully");

    setState(() {
      modelloaded = true;
    });

    } catch(error) {
        print("The error is there $error");
    }
}

  Future getImage(ImageSource source) async {

    if (!modelloaded) {
      print("Model still loading...");
      return;
    }

    if (Navigator.canPop(context)) {
      Navigator.pop(context);
    }

    final pickedImage = await ImagePicker().pickImage(source: source);

    if (pickedImage == null) return;

    final selectedImage = File(pickedImage.path);


    setState(() {
      image = selectedImage;
      print("The image is $image");
      // predictImage(selectedImage);

    });

  var b =   predictImage(selectedImage);
  print("The b is $b");
  }

  List<Datum> jewelleryList = [];
  List<String> categoryList = [];
  String selectedCategory = "All";

  Future<void> getHttp() async {
    try {
      final response = await dio.get(
        'http://192.168.1.5:8080/myproject/JewelleryPAPI/fetch_jewellery.php',
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


  Future predictImage(File file) async {

    if (interpreter == null) {
      print("Model not loaded yet");
      return;
    }

    final imageBytes = await file.readAsBytes();

    img.Image? originalImage = img.decodeImage(imageBytes);

    if (originalImage == null) {
      print("Image decode failed");
      return;
    }

    img.Image resizedImage =
    img.copyResize(originalImage, width: 224, height: 224);

    var input = List.generate(
        1,
            (index) => List.generate(
            224,
                (y) => List.generate(
                224,
                    (x) => List.generate(
                    3,
                        (c) => resizedImage.getPixel(x, y)[c] / 255.0))));

    var output = List.generate(1, (index) => List.filled(classes.length, 0.0));

    interpreter!.run(input, output);

    int predictedIndex = 0;
    double confidence = 0;

    for (int i = 0; i < classes.length; i++) {
      if (output[0][i] > confidence) {
        confidence = output[0][i];
        predictedIndex = i;
      }
    }

    String predictedClass = classes[predictedIndex];
    
    print("The Predication class is $predictedClass");

    setState(() {
      result =
      "$predictedClass \nConfidence: ${(confidence * 100).toStringAsFixed(2)}%";

      print("The result is $result");
    });
    
    findSimilarProducts(predictedClass);
  }

  void findSimilarProducts(String predictedClass) {
    for (var item in jewelleryList) {
      if (item.jewllerycategory.trim().toLowerCase() ==
          predictedClass.toLowerCase()) {
        print("Name: ${item.jewlleryname}");
        print("Category: ${item.jewllerycategory}");
        print("Price: ${item.jewlleryprice}");
        print("Image: ${item.jewllImage}");
      }
    }
  }



  @override
  Widget build(BuildContext context) {

    List<Datum> filteredList = selectedCategory == "All"
        ? jewelleryList
        : jewelleryList.where((item) =>
    item.jewllerycategory.trim() == selectedCategory).toList();

     finalList = searchcode(filteredList);

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
                                    child: Customalert(onGalleryClick: () => getImage(ImageSource.gallery), onCameraClick: () => getImage(ImageSource.camera)),

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