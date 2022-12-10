import 'package:blurrycontainer/blurrycontainer.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:moontime/models/episode.dart';
import 'package:moontime/utilities/colours.dart';
import 'package:moontime/utilities/strings.dart';
import 'package:moontime/views/screens/home.dart';

class CardEpisode extends StatelessWidget {
  final Episode episode;
  const CardEpisode({
    Key? key, required this.episode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if(episode.show!=null) {
          Get.toNamed(Strings.routeShowDetails,
            arguments: {Strings.keyShow: episode.show});
        }
      },
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            CachedNetworkImage(
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
                '${episode.show?.image?.original}'),
            BlurryContainer(
              blur: 16,
              elevation: 0,

              color: Colors.white
                  .withOpacity(0.2),
              padding: const EdgeInsets.all(0),
              height: 54,
              borderRadius: const BorderRadius.all(
                  Radius.circular(0)),
              child: Builder(builder: (context) {
                return Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12.0),
                  child: Column(
                    crossAxisAlignment:
                    CrossAxisAlignment.stretch,
                    mainAxisAlignment:
                    MainAxisAlignment.center,
                    children: [
                      Text(
                        episode.show?.name ?? episode.name,
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        style: Theme.of(context)
                            .textTheme
                            .subtitle2
                            ?.copyWith(
                          fontSize: 12,
                          color: Colors.white,
                          shadows: <Shadow>[
                            const Shadow(
                              offset: Offset(0.5, 0.5),
                              blurRadius: 2.0,
                              color: Color.fromARGB(
                                  255, 0, 0, 0),
                            ),
                          ],
                        ),
                      ),
                      Text(
                        'S${episode.season}  E${episode.number}',
                        textAlign: TextAlign.center,
                        maxLines: 1,
                        style: Theme.of(context)
                            .textTheme
                            .overline
                            ?.copyWith(                                              shadows: <Shadow>[
                          const Shadow(
                            offset: Offset(0.5, 0.5),
                            blurRadius: 2.0,
                            color: Color.fromARGB(
                                255, 0, 0, 0),
                          ),
                        ],
                            color: Colors.white),
                      ),
                    ],
                  ),
                );
              }),
            )
          ],
        ),
      ),
    );
  }
}