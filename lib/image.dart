import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class ImageFromGallery extends StatefulWidget {
  File? filePath;
  ImageFromGallery({super.key, this.filePath});

  @override
  State<ImageFromGallery> createState() => _ImageFromGalleryState();
}

class _ImageFromGalleryState extends State<ImageFromGallery> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Detail(
                      filePath: widget.filePath,
                    ),
                  ));
            },
            child: SizedBox(
              height: 200,
              width: 300,
              child: Image.file(widget.filePath!),
            ),
          )
        ],
      ),
    );
  }
}

class Detail extends StatelessWidget {
  File? filePath;
  Detail({super.key, this.filePath});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Hero(tag: "Rujesh", child: Image.file(filePath!)),
      ),
    );
  }
}
