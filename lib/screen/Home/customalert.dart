import 'package:flutter/material.dart';

class Customalert extends StatefulWidget {

  final VoidCallback onGalleryClick;
  final VoidCallback onCameraClick;
const Customalert({super.key, required this.onGalleryClick, required this.onCameraClick});

  @override
  State<Customalert> createState() => _CustomalertState();
}

class _CustomalertState extends State<Customalert> {
  @override
  Widget build(BuildContext context) {
    return  Container(
      height: 240,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),

      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top:10,left: 20,right: 20),
            child: Text("Search with a Photo",style: TextStyle(fontSize: 18,fontWeight: FontWeight.w500,color: Colors.black),),
          ),

          Padding(
            padding: const EdgeInsets.only(top: 5,left: 20,right: 20,bottom: 10),
            child: Text("Upload a photo and search the Similar Jewellery Products",style: TextStyle(fontSize: 15,fontWeight: FontWeight.w600,color: Colors.grey),),
          ),

        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: InkWell(
            onTap: widget.onGalleryClick,
            child: Container(
              height: 60,
              decoration: BoxDecoration(
                color: Color(0xFF228B22),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Image.asset("assets/images/icons8-image-48 (1).png",
                      height: 30,
                      width: 30,
                    ),
                  ),
                  SizedBox(width: 5,),
                  Text("Choose from gallery",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w700,color: Colors.white),),
                  Spacer(),
                  Padding(
                    padding: const EdgeInsets.only(right: 10),
                    child: Image.asset("assets/images/icons8-arrow-50.png",
                      height: 22,
                      width: 22,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),

          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: InkWell(
              onTap: widget.onCameraClick,
              child: Container(
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color: Colors.grey,
                    width: 2
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Image.asset("assets/images/icons8-camera-48.png",
                        height: 30,
                        width: 30,
                      ),
                    ),
                    SizedBox(width: 5,),
                    Text("Click a Photo",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w700,color: Colors.black),),
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Image.asset("assets/images/icons8-arrow-50 (1).png",
                        height: 22,
                        width: 22,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )


        ],
      ),
    );
  }
}
