import 'package:flutter/material.dart';
import 'package:graduation_project_therapist_dashboard/app/shared/shared_widgets/image_widgets/network_image.dart';

class FullScreenImagePage extends StatelessWidget {
  final String imageName;
  final String heroTag;

  const FullScreenImagePage(
      {super.key, required this.imageName, required this.heroTag});

  @override
  Widget build(BuildContext context) {    
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Center(
        child: Hero(
            tag: heroTag,
            child: getImageNetwork(
                url: imageName,
                width: double.infinity,
                height: double.infinity,
                fit: BoxFit.contain)),
      ),
    );
  }
}
