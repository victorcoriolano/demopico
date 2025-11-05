import 'package:demopico/core/app/theme/theme.dart';
import 'package:demopico/features/profile/presentation/widgets/search_page_widgets/container_suggestion_widget.dart';
import 'package:demopico/features/profile/presentation/widgets/search_page_widgets/historic_profile_list.dart';
import 'package:flutter/material.dart';

class NotSearchingView extends StatelessWidget {

  const NotSearchingView({ super.key });

   @override
   Widget build(BuildContext context) {
        final theme = Theme.of(context);
    final textTheme = theme.textTheme;
       return Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 18),
                      Padding(
                        padding: const EdgeInsets.only(left: 4),
                        child: Text(
                          'Histórico',
                          style: textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: theme.colorScheme.primary,
                          ),
                        ),
                      ),
                      
                      const SizedBox(height: 18,),
                      
                      const HistoricHorizontalList(),
                      
                      const SizedBox(height: 10,),
                      
                      Padding(
                        padding: const EdgeInsets.only(left: 4),
                        child: Text(
                          'Sugestões para você',
                          style: textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: theme.colorScheme.primary,
                          ),
                        ),
                      ),
                      
                      const SizedBox(height: 6),
                      
                      Divider(
                        thickness: 0.6,
                        color: kDarkGrey,
                      ),
                      
                      const SizedBox(height: 8),
                      
                      Expanded(
                        child: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 400),
                          child: ContainerSuggestionWidget(key: ValueKey(DateTime.now())),
                        ),
                      ),
                    ],
                  ),
                );
  }
}