import 'package:flutter/cupertino.dart';
import 'package:satya_sai/model_class/exhibit_model.dart';

class SelectedExhibitProvider with ChangeNotifier
{
  late Zone _currentExhibit;

  Zone get currentExhibit=>_currentExhibit;

  void setCurrentExhibit(Zone exhibit)
  {
    _currentExhibit=exhibit;
    notifyListeners();
  }

}