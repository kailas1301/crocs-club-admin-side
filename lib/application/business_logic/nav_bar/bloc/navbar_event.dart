part of 'navbar_bloc.dart';

@immutable
sealed class NavbarEvent {}

class HomePressed extends NavbarEvent {}

class AddProductPressed extends NavbarEvent {}

class OffersCouponsPressed extends NavbarEvent {}

class UserPressed extends NavbarEvent {}
