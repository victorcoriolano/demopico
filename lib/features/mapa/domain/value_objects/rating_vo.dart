

class RatingVo {
  final double average;
  final int numberOfReviews;

  RatingVo._(this.average, this.numberOfReviews);

  factory RatingVo(double value, int numberOfReviews) {
    if (value < 0 || value > 5) {
      throw ArgumentError('Invalid rating value');
    }
    if (numberOfReviews < 0) {
      throw ArgumentError('Number of reviews cannot be negative');
    }

    if(value > 0 && numberOfReviews == 0){
      throw ArgumentError("Invalid rate: there is average but there is no number of reviews");
    }
    
    return RatingVo._(value, numberOfReviews);
  }


  RatingVo calculateNewAverage(double newRating) {
    if (newRating < 0 || newRating > 5) {
      throw ArgumentError('Invalid rating value');
    }
    final totalRating = average * numberOfReviews + newRating;
    final newNumberOfReviews = numberOfReviews + 1;
    final newAverage = double.parse((totalRating / newNumberOfReviews).toStringAsFixed(2));
    return copyWith(newAverage: newAverage, numberOfReviews: newNumberOfReviews);
  }

  RatingVo Function(double) evaluateFunction(double newRating) {
    return calculateNewAverage;
  } 
  
  RatingVo copyWith({
    double? newAverage,
    int? numberOfReviews,
  }) {
    return RatingVo._(
      newAverage ?? average,
      numberOfReviews ?? this.numberOfReviews,
    );
  }
  
}