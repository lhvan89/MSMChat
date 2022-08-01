import '../models/user_model.dart';

class AccountManager {
  AccountManager._instance();

  static final AccountManager instance = AccountManager._instance();

  UserModel currentUser = UserModel.grizzly();

  List<UserModel> userList = [
    UserModel.alligator(),
    UserModel.anteater(),
    UserModel.armadillo(),
    UserModel.auroch(),
    UserModel.axolotl(),
    UserModel.badger(),
    UserModel.bat(),
    UserModel.beaver(),
    UserModel.buffalo(),
    UserModel.camel(),
    UserModel.capybara(),
    UserModel.chameleon(),
    UserModel.cheetah(),
    UserModel.chinchilla(),
    UserModel.chipmunk(),
    UserModel.cormorant(),
    UserModel.coyote(),
    UserModel.crow(),
    UserModel.dingo(),
    UserModel.dinosaur(),
    UserModel.dolphin(),
    UserModel.duck(),
    UserModel.elephant(),
    UserModel.ferret(),
    UserModel.fox(),
    UserModel.frog(),
    UserModel.giraffe(),
    UserModel.gopher(),
    UserModel.grizzly(),
    UserModel.hedgehog(),
    UserModel.hippo(),
    UserModel.hyena(),
    UserModel.ibex(),
    UserModel.ifrit(),
    UserModel.iguana(),
    UserModel.jackal(),
    UserModel.jackalope(),
    UserModel.kangaroo(),
    UserModel.koala(),
    UserModel.kraken(),
    UserModel.lemur(),
    UserModel.leopard(),
    UserModel.liger(),
    UserModel.llama(),
    UserModel.manatee(),
    UserModel.mink(),
    UserModel.monkey(),
    UserModel.moose(),
    UserModel.narwhal(),
    UserModel.nyancat(),
    UserModel.orangutan(),
    UserModel.otter(),
    UserModel.panda(),
    UserModel.penguin(),
    UserModel.platypus(),
    UserModel.pumpkin(),
    UserModel.python(),
    UserModel.quagga(),
    UserModel.rabbit(),
    UserModel.raccoon(),
    UserModel.rhino(),
    UserModel.sheep(),
    UserModel.shrew(),
    UserModel.skunk(),
    UserModel.slowloris(),
    UserModel.squirrel(),
    UserModel.tiger(),
    UserModel.turtle(),
    UserModel.walrus(),
    UserModel.wolf(),
    UserModel.wolverine(),
    UserModel.wombat()
  ];
}
