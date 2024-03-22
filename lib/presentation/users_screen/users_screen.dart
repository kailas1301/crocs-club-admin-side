import 'package:crocsclub_admin/business_logic/users/bloc/users_bloc.dart';
import 'package:crocsclub_admin/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UsersScreen extends StatelessWidget {
  const UsersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<UsersBloc>(context).add(FetchUsers());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Users'),
      ),
      body: BlocBuilder<UsersBloc, UsersState>(
        builder: (context, state) {
          if (state is UsersLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is UsersLoaded) {
            return ListView.separated(
              itemBuilder: (context, index) {
                final user = state.users[index];
                return ListTile(
                  title: Text(user.name),
                  subtitle: Text(user.email),
                  trailing: ElevatedButton(
                    onPressed: () {},
                    child: Text(user.blockStatus ? 'Block' : 'Unblock'),
                  ),
                );
              },
              separatorBuilder: (context, index) => kSizedBoxH10,
              itemCount: state.users.length,
            );
          } else if (state is UsersError) {
            return Center(
              child: Text('Error: ${state.error}'),
            );
          } else {
            return const Center(
              child: Text('Data could not be fetched'),
            );
          }
        },
      ),
    );
  }
}
