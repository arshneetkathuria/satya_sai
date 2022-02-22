import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:satya_sai/constants/constants.dart';
import 'package:satya_sai/model_class/exhibit_model.dart';
import 'package:satya_sai/player/audio_player.dart';
import 'package:satya_sai/provider/selected_exhibit_provider.dart';
import 'package:satya_sai/screens/exhibit_players_grid/audio_player.dart';
import 'package:satya_sai/screens/exhibit_players_grid/exhibit_player_grid.dart';

class DetailedZone extends StatefulWidget {
  final ExhibitModel exhibit;

  const DetailedZone(this.exhibit, {Key? key}) : super(key: key);

  @override
  _DetailedZoneState createState() => _DetailedZoneState(exhibit);
}

class _DetailedZoneState extends State<DetailedZone> {
  ExhibitModel exhibit;

  _DetailedZoneState(this.exhibit);

  @override
  Widget build(BuildContext context) {
    double width=MediaQuery.of(context).size.width;
    Player _playerInstance=Player.playerInstance;
    return Scaffold(
      body: Consumer<SelectedExhibitProvider>(
        builder: (context, obj, _) => Stack(
          children: [
            Image.asset("assets/images/splashScreen.png",
                fit: BoxFit.fitWidth, width: double.infinity),
            Column(children: [
              Image.asset(obj.currentExhibit.exhibitImage,
                  height: 300, fit: BoxFit.fitWidth, width: double.infinity),
              const SizedBox(height: 10),
              const Expanded(child: ExhibitPlayerGrid()),
              //
              //       CurvedNavigationBar(
              //         // height: 100,
              //         backgroundColor: Colors.transparent,
              //         onTap: (value){
              //         },
              //         items: [
              //         const Icon(Icons.home,color: pink,size: 30,),
              //         const Icon(Icons.list,color:pink,size:30),
              //           const AudioPlayer(),
              //           Image.asset('assets/images/language.png',width:30),
              //         const Icon(Icons.settings,color:pink,size: 30,),
              // ],
              //
              // )
            ]),
            // Positioned(
            //     bottom: 0,
            //     height: 400,
            //     child: Image.asset('assets/images/gradient_below_footer.png',
            //         height: 400)),
            Positioned(
                bottom: 0,
                child: Container(
                  height: 70,
                  padding: const EdgeInsets.only(bottom: 10),
                  width:width,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage("assets/images/navigate_footer.png"),
                        fit: BoxFit.fill),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      IconButton(
                          icon: const Icon(Icons.arrow_back,
                              color: pink, size: 35),
                          onPressed: () {
                            _playerInstance.player.fixedPlayer!.stop();
                            Navigator.pop(context);
                          }),

                      // const SizedBox(
                      //     height: 100,
                      //     child: AudioPlayer()),
                      // IconButton(

                      IconButton(
                        icon: const Icon(Icons.volume_down_sharp,
                            color: pink, size: 35),
                        onPressed: () {},
                      ),
                    ],
                  ),
                )),
             Positioned(
              left:width*0.41,
              bottom: 5,
              child: const SizedBox(height: 100, child: AudioPlayer()),
            )
          ],
        ),
      ),
    );
  }
}
