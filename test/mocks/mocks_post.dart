import 'package:demopico/features/external/datasources/firebase/dto/firebase_dto_mapper.dart';
import 'package:demopico/features/profile/domain/models/post.dart';

Post mockPost1 = Post(
    id: "123",
      spotID: "spot123",
    nome: 'João Silva',
    userId: 'user123',
    urlUserPhoto: 'https://example.com/user_photo.jpg',
    description: 'Curtindo um dia de sol no parque!',
    urlMidia: [
      'https://firebasestorage.googleapis.com/v0/b/pico-skatepico.appspot.com/o/spots_images%2Fimages%2FDegrau%20no%20Centro%20.jpg?alt=media&token=2dda3751-c51e-4981-875d-5ab7c92cbded',
      'https://firebasestorage.googleapis.com/v0/b/pico-skatepico.appspot.com/o/spots_images%2Fimages%2FPico%20top.jpg?alt=media&token=1a489ff1-0c61-4e31-b793-117c46ced16f'
    ],
    dateTime: DateTime.now(),
    curtidas: 42,
  );

Post mockPost2 = Post(
      id: "456",
        spotID: "spot123",
    nome: 'Tete da Silva',
    userId: 'user123',
    urlUserPhoto: 'https://example.com/user_photo.jpg',
    description: 'Curtindo um dia de sol no parque!',
    urlMidia: [
      'https://firebasestorage.googleapis.com/v0/b/pico-skatepico.appspot.com/o/spots_images%2Fimages%2FPico%20top.jpg?alt=media&token=1a489ff1-0c61-4e31-b793-117c46ced16',

    ],
    dateTime: DateTime.now(),
    curtidas: 42,
  );

  var mapper = FirebaseDtoMapper<Post>(
    fromJson: (data, id) => Post.fromJson(data, id),
    toMap: (model) => model.toJson(),
    getId: (model) => model.id);

  final listPost = [mockPost1, mockPost2];

  final   listDto = listPost.map(
    (post) => mapper.toDTO(post)).toList();