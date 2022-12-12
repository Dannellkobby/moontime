import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moontime/models/cast.dart';
import 'package:moontime/models/episode.dart';
import 'package:moontime/models/show.dart';
import 'package:moontime/utilities/colours.dart';
import 'package:moontime/utilities/constants.dart';
import 'package:moontime/utilities/strings.dart';
import 'package:moontime/views/screens/home.dart';

class CardCast extends StatelessWidget {
  final Cast cast;
  final double? radius;
  const CardCast({
    Key? key, required this.cast,this.radius,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(radius??kRadiusSmall),
      onTap: () {
          Get.toNamed(Strings.routePersonDetails,
            arguments: {Strings.keyPerson: cast.person});
      },
      child: Column(
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(radius??kRadiusSmall),
              child: CachedNetworkImage(
                  fit: BoxFit.cover,
                  alignment: Alignment.topCenter,
                  errorWidget: (c, err, obj) => const MoontimePlaceholder(
                      height: double.maxFinite,
                      logoColor: Colours.redError),
                  placeholder: (c, err) => const MoontimePlaceholder(
                    height: double.maxFinite,

                  ),
                  height: double.maxFinite,
                  width: double.maxFinite,
                  imageUrl:
                  '${cast.person?.image?.medium??cast.character?.image?.medium}'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.stretch,
              mainAxisAlignment:
              MainAxisAlignment.start,
              children: [
                Text(
                   '${cast.person?.name}',
                  textAlign: TextAlign.start,
                  maxLines: 1,
                  style: Theme.of(context)
                      .textTheme
                      .subtitle2
                      ?.copyWith(
                    fontSize: 12,
                    color: Colors.white,

                  ),
                ),
                Text(
                  cast.character?.name??'',
                  textAlign: TextAlign.start,
                  maxLines: 1,
                  style: Theme.of(context)
                      .textTheme
                      .overline
                      ?.copyWith(                                              shadows: <Shadow>[
                  ],
                      color: Colours.lightShade500),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
