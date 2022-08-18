import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NetworkLoadImage extends StatelessWidget {
  final String? url;
  final Widget? image;
  final BoxFit fit;
  final double width;
  final double height;
  final Color backgroundColor;

  const NetworkLoadImage(
      {this.url,
      this.image,
      this.fit = BoxFit.cover,
      this.backgroundColor = const Color(0xfff2f3f3),
      this.width = double.infinity,
      this.height = double.infinity});
  const NetworkLoadImage.fill({this.url, this.image})
      : width = double.infinity,
        height = double.infinity,
        this.backgroundColor = const Color(0xfff2f3f3),
        fit = BoxFit.cover,
        super();

  @override
  Widget build(BuildContext context) {
    if (image != null && (url == null || url!.isEmpty)) {
      return image!;
    } else {
      return (url == null || url!.isEmpty)
          ? Container(
              color: backgroundColor,
              width: width,
              height: height,
              child: const Icon(
                Icons.image,
                color: Colors.grey,
              ),
            )
          : CachedNetworkImage(
              imageUrl: url!,
              key: ValueKey(url),
              fit: fit,
              width: width,
              height: height,
              // imageBuilder: (context, imageProvider) => Container(
              //   decoration: BoxDecoration(
              //     image: DecorationImage(
              //         image: imageProvider,
              //         fit: fit,
              //         colorFilter:
              //         ColorFilter.mode(Colors.transparent, BlendMode.colorBurn)
              //     ),
              //   ),
              // ),
              progressIndicatorBuilder: (context, url, downloadProgress) =>
                  const Center(
                      child: SizedBox(
                child: CupertinoActivityIndicator(),
                width: 18,
                height: 18,
              )),
              errorWidget: (context, url, error) =>
                  image ??
                  Container(
                    color: backgroundColor,
                    child: const Icon(
                      Icons.image,
                      color: Colors.grey,
                    ),
                  ),
            );
    }
  }
}

class RoundedImage extends StatelessWidget {
  final String? url;
  final Widget? image;
  final BoxFit? fit;
  final double width;
  final double height;
  final Color borderColor;
  final Color backgroundColor;
  final double borderWidth;
  final double radius;
  final EdgeInsetsGeometry? margin;
  final List<BoxShadow>? boxShadow;

  const RoundedImage(
      {this.url,
      this.image,
      this.fit,
      this.width = double.infinity,
      this.height = double.infinity,
      this.borderColor = Colors.white,
      this.backgroundColor = const Color(0xfff2f3f3),
      this.borderWidth = 2.0,
      this.radius = 10,
      this.margin,
      this.boxShadow});
  const RoundedImage.normal(
      {this.url,
      this.image,
      this.fit,
      this.width = double.infinity,
      this.height = double.infinity,
      this.margin,
      this.backgroundColor = const Color(0xfff2f3f3),
      this.boxShadow})
      : borderColor = Colors.white,
        borderWidth = 2.0,
        radius = 10.0,
        super();

  @override
  Widget build(BuildContext context) {
    return Container(
        width: width,
        height: height,
        margin: margin,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.all(Radius.circular(radius)),
          border: Border.all(color: borderColor, width: borderWidth),
          boxShadow: boxShadow,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.all(Radius.circular(radius - 2)),
          child: NetworkLoadImage(
            url: url,
            image: image,
            fit: fit ?? BoxFit.cover,
            backgroundColor: backgroundColor,
          ),
        ));
  }
}

class CircleImage extends StatelessWidget {
  final String? url;
  final Widget? image;
  final double size;
  final Color? borderColor;
  final double borderWidth;
  final EdgeInsets padding;
  final List<BoxShadow>? boxShadow;

  const CircleImage({
    this.url,
    this.image,
    this.borderColor,
    this.size = double.infinity,
    this.borderWidth = 2.0,
    this.padding = EdgeInsets.zero,
    this.boxShadow,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      padding: padding,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border:
            Border.all(color: borderColor ?? Colors.white, width: borderWidth),
        boxShadow: boxShadow,
      ),
      child: ClipOval(
        child: NetworkLoadImage(
          url: url,
          width: size,
          height: size,
          image: image,
        ),
      ),
    );
  }
}
