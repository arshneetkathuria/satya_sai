import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:satya_sai/constants/constants.dart';
import 'package:satya_sai/model_class/exhibit_model.dart';
import 'package:flutter/services.dart' as rootBundle;
import 'package:satya_sai/player/audio_player.dart';
import 'package:satya_sai/player/ripple_effect_animation.dart';
import 'package:satya_sai/player/tcp_client.dart';
import 'package:satya_sai/provider/audio_player_provider.dart';
import 'package:satya_sai/provider/language_selection_provider.dart';
import 'package:satya_sai/services/get_content.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  final Player _playerInstance = Player.playerInstance;
  final TextEditingController _controller = TextEditingController();
  bool searchBoxIsPristine = true;
  int currentIndex = 0;
  GetContent _getContent=GetContent();

  Future<List<ExhibitModel>> loadData() async {
    var data = await rootBundle.rootBundle.loadString('assets/json/data.json');
    List<dynamic> response = json.decode(data)['en'];
    return response
        .map<ExhibitModel>((element) => ExhibitModel.fromJson(element))
        .toList();
  }


  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Image.asset("assets/images/splashScreen.png",
            fit: BoxFit.fitWidth, width: double.infinity),
        Padding(
          padding:
              const EdgeInsets.only(top: 30, bottom: 20, left: 10, right: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              Row(children: [
                Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                        // color: Theme.of(context).accentColor,
                        borderRadius: BorderRadius.circular(12)),
                    child: IconButton(
                        icon: const Icon(Icons.arrow_back_rounded),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        color: Theme.of(context).primaryColorLight)),
                const SizedBox(width: 20),
                const Text(
                  'Exhibit Name',
                  style: TextStyle(
                      color: pink, fontSize: 30, fontWeight: FontWeight.bold),
                )
              ]),
              const SizedBox(height: 35),
              //------------search-------------------
              Container(
                height: 45,
                decoration: BoxDecoration(
                    color: white, borderRadius: BorderRadius.circular(8)),
                child: Row(children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.only(left: 10),
                      width: 100,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0)),
                      child: TextFormField(
                          autofocus: false,
                          onChanged: (searchKeyword) {
                            searchKeyword = searchKeyword.toLowerCase();
                            setState(() {
                              searchBoxIsPristine =
                                  searchKeyword.isNotEmpty ? false : true;
                            });
                            // Provider.of<MySort>(context, listen: false)
                            //     .onSearchTextChanged(searchKeyword);
                          },
                          controller: _controller,
                          style: TextStyle(
                              color: Theme.of(context).primaryColorLight),
                          decoration: InputDecoration(
                              hintText: 'Search any Exhibit',
                              border: InputBorder.none,
                              hintStyle:
                                  Theme.of(context).textTheme.subtitle1)),
                    ),
                  ),
                  IconButton(
                      color: cardColor,
                      onPressed: () {},
                      icon: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 200),
                        transitionBuilder:
                            (Widget child, Animation<double> animation) {
                          return ScaleTransition(
                              child: child, scale: animation);
                        },
                        child: IconButton(
                            icon: Icon(
                                searchBoxIsPristine == true
                                    ? Icons.search
                                    : Icons.close,
                                size: 25),
                            key: ValueKey<bool>(searchBoxIsPristine),
                            color: textHeadingColor,
                            onPressed: () {
                              if (searchBoxIsPristine == false) {
                                _controller.text = "";
                              }
                              setState(() {
                                searchBoxIsPristine = true;
                              });
                              // Provider.of<MySort>(context, listen: false)
                              //     .onSearchTextChanged("");
                            }),
                      )),
                ]),
              ),
              const SizedBox(height: 35),

              //-----------------body---------------
              Align(
                alignment: Alignment.center,
                child: Image.asset(
                  'assets/headphone.png',
                  color: pink,
                  height: 80,
                ),
              ),
              const Align(
                alignment: Alignment.center,
                child: Text(
                  "Click the audio button for corresponding audio",
                  style: TextStyle(
                      fontSize: 16, color: pink, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 20),
              Consumer<LanguageSelectionProvider>(
                builder:(context,language,_)=> FutureBuilder(
                    future: _getContent.getData(language.locale),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        List<ExhibitModel> exhibit =
                            snapshot.data as List<ExhibitModel>;
                        return Consumer<AudioPlayerProvider>(
                          builder: (context, obj, _) => Expanded(
                            child: GridView.builder(
                                itemCount: exhibit[0].zones.length,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                        crossAxisCount: 3,
                                        crossAxisSpacing: 15,
                                        mainAxisSpacing: 15),
                                itemBuilder: (context, index) {
                                  currentIndex = index + 1;
                                  print('build');
                                  return InkWell(
                                      borderRadius: BorderRadius.circular(60),
                                      onTap: () async {
                                        TcpClient.getTime(
                                            exhibit[0].zones[index].ip);
                                        _playerInstance.playFile(
                                            exhibit[0].zones[index].audio,
                                            exhibit[0].zones[index].ip,
                                            context);
                                        setState(() {
                                          obj.setSelectedIndex(index);
                                        });
                                      },
                                      child: Stack(
                                          alignment: Alignment.center,
                                          children: [
                                            if (obj.selectedIndex == index)
                                              const RippleEffectAnimation()
                                            else if (obj.selectedIndex == -1)
                                              Container()
                                            else
                                              Container(),
                                            Card(
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(65)),
                                              elevation: 5,
                                              child: Container(
                                                  alignment: Alignment.center,
                                                  width: 100,
                                                  height: 100,
                                                  decoration: const BoxDecoration(
                                                    shape: BoxShape.circle,
                                                  ),
                                                  child: Text(
                                                    '0' +
                                                        (currentIndex).toString(),
                                                    style: const TextStyle(
                                                        color: pink,
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 25),
                                                  )),
                                            ),
                                          ]));
                                }),
                          ),
                        );
                      } else {
                        return const CircularProgressIndicator(color: pink,);
                      }
                    }),
              ),
              // const RippleEffectAnimation()
            ],
          ),
        ),
      ]),
    );
  }
}
