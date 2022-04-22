import 'package:flutter/material.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:image_picker/image_picker.dart';

void main() async {
  runApp(Page01());
    // MaterialApp(debugShowCheckedModeBanner: false, initialRoute: '/', routes: {
    //   '/': (context) => RouteOne(),
    //   '/detail': (context) => RouteTwo(image: ''),
    // }),

}
class Page01 extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          appBar: AppBar(
            title: Text('Page01'),
          ),
          body: _Page01()
      ),
    );
  }
}


class _Page01 extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      child: Text('Go to Page02'),
      onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context) => RouteOne()));},
    );
  }
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
  final key=GlobalKey<_ImageBrowserState>();

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

              child: imgBrowser


              //     Image(
              //   image: AssetImage(image),
              // )

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
  List<String> _images;
  int _imageIndex;

  _ImageBrowser(this._key, this._images) : super(key: _key) {
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

    var imgs=PhotoView(maxScale: PhotoViewComputedScale.covered,minScale: PhotoViewComputedScale.contained*0.6,enableRotation: false
        ,backgroundDecoration:BoxDecoration(color: Colors.red),imageProvider:AssetImage(widget._images[widget._imageIndex]));
    return imgs;
  }

  previousImage() {
    widget._imageIndex = widget._imageIndex == 0
        ? widget._images.length - 1
        : widget._imageIndex - 1;
    setState(() {});
  }

  nextImage() {
    widget._imageIndex = ++widget._imageIndex % widget._images.length;
    setState(() {});
  }
}





