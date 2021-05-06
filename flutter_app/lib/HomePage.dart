import 'dart:io';
import 'dart:math';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class HomePage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePage>{

  //String url = "https://www.soundhelix.com/examples/mp3/SoundHelix-Song-4.mp3";
  bool isLoading = false;

  bool downloading = false;
  double download = 0.0;
  double downloadText = 0.0;

  var progress = "";
  String downloadingStr = "";
  var dio = Dio();

  static final Random random = Random();

  List<MyList> documents = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    documents.add(MyList(
        name: 'Learning Android Studio',
      link: 'http://barbra-coco.dyndns.org/student/learning_android_studio.pdf'));

    documents.add(MyList(
        name: 'Android Programming Cookbook',
        link:
        'http://enos.itcollege.ee/~jpoial/allalaadimised/reading/Android-Programming-Cookbook.pdf'));

    documents.add(MyList(
        name: 'iOS Programming Guide',
        link:
        'http://darwinlogic.com/uploads/education/iOS_Programming_Guide.pdf'));

    documents.add(MyList(
        name: 'Objective-C Programming (Pre-Course Workbook',
        link:
        'https://www.bignerdranch.com/documents/objective-c-prereading-assignment.pdf'));
  }


  downloadFromURl(String url)async{
    final status = await Permission.storage.status;
    if (status != PermissionStatus.granted) {
      final requestRes = await Permission.storage.request();
      ;
      if (!requestRes.isGranted) {
        // Toast.show("Please give permission from settings", context,
        //     duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
        await openAppSettings();
        return;
      }
    }
    if (await Permission.storage.request().isGranted) {
      String baseDir = "";
      if (Platform.isAndroid) {
        // baseDir = "/storage/emulated/0";
        baseDir = (await getApplicationDocumentsDirectory()).path;
      } else {
        baseDir = (await getApplicationDocumentsDirectory()).path;
      }

      String dirToBeCreated = "Demo";
      String finalDir = baseDir + "/" + dirToBeCreated;
      //download2(dio,url,);
      var dir = Directory(finalDir);
      bool dirExists = await dir.exists();
      if (!dirExists) {
        dir.create(recursive: true)
        // The created directory is returned as a Future.
            .then((Directory directory) {
          print(directory.path);
        });
        //dir.create(); //pass recursive as true if directory is recursive
      }
      String dirToBeCreatedDocument = "PDF";
      String finalDirDocument =
          finalDir + "/" + dirToBeCreatedDocument;
      var dirDocument = Directory(finalDirDocument);
      bool dirExistsDocument = await dir.exists();
      if (!dirExistsDocument) {
        dirDocument.create(recursive: true)
        // The created directory is returned as a Future.
            .then((Directory directory) {
          print(directory.path);
        });
        //dir.create(); //pass recursive as true if directory is recursive
      }

      Dio dio = Dio();
      String fullPath = "${dirDocument.path}";
      File f = File("${dirDocument.path}");
      String fileName = url.substring(url.lastIndexOf("/") + 1);
      //DateTime now = DateTime.now();
      //String formattedDate = DateFormat('dd_MM_yyyy_kk_mm').format(now);
      download2(dio, url, fullPath + "/" + fileName, context);

    }

  }
  Future download2(
      Dio dio, String url, String fullPath, BuildContext context) async {

    try {

      Response respos = await dio.download(url, fullPath,onReceiveProgress: showDialogProgress,
          options: Options(
              responseType: ResponseType.bytes,
              followRedirects: false,
              validateStatus: (status) {
                return (status!=null)?status < 500:100 < 500;
              }));
      //Open File
      // Response respo = await dio.get(url,
      //     onReceiveProgress: showDialogProgress,
      //     options: Options(
      //         responseType: ResponseType.bytes,
      //         followRedirects: false,
      //         validateStatus: (status) {
      //           return status < 500;
      //         }));
      // File file = File(fullPath);
      // print(fullPath);
      // OpenFile.open(fullPath);
      // var raf = file.openSync(mode: FileMode.write);
      // raf.writeFromSync(respo.data);
      // await raf.close();
      downloading = false;
      setState(() {
      });

      // Toast.show("Download completed", context,
      //     duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
    }
    catch (ex) {
      setState(() {
        downloading = false;
      });
      // Toast.show("Download Not completed, Please try again.", context,
      //     duration: Toast.LENGTH_LONG, gravity: Toast.BOTTOM);
      print(ex);
    }
  }
  void showDialogProgress(int count, int total) {
    if (total != -1) {
      //ShowDialog();
      setState(() {
        downloading = true;
        int progres = (((count / total) * 100).toInt());
        progress = ((count / total) * 100).toStringAsFixed(0);
        download = (int.parse(progress) / 100);
        downloadingStr = (count / total * 100).toStringAsFixed(0) + "%";
      });
      print((count / total * 100).toStringAsFixed(0) + "%");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: documents.length,
          itemBuilder: (context, index) {
            return Card(
              child: ListTile(
                onTap: (){
                  downloadFromURl(documents[index].link.toString());
                },
                title: Text(documents[index].name.toString()),
                trailing:Icon(Icons.add),
              ),
            );
          }
      ),
    );
  }

}

class MyList {
  String name;
  String link;
  MyList({
    this.name,
    this.link,
  });
}

