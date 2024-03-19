part of 'navbar_bloc.dart';

@immutable
sealed class NavbarState {}

final class NavbarInitial extends NavbarState {}

final class HomeSelected extends NavbarState {}

final class AddProductSelected extends NavbarState {}

final class OffersCouponsSelected extends NavbarState {}

final class UserSelected extends NavbarState {}
