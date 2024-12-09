import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:moviesapps/model/cast_model.dart';

import '../constants/constants.dart';

class CastListItem extends StatelessWidget {
  final CastModel castModel;

  const CastListItem({super.key, required this.castModel});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5),
      width: 120,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CachedNetworkImage(
            imageUrl: kmoviedbImageURL + castModel.profilePath.toString(),
            imageBuilder: (context, imageProvider) => Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(50)),
                image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            placeholder: (context, url) =>
                Center(child: CircularProgressIndicator()),
            errorWidget: (context, url, error) => Container(
              height: 100,
              width: 100,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                  image: DecorationImage(
                    image: AssetImage("assets/image/notfound.png"),
                    fit: BoxFit.fill,
                  )),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Text(
            castModel.name.toString(),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w300),
          ),
          Text(
            castModel.knownForDepartment.toString(),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: TextStyle(color: Colors.grey),
          ),
        ],
      ),
    );
  }
}