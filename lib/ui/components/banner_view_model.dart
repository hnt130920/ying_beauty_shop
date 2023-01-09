import 'package:scoped_model/scoped_model.dart';
import 'package:ying_beauty/model/banner.dart';
import 'package:ying_beauty/utils/app_variables.dart';

class BannerViewModel extends Model {
  static final BannerViewModel _instance = BannerViewModel._internal();
  factory BannerViewModel() => _instance;
  BannerViewModel._internal() {
    updateList();
  }
  List<Banner> banners = [];
  void updateList() async {
    final results = await AppVariable.api.getBanners();
    banners = results.data ?? [];
    notifyListeners();
  }

  void save(Banner banner) async {
    banner.id == 0
        ? await AppVariable.api.addBanner(banner)
        : await AppVariable.api.updateBanner(banner.id, banner);
    updateList();
  }

  List<String> listBannerImg() {
    List<String> bannerImgs = [];
    for (int i = 0; i < banners.length; i++) {
      bannerImgs.add(banners[i].banImg);
    }
    return bannerImgs;
  }

  void delete(Banner banner) async {
    await AppVariable.api.deleteBanner(banner.id);
    updateList();
  }
}
