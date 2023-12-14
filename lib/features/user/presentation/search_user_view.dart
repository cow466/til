import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:til/features/authentication/data/logged_in_user_provider.dart';
import 'package:til/features/loading/presentation/loading_view.dart';
import 'package:til/features/user/data/user_db_provider.dart';
import 'package:til/features/user/domain/user.dart';
import 'package:til/features/user/presentation/other_profile_view.dart';

class SearchUserView extends ConsumerStatefulWidget {
  const SearchUserView({super.key});

  static const routeName = '/search-user';

  @override
  ConsumerState<SearchUserView> createState() => _SearchUserViewState();
}

class _SearchUserViewState extends ConsumerState<SearchUserView> {
  @override
  Widget build(BuildContext context) {
    final usersFuture = ref.watch(userDBProvider).getAll();
    final loggedInUserAsync = ref.watch(loggedInUserProvider);
    if (loggedInUserAsync is! AsyncData) {
      return const LoadingView();
    }
    final loggedInUser = loggedInUserAsync.asData?.value;
    if (loggedInUser == null) {
      return const LoadingView();
    }
    return FutureBuilder(
      future: usersFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.hasData) {
          final allUsers = snapshot.data as List<User>;
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SearchAnchor(
                  builder: (context, controller) {
                    return SearchBar(
                      controller: controller,
                      padding: const MaterialStatePropertyAll<EdgeInsets>(
                          EdgeInsets.symmetric(horizontal: 16.0)),
                      onTap: () {
                        controller.openView();
                      },
                      onChanged: (_) {
                        controller.openView();
                      },
                      leading: const Icon(Icons.search),
                    );
                  },
                  suggestionsBuilder: (context, controller) {
                    // TODO(winstonco): do query here instead of pulling all users
                    final tempUsers = allUsers
                        .where((user) => user.name != loggedInUser.name)
                        .where((user) => user.name.startsWith(controller.text));
                    return tempUsers.map(
                      (e) => ListTile(
                        title: Text(e.name),
                        onTap: () {
                          setState(() {
                            controller.closeView(e.name);
                            context.go(
                              OtherProfileView.routeName
                                  .replaceFirst(':id', e.id),
                            );
                          });
                        },
                      ),
                    );
                  },
                ),
              )
            ],
          );
        }
        return const LoadingView();
      },
    );
  }
}
