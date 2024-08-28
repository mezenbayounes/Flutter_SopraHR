// ignore_for_file: must_be_immutable

part of 'add_tt_bloc.dart';

/// Represents the state of AddTT in the application.
class AddTTState extends Equatable {
  AddTTState({
    this.cardNumberController,
    this.expirationDateController,
    this.securityCodeController,
    this.cardHolderNameController,
    this.lailyfaFebrinaCardModelObj,
  });

  TextEditingController? cardNumberController;

  TextEditingController? expirationDateController;

  TextEditingController? securityCodeController;

  TextEditingController? cardHolderNameController;

  AddTTModel? lailyfaFebrinaCardModelObj;

  @override
  List<Object?> get props => [
        cardNumberController,
        expirationDateController,
        securityCodeController,
        cardHolderNameController,
        lailyfaFebrinaCardModelObj,
      ];
  AddTTState copyWith({
    TextEditingController? cardNumberController,
    TextEditingController? expirationDateController,
    TextEditingController? securityCodeController,
    TextEditingController? cardHolderNameController,
    AddTTModel? lailyfaFebrinaCardModelObj,
  }) {
    return AddTTState(
      cardNumberController: cardNumberController ?? this.cardNumberController,
      expirationDateController:
          expirationDateController ?? this.expirationDateController,
      securityCodeController:
          securityCodeController ?? this.securityCodeController,
      cardHolderNameController:
          cardHolderNameController ?? this.cardHolderNameController,
      lailyfaFebrinaCardModelObj:
          lailyfaFebrinaCardModelObj ?? this.lailyfaFebrinaCardModelObj,
    );
  }
}
