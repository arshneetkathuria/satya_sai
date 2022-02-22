import 'package:flutter/cupertino.dart';

class AudioPlayerProvider with ChangeNotifier{
  int _selectedIndex=-1;
  bool _isPlaying=false;

  int get selectedIndex=>_selectedIndex;
  bool get isPlaying=>_isPlaying;

  void setSelectedIndex(int index)
  {
    _selectedIndex=index;
    notifyListeners();
  }

  void setPlayerState(bool playing)
  {
    _isPlaying=playing;
    notifyListeners();
  }
}