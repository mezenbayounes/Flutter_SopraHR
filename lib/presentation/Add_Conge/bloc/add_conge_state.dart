// ignore_for_file: must_be_immutable

part of 'add_conge_bloc.dart';

/// Represents the state of AddConge in the application.
class AddCongeState extends Equatable {
  AddCongeState({
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

  AddCongeModel? lailyfaFebrinaCardModelObj;

  @override
  List<Object?> get props => [
        cardNumberController,
        expirationDateController,
        securityCodeController,
        cardHolderNameController,
        lailyfaFebrinaCardModelObj,
      ];
  AddCongeState copyWith({
    TextEditingController? cardNumberController,
    TextEditingController? expirationDateController,
    TextEditingController? securityCodeController,
    TextEditingController? cardHolderNameController,
    AddCongeModel? lailyfaFebrinaCardModelObj,
  }) {
    return AddCongeState(
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
