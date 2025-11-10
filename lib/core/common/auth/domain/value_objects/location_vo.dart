
class LocationVo {
  final double latitude;
  final double longitude;

  LocationVo._(this.latitude, this.longitude);

  factory LocationVo({required double latitude,required double longitude}) {
    if (latitude < -90 || latitude > 90) {
      throw ArgumentError('Invalid latitude value');
    }
    if (longitude < -180 || longitude > 180) {
      throw ArgumentError('Invalid longitude value');
    }
    return LocationVo._(latitude, longitude);
  }

  factory LocationVo.empty(){
    return LocationVo(latitude: 0, longitude: 0);
  }
}