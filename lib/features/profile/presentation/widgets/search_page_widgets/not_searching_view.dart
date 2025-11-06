import 'package:demopico/core/app/theme/theme.dart';
import 'package:demopico/features/profile/presentation/view_model/collective_view_model.dart';
import 'package:demopico/features/profile/presentation/widgets/profile_data/collective_list_widget.dart';
import 'package:demopico/features/profile/presentation/widgets/search_page_widgets/container_suggestion_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

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
                          'Coletivos',
                          style: textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: theme.colorScheme.primary,
                          ),
                        ),
                      ),
                      
                      const SizedBox(height: 10,),
                      
                      SizedBox(
                        height: 150,
                        child: Consumer<CollectiveViewModel>(
                          builder: (context, vm, child) {
                            if (vm.isLoading){
                              return Center(child: CircularProgressIndicator(),);
                            }
                            return  CollectiveListWidget(coletivos: vm.allCollectives,);
                          }
                        ),
                      ),
                      
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