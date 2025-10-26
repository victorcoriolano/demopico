import 'package:demopico/core/app/theme/theme.dart';
import 'package:demopico/core/common/auth/domain/entities/coletivo_entity.dart';
import 'package:demopico/core/common/auth/domain/entities/user_identification.dart';
import 'package:demopico/features/profile/domain/models/post.dart';
import 'package:flutter/material.dart';


class ColetivoProfilePage extends StatelessWidget {
  final ColetivoEntity coletivo;

  const ColetivoProfilePage({
    super.key,
    required this.coletivo,
  });

  @override
  Widget build(BuildContext context) {
    final List<Post> recs = coletivo.publications
        .where((p) => p.urlVideos != null && p.urlVideos!.isNotEmpty)
        .toList();

    return Scaffold(
      backgroundColor: kBlack,
      body: CustomScrollView(
        slivers: [
          _buildSliverAppBar(context, coletivo),

          // --- Seção de Membros ---
          _SectionHeader(title: 'MEMBROS', cta: 'Ver todos (${coletivo.members.length})', onTap: () {},),
          _MembersListView(members: coletivo.members),

          // --- Seção de Recs (Vídeo Parts) ---
          _SectionHeader(title: 'RECS', cta: 'Ver todas (${recs.length})',onTap: () {}),
          _RecsListView(recs: recs),

          // --- Seção de Atividade (Todos os Posts) ---
          _SectionHeader(title: 'ATIVIDADE DO COLETIVO',onTap: () {}),
          _AllPostsListView(posts: coletivo.publications),
        ],
      ),
    );
  }
}

Widget _buildSliverAppBar(BuildContext context, ColetivoEntity coletivo) {
  final double screenWidth = MediaQuery.of(context).size.width;

  return SliverAppBar(
    expandedHeight: 320.0,
    backgroundColor: kBlack,
    pinned: true, 
    iconTheme: const IconThemeData(color: kRed),
    flexibleSpace: FlexibleSpaceBar(
      title: Text(
        coletivo.nameColetivo,
        style: const TextStyle(color: kRed, fontWeight: FontWeight.bold),
      ),
      centerTitle: true,
      background: Stack(
        fit: StackFit.expand,
        children: [
          ClipPath(
            
            clipper: BottomCurveClipper(),
            child: Image.network(coletivo.logo, fit: BoxFit.cover),
          ),
          ClipPath(
            
            clipper: BottomCurveClipper(),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [kBlack, Colors.transparent],
                  begin: AlignmentGeometry.bottomCenter,
                  end: AlignmentDirectional.topCenter,

                  )
                
              ),
              child: Image.network(coletivo.logo, fit: BoxFit.cover),
            ),
          ),
          

          // 2. O Logo do Coletivo
          Positioned(
            top: 80, // Posição do logo
            left: screenWidth / 2 - 50, // Centralizado
            child: Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: kRedAccent, width: 3), // Borda vermelha
                boxShadow: [
                  BoxShadow(
                    color: kBlack.withValues(alpha: .5),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: CircleAvatar(
                radius: 50,
                backgroundColor: kMediumGrey,
                backgroundImage: NetworkImage(coletivo.logo),
                onBackgroundImageError: (e, s) =>
                    const Icon(Icons.group, size: 50, color: kWhite),
              ),
            ),
          ),

          // 3. Info (Moderador) e Estatísticas
          Positioned(
            top: 30,
            right: 12,
            child: _ColetivoStats(
                members: coletivo.members.length,
                posts: coletivo.publications.length,
                recs: coletivo.publications
                    .where((p) => p.urlVideos != null && p.urlVideos!.isNotEmpty)
                    .length,
              ),
          ),
        ],
      ),
    ),
  );
}

class _ColetivoStats extends StatelessWidget {
  final int members;
  final int posts;
  final int recs;

  const _ColetivoStats({
    required this.members,
    required this.posts,
    required this.recs,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _buildStatItem(members.toString(), 'MEMBROS'),
        _buildStatItem(posts.toString(), 'POSTS'),
        _buildStatItem(recs.toString(), 'RECS'),
      ],
    );
  }

  Widget _buildStatItem(String value, String label) {
    return Column(
      children: [
        Text(
          value,
          style: const TextStyle(
            color: kRedAccent, // Destaque em vermelho
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: const TextStyle(color: kMediumGrey, fontSize: 12),
        ),
      ],
    );
  }
}

// O Clipper para fazer a curva "para dentro"
class BottomCurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0, size.height - 40); // Começa da esquerda, sobe 40px
    path.quadraticBezierTo(
      size.width / 2, // Ponto de controle no meio
      size.height + 40, // Curva "para baixo" (além do tamanho do widget)
      size.width, // Ponto final na direita
      size.height - 40, // Termina na direita, sobe 40px
    );
    path.lineTo(size.width, 0); // Linha reta até o topo direito
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

// Header reutilizável para cada seção
class _SectionHeader extends StatelessWidget {
  final String title;
  final String? cta; // "Call to Action" ex: "Ver todos"
  final VoidCallback? onTap;

  const _SectionHeader({
    required this.title,
    required this.onTap,
    this.cta,
  });

  @override
  Widget build(BuildContext context) {
    debugPrint(onTap.toString());
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: const TextStyle(
                color: kWhite,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            if (cta != null)
              InkWell(
                onTap: onTap,
                child: Text(
                  cta!,
                  style: const TextStyle(color: kRedAccent, fontSize: 13),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

// Lista Horizontal de Membros (substitui "Friends")
class _MembersListView extends StatelessWidget {
  final List<UserIdentification> members;

  const _MembersListView({required this.members});

  @override
  Widget build(BuildContext context) {
    if (members.isEmpty) {
      return const SliverToBoxAdapter(
        child: Center(
          child: Text('Este coletivo ainda não tem membros.', style: TextStyle(color: kMediumGrey)),
        ),
      );
    }
    
    return SliverToBoxAdapter(
      child: SizedBox(
        height: 90,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          itemCount: members.length,
          itemBuilder: (context, index) {
            final member = members[index];
            return SizedBox(
              width: 70,
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 28,
                    backgroundColor: kDarkGrey,
                    backgroundImage: member.profilePictureUrl != null
                        ? NetworkImage(member.profilePictureUrl!)
                        : null,
                    onBackgroundImageError: (e, s) =>
                        const Icon(Icons.person, color: kLightGrey),
                    child: member.profilePictureUrl == null
                        ? const Icon(Icons.person, color: kLightGrey)
                        : null,
                  ),
                  const SizedBox(height: 6),
                  Text(
                    member.name,
                    style: const TextStyle(color: kLightGrey, fontSize: 12),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

// Lista Horizontal de Recs (substitui "Goals")
class _RecsListView extends StatelessWidget {
  final List<Post> recs;

  const _RecsListView({required this.recs});

  @override
  Widget build(BuildContext context) {
    if (recs.isEmpty) {
      return const SliverToBoxAdapter(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 20),
          child: Center(
            child: Text('Nenhuma vídeo part publicada.', style: TextStyle(color: kMediumGrey)),
          ),
        ),
      );
    }

    return SliverToBoxAdapter(
      child: SizedBox(
        height: 140, // Altura do card
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          itemCount: recs.length,
          itemBuilder: (context, index) {
            final post = recs[index];
            // Usa a primeira imagem do post como thumbnail
            final thumbnailUrl =
                post.urlImages.isNotEmpty ? post.urlImages[0] : null;

            return Container(
              width: 200, // Largura do card
              margin: const EdgeInsets.symmetric(horizontal: 4),
              child: Card(
                color: kDarkGrey,
                clipBehavior: Clip.antiAlias,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    // Thumbnail
                    if (thumbnailUrl != null)
                      Image.network(
                        thumbnailUrl,
                        fit: BoxFit.cover,
                        color: kBlack.withOpacity(0.3), // Escurece a imagem
                        colorBlendMode: BlendMode.darken,
                      )
                    else
                      Container(color: kMediumGrey.withOpacity(0.3)),
                    
                    // Ícone de "Play"
                    const Center(
                      child: Icon(Icons.play_circle_outline, color: kWhite, size: 50),
                    ),
                    
                    // Descrição
                    Positioned(
                      bottom: 8,
                      left: 8,
                      right: 8,
                      child: Text(
                        post.description,
                        style: const TextStyle(
                          color: kWhite,
                          fontWeight: FontWeight.bold,
                          shadows: [
                            Shadow(color: kBlack, blurRadius: 4, offset: Offset(0, 1))
                          ],
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}

// Lista Vertical de Todos os Posts
class _AllPostsListView extends StatelessWidget {
  final List<Post> posts;

  const _AllPostsListView({required this.posts});

  @override
  Widget build(BuildContext context) {
    if (posts.isEmpty) {
      return const SliverFillRemaining( // Ocupa o resto da tela
        child: Center(
          child: Text('Nenhuma atividade no coletivo.', style: TextStyle(color: kMediumGrey)),
        ),
      );
    }
    
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          final post = posts[index];
          // Aqui você usaria seu widget de Card de Post
          // Vou criar um placeholder:
          return _PostCardWidget(post: post);
        },
        childCount: posts.length,
      ),
    );
  }
}

// Card de Post (Placeholder - ajuste conforme seu app)
class _PostCardWidget extends StatelessWidget {
  final Post post;

  const _PostCardWidget({required this.post});

  @override
  Widget build(BuildContext context) {
    final thumbnailUrl = post.urlImages.isNotEmpty ? post.urlImages[0] : null;

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: kDarkGrey,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header do Post (Autor)
          Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundColor: kMediumGrey,
                  backgroundImage:
                      post.avatar != null ? NetworkImage(post.avatar!) : null,
                  child: post.avatar == null
                      ? const Icon(Icons.person, color: kDarkGrey)
                      : null,
                ),
                const SizedBox(width: 10),
                Text(
                  post.nome, // Nome do autor do post
                  style: const TextStyle(
                      color: kWhite, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          
          // Imagem do Post
          if (thumbnailUrl != null)
            AspectRatio(
              aspectRatio: 16 / 9,
              child: Image.network(thumbnailUrl, fit: BoxFit.cover),
            ),
            
          // Descrição
          Padding(
            padding: const EdgeInsets.all(12),
            child: Text(
              post.description,
              style: const TextStyle(color: kLightGrey),
            ),
          ),
        ],
      ),
    );
  }
}