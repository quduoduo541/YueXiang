import { preferences } from '@kit.ArkData'
import CommonConfig from './CommonConfig'
import PreferenceUtil from './PreferenceUtil'

class TokenUtils {
  // 设置token
  setToken(token) {
    PreferenceUtil.putPreferenceValue(CommonConfig.H_STORE,CommonConfig.LOGIN_TOKEN,token)
  }

  getToken() {
    return PreferenceUtil.getPreferenceValue(CommonConfig.H_STORE,CommonConfig.LOGIN_TOKEN,'')
  }

  clearToken() {
  }

  // 设置用户信息
  setUser(userId:number) {
    PreferenceUtil.putPreferenceValue(CommonConfig.H_STORE,CommonConfig.LOGIN_USERID,userId)
  }

  getUser() {
    return PreferenceUtil.getPreferenceValue(CommonConfig.H_STORE,CommonConfig.LOGIN_USERID,'')
  }

  clearUser() {
  }
}

export default new TokenUtils()
