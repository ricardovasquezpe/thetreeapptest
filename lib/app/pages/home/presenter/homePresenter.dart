import 'package:thetreeapptest/app/models/company.dart';
import 'package:thetreeapptest/app/pages/home/interactor/homeInteractor.dart';
import 'package:thetreeapptest/app/pages/home/presenter/ihomePresenter.dart';
import 'package:thetreeapptest/app/pages/home/view/homeView.dart';

class HomePresenter implements iHomePresenter{
  HomeView? _homeView;
  HomeInteractor? _homeInteractor;

  HomePresenter(HomeView view){
    _homeInteractor = new HomeInteractor(this);
    _homeView = view;
  }

  void tryGetCompanyList(){
    _homeInteractor?.getListCompany();
  }

  @override
  onSuccessGetCompanies(List<Company> list) {
    _homeView?.onSuccessGetCompanies(list);
  }
}