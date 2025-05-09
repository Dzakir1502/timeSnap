import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';
import 'package:timesnap/core/provider/app_provider.dart';

class MapNotifier extends AppProvider {
  MapNotifier() {
    init();
  }

  MapController _mapController = MapController.withPosition(
    initPosition: GeoPoint(latitude: -6.17549964024, longitude: 106.827149391),
  );

  MapController get mapController => _mapController;

  @override
  void init() {}
}
