import 'package:demopico/features/home/domain/usecases/get_recent_communiques.dart';
import 'package:demopico/features/hub/domain/entities/communique.dart';
import 'package:flutter/cupertino.dart';

class HomeProvider extends ChangeNotifier {
  final GetRecentCommuniques _listarComunicado;
  HomeProvider({required GetRecentCommuniques listarComunicado})
      : _listarComunicado = listarComunicado;

  static HomeProvider? _homeProvider;

  static HomeProvider get getInstance{
    _homeProvider ??= HomeProvider(listarComunicado: GetRecentCommuniques.instance);
    return _homeProvider!;
  }

    List<Communique?> _allCommuniques = [];

    List<Communique?> get allCommuniques  => _allCommuniques;

  Future<void> fetchRecentCommuniques() async {
    _allCommuniques = await _listarComunicado.call();
    notifyListeners();
  }

}