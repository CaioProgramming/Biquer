import 'dart:developer';

import 'package:Biquer/components/SavingScreen.dart';
import 'package:Biquer/constants.dart';
import 'package:Biquer/model/category/Category.dart';
import 'package:Biquer/model/service/Service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import '../Job.dart';

enum SavingState { SAVING, SAVED, ERROR }

class BicoData extends ChangeNotifier {
  Category category = Category();
  Service service = Service();
  SavingState state = SavingState.SAVING;
  String uid;
  Job bico;

  BicoData(this.uid) {
    bico = Job(userID: uid, price: 0);
  }

  subscribeToService() async {
    var fireStoreInstance = Firestore.instance;
    await fireStoreInstance
        .collection(kCategoryReference)
        .document(category.id)
        .collection(kServiceReference)
        .document(service.id)
        .collection(kBicosReference)
        .document(this.uid)
        .setData(bico.toMap())
        .catchError((onError) {
      print(onError);
      state = SavingState.ERROR;
    }).whenComplete(() {
      state = SavingState.SAVED;
    });
    notifyListeners();
  }

  Widget savingScreen() {
    switch (state) {
      case SavingState.SAVING:
        return SavingScreen(
            message: 'Salvando seu bico', image: kSavingServiceIllustration);
        break;
      case SavingState.SAVED:
        return SavingScreen(
            message: 'Serviço salvo com sucesso!',
            image: kSavedServiceIllustration);
        break;
      case SavingState.ERROR:
        subscribeToService();
        return SavingScreen(
            message:
                'Ocorreu um erro ao salvar seu bico, Estamos verificando o que aconteceu',
            image: kErrorServiceIllustration);
        break;
    }
    return SizedBox();
  }

  updateCategory(Category category) {
    this.category = category;
    notifyListeners();
  }

  updateService(Service service) {
    this.service = service;
    this.bico.price = service.minPrice;
    notifyListeners();
  }

  updateBicoPrice(double newValue) {
    try {
      if (bico == null) bico = Job(userID: uid);
      this.bico.price = newValue;
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }
}
