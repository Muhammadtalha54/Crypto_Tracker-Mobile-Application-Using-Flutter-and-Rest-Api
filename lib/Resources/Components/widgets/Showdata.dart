import 'dart:ffi';

import 'package:crypto_tracker_1/Model/Home/Cryptolistmodel.dart';
import 'package:crypto_tracker_1/Resources/Components/charts/sparklinechart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';
import 'package:like_button/like_button.dart';

import '../../../Viewmodel/Controllers/Cryptolist_controller/cryptolistcontroller.dart';

class Showcryptodata extends StatefulWidget {
  const Showcryptodata(
      {Key? key,
      required this.imageurl,
      required this.cryptoname,
      required this.cryptsymbol,
      required this.price,
      required this.pricechange,
      required this.pricechangeprecentage,
      required this.prices,
      required this.height,
      required this.width,
      required this.cryptocurrency,
      required this.onpress,
      required this.onTap,
      required this.opacity1})
      : super(key: key);

  final String imageurl;
  final String cryptoname;
  final String cryptsymbol;

  final double price;
  final double? pricechange;
  final double? pricechangeprecentage;
  final List<double>? prices;
  final double height, width;
  final Crypto_list_model cryptocurrency;
  final VoidCallback onpress;
  final VoidCallback onTap;
  final double opacity1;

  @override
  State<Showcryptodata> createState() => _ShowcryptodataState();
}

class _ShowcryptodataState extends State<Showcryptodata> {
  final cryptolistcontroller3 = Get.put(cryptolistcontroller());
  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: widget.opacity1,
      child: Card(
        //color: Colors.red,
        elevation: 1,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Container(
          height: widget.height,
          width: widget.width,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            // gradient: LinearGradient(
            //   colors: [
            //     Theme.of(context)
            //         .colorScheme
            //         .primaryContainer, // Primary color from theme
            //     Theme.of(context)
            //         .colorScheme
            //         .secondaryContainer, // Secondary color from theme
            //   ],
            //   //  transform: GradientRotation(147 * 3.14159 / 180),
            //   begin: Alignment.topLeft, // Gradient direction
            //   end: Alignment.bottomRight,
            //   stops: [0.6, 0.9], // Gradient stops
            // ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                  height: Get.height * 0.13,
                  width: Get.width * 0.335,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CircleAvatar(
                        backgroundColor: Color.fromARGB(255, 189, 212, 232),
                        radius: 25,
                        backgroundImage: NetworkImage(widget.imageurl),
                      ),
                      Container(
                        height: Get.height * 0.07,
                        width: Get.width * 0.215,
                        //  color: Colors.red,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("${widget.cryptoname}",
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                                style: Theme.of(context).textTheme.labelLarge),
                            //
                            // ,
                            Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Container(
                                    width: Get.width * 0.12,
                                    child: Text(
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                      "(${widget.cryptsymbol.toString().toUpperCase()})",
                                      style: Theme.of(context)
                                          .textTheme
                                          .titleMedium,
                                    ),
                                  ),
                                  Obx(() {
                                    return Container(
                                      //color: Colors.amber,
                                      height: 25,
                                      width: 35,
                                      child: LikeButton(
                                        circleSize: 5,
                                        isLiked: widget
                                            .cryptocurrency.isfavorite.value,
                                        circleColor: const CircleColor(
                                          start: Color(0xff00ddff),
                                          end: Color(0xff0099cc),
                                        ),
                                        bubblesColor: const BubblesColor(
                                          dotPrimaryColor: Colors.pink,
                                          dotSecondaryColor:
                                              Color.fromARGB(255, 240, 255, 33),
                                        ),
                                        likeBuilder: (bool isLiked) {
                                          return Icon(
                                            Icons.favorite,
                                            color: isLiked
                                                ? Colors.red
                                                : Colors.grey.withOpacity(0.5),
                                            size: Get.width * 0.053,
                                          );
                                        },
                                        onTap: (bool isLiked) async {
                                          try {
                                            if (isLiked) {
                                              widget.onTap;
                                            } else {
                                              widget.onpress;
                                            }
                                            return !isLiked;
                                          } catch (e) {
                                            print(
                                                'Error updating favorite: $e');
                                            return isLiked;
                                          }
                                        },
                                      ),
                                    );
                                  }),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  )),
              Container(
                height: Get.height * 0.1,
                width: Get.width * 0.2,
                child: Sparklinechart(
                  height: Get.height * 0.08,
                  width: Get.width * 0.25,
                  negativeColors: [
                    Color.fromARGB(0, 225, 37, 24),
                    Color.fromARGB(0, 247, 170, 164)
                  ],
                  positiveColors: [
                    Color.fromARGB(0, 59, 156, 62),
                    Color.fromARGB(0, 174, 234, 177),
                  ],
                  linecolornegative: Color.fromARGB(255, 214, 17, 3),
                  linecolorpositive: Color.fromARGB(255, 13, 124, 15),
                  prices: widget.prices!,
                ),
              ),
              Container(
                height: Get.height * 0.07,
                width: Get.width * 0.3,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text("\$ " + widget.price.toString(),
                        style: Theme.of(context).textTheme.bodyLarge),
                    Builder(builder: (context) {
                      double pricechange = widget.pricechange!;
                      double pricechangepercentage =
                          widget.pricechangeprecentage!;
                      if (pricechange < 0) {
                        return Text(
                            "${pricechangepercentage.toStringAsFixed(2)}%(${pricechange.toStringAsFixed(2)})",
                            style: Theme.of(context).textTheme.labelSmall);
                      } else {
                        return Text(
                            "+ ${pricechangepercentage.toStringAsFixed(2)}%(${pricechange.toStringAsFixed(3)})",
                            style: Theme.of(context).textTheme.labelMedium);
                      }
                    })
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
