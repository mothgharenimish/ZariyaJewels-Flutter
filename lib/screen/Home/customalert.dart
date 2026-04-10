import 'package:flutter/material.dart';

class Customalert extends StatefulWidget {
  const Customalert({super.key});

  @override
  State<Customalert> createState() => _CustomalertState();
}

class _CustomalertState extends State<Customalert> {
  @override
  Widget build(BuildContext context) {
    return  Container(
      child: Column(
        children: [
          Text("Search with a Photo",style: TextStyle(fontSize: 13,fontWeight: FontWeight.w400,color: Colors.black),),

          Text("Upload a photo and search the Similar Jewellery Products",style: TextStyle(fontSize: 10,fontWeight: FontWeight.w300,color: Colors.grey),),

        Container(
          child: Row(
            children: [
              Image.asset("assets/images/icons8-image-48.png",
                height: 30,
                width: 30,
              ),
              Text("Choose from gallery",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w700,color: Colors.white),),

              Image.asset("assets/images/icons8-arrow-50.png",
                height: 26,
                width: 26,
              ),


            ],
          ),
        )

        ],
      ),
    );
  }
}
