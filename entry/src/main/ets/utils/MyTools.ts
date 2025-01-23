import { promptAction } from '@kit.ArkUI'

class MyTools{
  alertMsg(message:string){
    promptAction.showToast({
      message,
      duration:2000,
      bottom:50
    })
  }
}

export default new MyTools()