import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:satya_sai/constants/constants.dart';
import 'package:satya_sai/provider/language_selection_provider.dart';

class LanguageSelection extends StatelessWidget {
  LanguageSelection({Key? key}) : super(key: key);
  final List _language = [
    {'id': 1, 'locale': 'English'},
    {'id': 2, 'locale': 'हिन्दी'},
    {'id': 3, 'locale': 'మరాఠీ'},
    {'id': 4, 'locale': 'తెలుగు'}
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(alignment: Alignment.topCenter, children: [
        Image.asset("assets/images/splashScreen2.png",
            fit: BoxFit.fitWidth, width: double.infinity),
        Padding(
          padding: const EdgeInsets.only(top: 70),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Image.asset(
                "assets/images/logo2.png",
                fit: BoxFit.fitWidth,
                width: MediaQuery.of(context).size.width,
              ),
              const SizedBox(height: 30),
              Expanded(
                  child: ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: _language.length,
                      itemBuilder: (context, index) {
                        return languageWidget(context, _language[index]);
                      })),
            ],
          ),
        )
      ]),
    );
  }

  Widget languageWidget(BuildContext context, Map<String,dynamic> language) {
    return Container(
      decoration: const BoxDecoration(shape: BoxShape.circle,
      ),
      // color: Colors.red,
      width: 150,height:150,
      child: InkWell(
        onTap: () {
          switch(language['id']){
            case 1:
              {
                Provider.of<LanguageSelectionProvider>(context,listen:false).setLocale(const Locale('en'));
              }break;
            case 2:{
              Provider.of<LanguageSelectionProvider>(context,listen:false).setLocale(const Locale('hi'));
            }break;
            case 3:{
              Provider.of<LanguageSelectionProvider>(context,listen:false).setLocale(const Locale('mr'));
            }break;
            case 4:{
              Provider.of<LanguageSelectionProvider>(context,listen:false).setLocale(const Locale('te'));
            }break;
            default:
              {
                Provider.of<LanguageSelectionProvider>(context,listen:false).setLocale(const Locale('en'));
              }

          }
          Navigator.pushReplacementNamed(context, '/ListViewPage');
        },
        child:
          Stack(
            alignment: Alignment.center,
            children: [
              Image.asset('assets/images/languageBase.png', height: 125),
              Text(
                language['locale'],
                style: const TextStyle(
                    color: white, fontSize: 23, fontWeight: FontWeight.bold),
              )
            ],
          ),
        //   const SizedBox(
        //     height: 30,
        //   )
        // ]),
      ),
    );
  }
}
