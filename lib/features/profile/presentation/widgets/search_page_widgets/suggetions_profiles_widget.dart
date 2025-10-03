import 'package:cached_network_image/cached_network_image.dart';
import 'package:demopico/core/app/theme/theme.dart';
import 'package:demopico/core/common/auth/domain/entities/user_entity.dart';
import 'package:demopico/core/common/errors/domain_failures.dart';
import 'package:demopico/core/common/errors/failure_server.dart';
import 'package:demopico/features/profile/presentation/services/verify_auth_and_get_user.dart';
import 'package:demopico/features/profile/presentation/view_model/network_view_model.dart';
import 'package:demopico/features/profile/presentation/view_objects/suggestion_profile.dart';
import 'package:demopico/features/user/presentation/controllers/auth_view_model_account.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SuggestionProfilesWidget extends StatefulWidget {
  final SuggestionProfile suggestionProfile;

  const SuggestionProfilesWidget({
    super.key,
    required this.suggestionProfile,
  });

  @override
  State<SuggestionProfilesWidget> createState() => _SuggestionProfilestState();
}

class _SuggestionProfilestState extends State<SuggestionProfilesWidget> {
  

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 4),
      width: screenWidth * 0.9,
      height: 80,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withValues(alpha: 0.3),
            spreadRadius: 1,
            blurRadius: 5,
            offset: const Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircleAvatar(
                  backgroundImage: widget.suggestionProfile.photo != null
                      ? CachedNetworkImageProvider(widget.suggestionProfile.photo!, errorListener: (error) => const Icon(Icons.error))
                      : null,
                  radius: 20,
                ),
                SizedBox(
                  height: 8,
                ),
                Text(
                  widget.suggestionProfile.name,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),
          ElevatedButton(
            onPressed: () {
              final currentUser = context.read<AuthViewModelAccount>().user;
              switch (currentUser) {
                
                case UserEntity():
                  context.read<NetworkViewModel>().requestConnection(widget.suggestionProfile, currentUser);

                case AnonymousUserEntity():
                  FailureServer.showError(UnauthenticatedFailure());
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: widget.suggestionProfile.status.statusForSuggestions == 'Conectar'
                  ? kRed
                  : kMediumGrey,
            ),
            child: Text(widget.suggestionProfile.status.statusForSuggestions),
          ),
        ],
      ),
    );
  }
}
