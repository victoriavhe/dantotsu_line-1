import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';

class ProfileImage extends StatelessWidget {
  final String imageUrl;

  const ProfileImage({Key key, this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _height = MediaQuery.of(context).size.height;
    return Container(
      height: _height / 20,
      child: CachedNetworkImage(
        fit: BoxFit.cover,
        errorWidget: (context, url, error) => CachedNetworkImage(
          imageUrl:
              "https://icons-for-free.com/iconfiles/png/512/business+face+people+icon-1320086457520622872.png",
        ),
        imageUrl: imageUrl ?? "",
      ),
    );
  }
}
