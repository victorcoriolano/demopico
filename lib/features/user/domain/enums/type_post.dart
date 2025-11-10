enum TypePost {
  post,
  trick,
  spot,
  event,
  unavailable,
  fullVideo;
  

  factory TypePost.fromString(String type){
    switch(type){
      case "post":
        return TypePost.post;
      case "event":
        return TypePost.event;
      case "trick":
        return TypePost.trick;
      case "spot":
        return TypePost.spot;
      case "fullVideo":
        return TypePost.fullVideo;
      default:
        return TypePost.unavailable; 
    }
  } 
}

