import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:satya_sai/constants/constants.dart';
import 'package:satya_sai/generated/l10n.dart';
import 'package:satya_sai/model_class/exhibit_model.dart';

class GridViewVisible extends StatelessWidget {
  List<ExhibitModel> exhibitList;
  GridViewVisible({Key? key,required this.exhibitList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.count(
          physics: const BouncingScrollPhysics(),
          crossAxisCount: 2,
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
          childAspectRatio:

          0.7
          ,
          children: exhibitList.map((item) {

            return InkWell(
              onTap: () {
                Navigator.pushReplacementNamed(context, '/DetailedZone',arguments: item);

              },
              child: Container(
                  decoration: BoxDecoration(
                    borderRadius:
                    BorderRadius.circular(12),
                    color: white,
                    boxShadow: [BoxShadow(
                      color: textHeadingColor.withAlpha(20),
                      blurRadius: 2, // soften the shadow
                      spreadRadius: 1, //extend the shadow
                    )
                    ],
                  ),
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.all(1),
                  child: Column(
                      mainAxisAlignment:
                      MainAxisAlignment.start,
                      children: [
                        //Image of the Exhibit
                        Container(
                          height: 140,
                          width: 140,
                          decoration: BoxDecoration(
                            borderRadius:
                            BorderRadius.circular(1),
                          ),
                          child:
                          Image.asset(item.zoneImage),
                        ),
                        const SizedBox(height: 10),
                        //Name of the Exhibit
                        SizedBox(
                          height: 50,
                          child: Text(item.zoneName,
                              style: const TextStyle(
                                // color: textBodyColor,
                                  fontSize: 16,
                                  fontFamily: "Lato")),
                        ),
                        const SizedBox(height: 10),

                        //Time & Navigation Icon
                        Container(
                          child: Row(
                            mainAxisAlignment:
                            MainAxisAlignment
                                .spaceBetween,
                            children: [
                              Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment
                                      .spaceEvenly,
                                  children:  [
                                    const Icon(
                                      Icons
                                          .watch_later_outlined,
                                    ),
                                    const SizedBox(width: 5),
                                    Text(
                                      "10 ${S.of(context).min}",
                                      style: const TextStyle(
                                          fontSize: 12,
                                          fontFamily:
                                          "Lato",
                                          fontWeight:
                                          FontWeight
                                              .bold),
                                    )
                                  ]),
                            ],
                          ),
                        )
                      ])),
            );
          }).toList());

  }
}
