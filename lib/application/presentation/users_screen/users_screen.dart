import 'package:crocsclub_admin/application/business_logic/users/bloc/users_bloc.dart';
import 'package:crocsclub_admin/domain/core/constants/constants.dart';
import 'package:crocsclub_admin/domain/utils/functions/functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class UsersScreen extends StatelessWidget {
  const UsersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<UsersBloc>(context).add(FetchUsers());

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return const Column(
                      children: [Text('do you want tologout')],
                    );
                  },
                );
                adminlogout(context);
              },
              icon: const Icon(Icons.logout))
        ],
        centerTitle: true,
        title: Text(
          'Users',
          style: GoogleFonts.roboto(
            fontSize: 20,
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: BlocConsumer<UsersBloc, UsersState>(
        builder: (context, state) {
          if (state is UsersLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is UsersLoaded) {
            return ListView.separated(
              itemBuilder: (context, index) {
                final user = state.users[index];
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ListTile(
                    title: Text(user.name),
                    subtitle: Text(user.email),
                    trailing: ElevatedButton(
                      onPressed: () {
                        print('the user blocstatus is ${user.blockStatus}');
                        if (user.blockStatus == true) {
                          BlocProvider.of<UsersBloc>(context)
                              .add(UnblockUser(user.id));
                          BlocProvider.of<UsersBloc>(context).add(FetchUsers());
                        } else if (user.blockStatus == false) {
                          BlocProvider.of<UsersBloc>(context)
                              .add(BlockUser(user.id));
                          BlocProvider.of<UsersBloc>(context).add(FetchUsers());
                        }
                      },
                      child:
                          Text(user.blockStatus == true ? 'unlock' : 'block'),
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) => kSizedBoxH10,
              itemCount: state.users.length,
            );
          } else if (state is UsersError) {
            return const Center(
              child: Text('data was not found'),
            );
          } else {
            return const Center(
              child: Text('Data could not be fetched'),
            );
          }
        },
        listener: (context, state) {
          if (state is UserBlocked) {
            showCustomSnackbar(context, 'user successfully blocked.',
                kblackColour, kwhiteColour);
          } else if (state is UserUnblocked) {
            showCustomSnackbar(context, 'user successfully unblocked.',
                kblackColour, kwhiteColour);
          }
        },
      ),
    );
  }
}
