import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:page_transition/page_transition.dart';

class Util {
  static void showMessage(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(milliseconds: 200),
        animation: const AlwaysStoppedAnimation(1),
        elevation: 0,
        behavior: SnackBarBehavior.fixed,
        padding: const EdgeInsets.all(15),
        dismissDirection: DismissDirection.down,
      ),
    );
  }

  static Widget cacheNetworkImage(String imageUrl) {
    return CachedNetworkImage(
      errorWidget: (context, url, error) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: const Color.fromARGB(255, 223, 222, 222),
          ),
          height: 200,
          width: double.maxFinite,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.error_rounded),
              Text('$error'),
            ],
          ),
        );
      },
      progressIndicatorBuilder: (context, url, progress) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: const Color.fromARGB(255, 223, 222, 222),
          ),
          height: 200,
          width: double.maxFinite,
          child: Center(
              child: LoadingAnimationWidget.threeArchedCircle(
                  color: Colors.black, size: 20)),
        );
      },
      imageBuilder: (context, imageProvider) => Container(
        height: 200,
        width: double.maxFinite,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          image: DecorationImage(
            image: imageProvider,
            fit: BoxFit.cover,
          ),
        ),
      ),
      cacheKey: imageUrl,
      imageUrl: imageUrl,
    );
  }

  static void changePage(BuildContext context, Widget page) {
    Navigator.push(
      context,
      PageTransition(
        type: PageTransitionType.size,
        alignment: Alignment.bottomCenter,
        curve: Curves.fastEaseInToSlowEaseOut,
        duration: const Duration(seconds: 1),
        fullscreenDialog: true,
        maintainStateData: true,
        reverseDuration: const Duration(milliseconds: 300),
        child: page,
      ),
    );
  }
}
