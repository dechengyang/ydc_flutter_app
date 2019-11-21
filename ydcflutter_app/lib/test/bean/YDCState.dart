
import 'package:ydcflutter_app/me/bean/User.dart';
import 'package:ydcflutter_app/redux/user_redux.dart';
///全局Redux store 的对象，保存State数据
class YDCState {
  ///用户信息
  User user;

  ///构造方法
  YDCState({this.user});
}

///创建 Reducer
///源码中 Reducer 是一个方法 typedef State Reducer<State>(State state, dynamic action);
///我们自定义了 appReducer 用于创建 store
YDCState appReducer(YDCState state, action) {
  return YDCState(
    ///通过自定义 UserReducer 将 YDCState 内的 userInfo 和 action 关联在一起
    user: UserReducer(state.user, action),

  );
}

