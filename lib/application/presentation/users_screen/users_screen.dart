import 'package:crocsclub_admin/application/business_logic/users/bloc/users_bloc.dart';
import 'package:crocsclub_admin/domain/core/constants/constants.dart';
import 'package:crocsclub_admin/domain/utils/functions/functions.dart';
import 'package:crocsclub_admin/domain/utils/widgets/elevatedbutton_widget.dart';
import 'package:crocsclub_admin/domain/utils/widgets/textwidgets.dart';
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
                    title: SubHeadingTextWidget(title: user.name),
                    subtitle: SubHeadingTextWidget(
                      title: user.email,
                      textColor: kDarkGreyColour,
                    ),
                    trailing: ElevatedButtonWidget(
                      textsize: 12,
                      buttonText: user.blocked == true ? 'unlock' : 'block',
                      onPressed: () {
                        print('the user blocstatus is ${user.blocked}');
                        if (user.blocked == true) {
                          BlocProvider.of<UsersBloc>(context)
                              .add(UnblockUser(user.id));
                          BlocProvider.of<UsersBloc>(context).add(FetchUsers());
                        } else if (user.blocked == false) {
                          BlocProvider.of<UsersBloc>(context)
                              .add(BlockUser(user.id));
                          BlocProvider.of<UsersBloc>(context).add(FetchUsers());
                        }
                      },
                    ),
                  ),
                );
              },
              separatorBuilder: (context, index) => kSizedBoxH10,
              itemCount: state.users.length,
            );
          } else if (state is UsersError) {
            return const Center(
              child: Text('No User Found'),
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
