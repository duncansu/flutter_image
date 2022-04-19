import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';

void main() async {
  runApp(
    MaterialApp(debugShowCheckedModeBanner: false, initialRoute: '/', routes: {
      '/': (context) => RouteOne(),
      '/detail': (context) => RouteTwo(image: ''),
    }),
  );
}

class PhotoItem {
  final String image;

  PhotoItem(this.image);
}


class RouteOne extends StatelessWidget {

  final images1 = <String>[
    'assets/15.jpg',
    'assets/14.jpg',
    'assets/13.jpg',
    'assets/11.jpg','assets/12.jpg',
    'assets/下載.jpg',
    'assets/下載.png',
    'assets/pngtree-cartoon-love-red-love-heart-shaped-dialog-png-image_368186.jpg'
  ];

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Screen one ☝️'),
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisSpacing: 0,
          mainAxisSpacing: 0,
          crossAxisCount: 2,
        ),
        itemCount: images1.length,
        itemBuilder: (context, index) {
          return new GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => RouteTwo(
                      image: images1[index]),
                ),
              );
            },
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image:AssetImage(images1[index]),
                ),
              ),
            ),
          );
        },
      ),
    );

  }

}

class RouteTwo extends StatelessWidget {
  final String image;

  RouteTwo({ key,  this.image})
      : super(key: key);


  @override
  Widget build(BuildContext context) {
    var imgBrowser = _ImageBrowser(GlobalKey<_ImageBrowserState>(), RouteOne().images1);
    final previousBtn = FlatButton(
      child: Image.asset('assets/previous.png'),
      onPressed: () {
        imgBrowser._key.currentState.previousImage();
      },
    );

    final nextBtn = FlatButton(
      child: Image.asset('assets/next.png'),
      onPressed: () {
        imgBrowser.nextImage();
      },
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('Screen two ✌️'),
      ),
      body: Column(
        children: [
          AspectRatio(
            aspectRatio: 1,
            child: Container(
              width: double.infinity,
              child: Image(
                image: AssetImage(image),
              ),
            ),
          ),
          Container(
            child: Row(
              children: <Widget>[previousBtn, nextBtn],
              mainAxisAlignment: MainAxisAlignment.center,
            ),
            margin: EdgeInsets.symmetric(vertical: 10),
          ),
        ],
      ),
    );


  }

}


class _ImageBrowser extends StatefulWidget {
  final GlobalKey<_ImageBrowserState> _key;
  List<String> image;
  int _imageIndex;

  _ImageBrowser(this._key, this.image) : super(key: _key) {
    _imageIndex = 0;
  }

  @override
  State<StatefulWidget> createState() => _ImageBrowserState();

  previousImage() => _key.currentState.previousImage();
  nextImage() => _key.currentState.nextImage();
}




class _ImageBrowserState extends State<_ImageBrowser> {
  @override
  Widget build(BuildContext context) {

    var imgs=PhotoView(enableRotation: false
        ,backgroundDecoration:BoxDecoration(color: Colors.red),imageProvider:AssetImage(widget.image[widget._imageIndex]));
    return imgs;
  }

  previousImage() {
    widget._imageIndex = widget._imageIndex == 0
        ? widget.image.length - 1
        : widget._imageIndex - 1;
    setState(() {});
  }

  nextImage() {
    widget._imageIndex = ++widget._imageIndex % widget.image.length;
    setState(() {});
  }
}






// class MyApp extends StatelessWidget {
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: '瀏覽影像',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: MyHomePage(),
//     );
//
//   }
// }
//
// class MyHomePage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     // 建立AppBar
//     final appBar = AppBar(
//       title: Text('瀏覽影像'),
//     );
//

//

//
//
//
//
//
//     // Function to be called on click
//     void _onTileClicked( int index){
//       debugPrint("You tapped on item $index");
//
//
//
//       );
//     }
//
// // Get grid tiles
//     List<Widget> _getTiles(List<String> iconList) {
//       final List<Widget> tiles = <Widget>[];
//       for (int i = 0; i < iconList.length; i++) {
//         tiles.add(new GridTile(
//             child: new InkResponse(
//               enableFeedback: true,
//               child: new Image.asset(iconList[i], fit: BoxFit.cover,),
//               onTap: () {
//
//                 ;},
//             )
//         )
//         );
//       }
//       return tiles;
//     }
//   }
// }
//
