import { promptAction } from '@kit.ArkUI'
import BigNumber from 'bignumber.js'

class MyTools{
  alertMsg(message:string){
    promptAction.showToast({
      message,
      duration:2000,
      bottom:50
    })
  }

  //加法
  plus(a:number,b:number){
    return new BigNumber(a).plus(b).toNumber()
  }

  //减法
  minus(a:number,b:number){
    return new BigNumber(a).minus(b).toNumber()
  }

  //乘法
  multiply(a:number,b:number){
    return new BigNumber(a).times(b).toNumber()
  }
}

const Mytools=new MyTools()
export default Mytools