import CommonInput from '../components/CommonInput'
import { router } from '@kit.ArkUI'
import { create, login } from '../api/LoginApi';
import { hilog } from '@kit.PerformanceAnalysisKit';
import { ApiResult } from '../utils/HttpCore';
import MyTools from '../utils/MyTools';
import TokenUtils from '../utils/TokenUtils';

@Entry
@Component
struct Index {
  @State userName: string = '';
  @State passWord: string = '';

  async login(): Promise<void>{
    if(this.userName==''){
      return MyTools.alertMsg('请输入账号')
    }
    if(this.passWord==''){
      return MyTools.alertMsg('请输入密码')
    }
    const res =await login({username:this.userName,password:this.passWord}) as ApiResult
    if(res){
      hilog.info(0x0000,'ressss','%{public}s',JSON.stringify(res.data))
      //TODO 未完成
      TokenUtils.setToken(res.data.token)
      TokenUtils.setUser(res.data.userId)
      router.replaceUrl({
        url:"pages/Home"
      })
    }
  }

  build() {
    Column() {
      Image($r('app.media.icon'))
        .width(78)
        .height(78)
        .margin({top:100,bottom:8})
      Text('阅享时光')
        .fontSize(24)
        .fontWeight(FontWeight.Medium)
      Text('登陆账号使用更服务')
        .fontSize(16)
        .fontColor('#666')
        .fontWeight(FontWeight.Medium)
        .margin({top:8,bottom:30})
      //账号
      CommonInput({
        title:'账号',
        icon:$r('app.media.userNameLogo'),
        placeholder:'请输入账号',
        maxLength:11,
        change:(val)=>{
          this.userName=val
        }
      })
      //密码
      CommonInput({
        title:'密码',
        icon:$r('app.media.userPassLogo'),
        placeholder:'请输入密码',
        inputType:InputType.Password,
        maxLength:12,
        change:(val)=>{
          this.passWord=val
        }
      }).margin({top:20})

      //登录按钮
      Button('登录',{type:ButtonType.Capsule})
        .width('90%')
        .height(40)
        .fontSize(16)
        .fontWeight(500)
        .backgroundColor('#007dff')
        .margin({top:80,bottom:12})
        .onClick(()=>{
            this.login()
        })
      Text('注册账号')
        .fontColor('#007dff')
        .fontSize(16)
        .fontWeight(500)
        .onClick(()=>{
          router.pushUrl({
            url:'pages/RegisterPage'
          })
        })
    }
    .width('100%')
    .height('100%')
    .padding({
      left:12,
      right:12
    })
  }
}