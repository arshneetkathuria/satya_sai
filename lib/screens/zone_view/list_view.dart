import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:satya_sai/constants/constants.dart';
import 'package:satya_sai/generated/l10n.dart';
import 'package:satya_sai/model_class/exhibit_model.dart';
import 'package:satya_sai/provider/language_selection_provider.dart';
import 'package:satya_sai/screens/detailed_zone/zone_detail.dart';
import 'package:satya_sai/services/get_content.dart';

import 'grid_view.dart';
import 'list_card.dart';

class ListViewPage extends StatefulWidget {
  const ListViewPage({Key? key}) : super(key: key);

  @override
  _ListViewPageState createState() => _ListViewPageState();
}

class _ListViewPageState extends State<ListViewPage> {
  final GetContent _content = GetContent();
  bool gridViewEnabled = false;
  double containerHeight = 400;

  @override
  void initState() {
    // TODO: implement initStates
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Image.asset("assets/images/splashScreen.png",
            fit: BoxFit.fitWidth, width: double.infinity),
        const Padding(
            padding: EdgeInsets.only(top: 30, bottom: 20, left: 10, right: 10)),
        Consumer<LanguageSelectionProvider>(
          builder:(context,language,_) {
            print('language ${language.locale}');
            return Column(children: [
              SizedBox(
                height: containerHeight,
                child: Stack(children: [
                  Image.asset(
                    "assets/images/exhibits/1.png",
                    fit: BoxFit.fitWidth,
                    width: MediaQuery
                        .of(context)
                        .size
                        .width,
                  ),
                  Image.asset(
                    "assets/images/gradient.png",
                    fit: BoxFit.fitWidth,
                    width: MediaQuery
                        .of(context)
                        .size
                        .width,
                  ),
                  Positioned(
                    top: 100,
                    child: Image.asset(
                      "assets/images/logo2.png",
                      fit: BoxFit.fitWidth,
                      width: MediaQuery
                          .of(context)
                          .size
                          .width,
                    ),
                  ),
                ]),
              ),
              Expanded(
                child: Container(
                    padding: const EdgeInsets.only(
                        top: 20, right: 20, left: 20),
                    child: Column(children: [
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              S
                                  .of(context)
                                  .explore,
                              style: const TextStyle(
                                  color: pink,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                            InkWell(
                                onTap: () {
                                  setState(() {
                                    gridViewEnabled = !gridViewEnabled;
                                  });
                                },
                                child: gridViewEnabled
                                    ? const Icon(
                                  Icons.list,
                                  color: pink,
                                  size: 35,
                                )
                                    : Image.asset(
                                  'assets/images/grid_box.png',
                                  width: 35,
                                  height: 35,
                                ))
                          ]),
                      const SizedBox(height: 20),
                      FutureBuilder(
                          future: _content.getData(language.locale),
                          builder: (BuildContext context,
                              AsyncSnapshot<dynamic> snapshot) {
                            print('data ${snapshot.hasData}');
                            if (snapshot.hasData) {
                              return Expanded(
                                child: gridViewEnabled
                                    ? GridViewVisible(
                                  exhibitList: snapshot.data,
                                )
                                    : NotificationListener<
                                    UserScrollNotification>(
                                  onNotification: (scrollNotification) {
                                    if (scrollNotification.direction ==
                                        ScrollDirection.forward) {
                                      setState(() {
                                        containerHeight = 400;
                                      });
                                    }
                                    if (scrollNotification.direction ==
                                        ScrollDirection.reverse) {
                                      setState(() {
                                        containerHeight = 300;
                                      });
                                    }

                                    return true;
                                  },
                                  child: ListView.builder(
                                      physics: const BouncingScrollPhysics(),
                                      shrinkWrap: true,
                                      itemCount: _content.exhibitModel.length,
                                      itemBuilder: (context, index) =>
                                          ListCard(
                                              exhibit: _content
                                                  .exhibitModel[index])),
                                ),
                              );
                            } else {
                              return const Center(child: CircularProgressIndicator(
                                color: pink,
                              ));
                            }
                          })
                    ])),
              )
            ]);
          }
        ),
      ]),
    );
  }
}
