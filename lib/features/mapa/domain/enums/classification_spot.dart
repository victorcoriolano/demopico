enum ClassificationSpot {
  fullRespect,
  maxRespect,
  respect,
  bad,
  reallyBad;

  factory ClassificationSpot.fromRate(double nota){
    if (nota >= 4.0) {
      return ClassificationSpot.fullRespect;
    } else if (nota >= 3.5) {
      return ClassificationSpot.maxRespect;
    } else if (nota >= 2.5) {
      return ClassificationSpot.respect;
    } else if (nota >= 1.5) {
      return ClassificationSpot.bad;
    } else {
      return ClassificationSpot.reallyBad;
    }
  }

  String get name {
    switch (this){ 
      case ClassificationSpot.fullRespect:
        return "Muito marreta";
      case ClassificationSpot.maxRespect:
        return "Marretinha";
      case ClassificationSpot.respect:
        return "Dá pra andar";
      case ClassificationSpot.bad:
        return "Zuado";
      case ClassificationSpot.reallyBad:
        return "Horrível";
    }
  }
}