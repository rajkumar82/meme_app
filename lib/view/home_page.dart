import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:meme_app/model/meme_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var backgroundImageUrl = 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTuRIblpZjIBg4QM-4MyKPN1MV2PXv2Wc9tbQ&usqp=CAU';
  var memeImageUrl = 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSYBMboChVnEKnNFnGh54ijKuu_BjbEZCUn3Q&usqp=CAU';

  var isLoading = false;

  final memeApiUrl = 'https://programming-memes-images.p.rapidapi.com/v1/memes';
  final memeApiHeaders = {
    'X-RapidAPI-Key': 'b396080d4bmsh95c5a42f117ae03p15b135jsnc62f0b3ce073',
    'X-RapidAPI-Host': 'programming-memes-images.p.rapidapi.com',
  };

  var currentMemes = <Meme>[];
  var currentItemIndex = -1;

  Meme? currentMeme;

  Future<Meme?> getNextMeme() async {
    currentItemIndex++;
    if (currentMemes.length > currentItemIndex) {
      return currentMemes[currentItemIndex];
    } else {
      currentItemIndex = -1;
      await callApiAndGetMemesList();
      return getNextMeme();
    }
  }

  //Call API and get a list of memes
  Future callApiAndGetMemesList() async {
    var dio = Dio();
    var response = await dio.get(memeApiUrl, options: Options(headers: memeApiHeaders));
    if (response.statusCode == 200) {
      //clear current memes
      currentMemes.clear();

      var memesJson = response.data;
      for (var memeJson in memesJson) {
        var memObj = Meme.fromJson(memeJson);

        //add to currentMemes
        currentMemes.add(memObj);
      }
    } else {
      debugPrint('Error ');
    }
  }

  void setLoading(bool image) {
    setState(() {
      isLoading = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: BoxDecoration(image: DecorationImage(image: NetworkImage(backgroundImageUrl), fit: BoxFit.fitHeight)),
      child: Stack(
        children: [
          GestureDetector(
            onTap: () async {
              setLoading(true);
              currentMeme = await getNextMeme();
              setLoading(false);
            },
            child: Center(
              child: currentMeme == null
                  ? Image.network(memeImageUrl)
                  : Image(
                      image: NetworkImage(currentMeme!.image!),
                    ),
            ),
          )
        ],
      ),
    ));
  }
}
