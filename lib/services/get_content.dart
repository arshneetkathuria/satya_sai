import 'dart:convert';
import 'dart:io';
import 'dart:ui';
import 'package:http/http.dart' as http;
import 'package:satya_sai/constants/Api.dart';
import 'package:satya_sai/model_class/exhibit_model.dart';
import 'package:path_provider/path_provider.dart';


class GetContent {
  List<ExhibitModel> exhibitModel = [];
  List<Zone> zones=[];



  Future<List<ExhibitModel>> getData(Locale locale) async {
    String fileName = 'abcdef.json';
    var dir = await getExternalStorageDirectory();
    File file = File(dir!.path + '/' + fileName);
    if (file.existsSync()) {
      print('cache');
      return [];
    }
    else {
      print('api');
      // loadData(locale).then((list) {
      //   exhibitModel = list as List<ExhibitModel>;
      // });
      exhibitModel=await loadData(locale) as List<ExhibitModel>;
      return exhibitModel;
    }

  }
  Future<Iterable<Zone>> getAudioList(Locale locale)
  async {
    zones=[];
//     getData(locale).then((list) {
//       List<ExhibitModel> exhibitList = list;
// exhibitList.forEach((element) {
//   zones.addAll(element.zones);
// });
//     });
    List<ExhibitModel> exhibitList=await getData(locale);
    exhibitList.forEach((element) {
  zones.addAll(element.zones);
});
    return zones;

  }

  Future<List<dynamic>> loadData(Locale locale) async {
    List<dynamic> response = [];
    String url = Api.contentUrl;
    var serverResponse = await http.get(Uri.parse(url));
    if (serverResponse.statusCode == 200) {
      response = json.decode(serverResponse.body)[locale.toString()];
      return response
          .map<ExhibitModel>((element) => ExhibitModel.fromJson(element))
          .toList();
    }
    else {
      loadData(locale);
    }
    return response;
  }
}
