import 'package:flutter/material.dart';
import 'home/home_screen/home_page.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class Firstscreen extends StatefulWidget {
  const Firstscreen({super.key});

  @override
  State<Firstscreen> createState() => _FirstscreenState();
}

class _FirstscreenState extends State<Firstscreen> {


ImagePicker imagePicker = ImagePicker();

List <File> ? selectedImage = [];

Future <void> imageSelector() async {
List <XFile> ? images = await imagePicker.pickMultiImage();

if(images != null && mounted) {

setState(() {
  selectedImage!.addAll(images.map((toElement) => File(toElement!.path)).toList());
});
}

}


  TextEditingController title = TextEditingController();

  TextEditingController body = TextEditingController();

  @override
  void dispose() {
    title.dispose();
    body.dispose();
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        decoration: BoxDecoration(  
          image: DecorationImage(
             fit: BoxFit.cover,
            image: AssetImage('assets/background.jpg'))
        ),
        child: ListView(
          children: [
            SizedBox(height: 30,),
            
          Row(
            children: [
              SizedBox(
                height: 100,
                child: selectedImage!.isEmpty ?  Container(
                    
                    color: Colors.white38,
                    height: 150,
                    width: MediaQuery.sizeOf(context).width-20,
                     child: IconButton(onPressed: (){
                      imageSelector();
                     }, icon: Icon(Icons.camera_alt)),) : 
                     Row(
                       children: [
Container(
                    
                    color: Colors.white38,
                    height: 100,
                    width: MediaQuery.sizeOf(context).width-120,
                     child: IconButton(onPressed: (){
                      imageSelector();
                     }, icon: Icon(Icons.camera_alt)),),
                         SizedBox(
                          height: 100,
                           child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: selectedImage!.map((toElement) => Stack(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal : 8.0),
                                  child: Image.file(toElement, height: 100, width: 100, fit: BoxFit.cover,),
                                ),
                                IconButton(onPressed: (){
                                         setState(() {
                                           selectedImage!.removeAt(selectedImage!.indexOf(toElement));
                                         });
                                         
                                }, icon: Icon(Icons.cancel))
                              ],
                            )).toList(),),
                         ),
                       ],
                     ),
              ),
            ],
          ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: title,
                decoration: InputDecoration(
                  hintText: "Title",
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: body,
                minLines: 3,
                maxLines: 7,
                decoration: InputDecoration(
                  hintText: "Body",
                  border: OutlineInputBorder(),
                ),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.save),
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => MyHomePage(
            title: title.text,
            body: body.text,
            image: selectedImage,
          )));
        }),
    );
  }
}
