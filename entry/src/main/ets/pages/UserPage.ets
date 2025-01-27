import { getUserInfoById, user_info } from "../api/UserApi"
import { ApiResult } from "../utils/HttpCore"
import { router } from "@kit.ArkUI"

@ComponentV2
export default struct UserPage {
  @Local userInfo: user_info ={} as user_info

  async aboutToAppear(): Promise<void> {
    const res=await getUserInfoById() as ApiResult
    this.userInfo=res.data
  }

  @Builder ColumnItem (itemImage:Resource,itemName:string){
    Column(){
      Image(itemImage)
        .width(30)
        .height(30)
      Text(itemName)
        .margin({top:4})
        .fontSize(12)
        .fontColor('#ff8c8989')
    }
    .onClick(()=>{
      if(itemName=='收货地址'){
        router.pushUrl({
          url:'pages/AddressManager'
        })
      }else if(itemName=='我的订单'){
        router.pushUrl({
          url:'pages/MyOrder'
        })
      }else if(itemName=='优惠券'){
        router.pushUrl({
          url:'pages/Youhuiquan'
        })
      }
    })
  }

  @Builder RowItem(itemImage:Resource,itemName:string,topValue:number){
    Row(){
      Image(itemImage)
        .width(40)
        .height(40)
        .margin({bottom:10})
      Column(){
        Row(){
          Text(itemName)
            .fontWeight(FontWeight.Bold)
            .fontSize(17)
            .margin({left:10})
          Blank()
          Image($r('app.media.right'))
            .height(30)
            .width(40)
        }
        .width('90%')
        .justifyContent(FlexAlign.SpaceBetween)
        Divider()
          .width('90%')
          .margin({top:10})
      }
    }
    .width('90%')
    .margin({top:topValue})
    .onClick(()=>{})
  }

  build() {
    Column(){
      Stack({alignContent:Alignment.Bottom}){
        //背景
        Image($r('app.media.myinfo_background'))
          .width('100%')
        Image(this.userInfo.userImg)
          .borderRadius(50)
          .borderWidth(2)
          .borderColor('#fff')
          .width(100)
          .height(100)
          .position({x:10,y:10})
        Text(this.userInfo.userPhone)
          .fontSize(20)
          .margin({left:10})
          .fontColor('#fff')
          .position({x:120,y:120})
        Text(this.userInfo.nickName)
          .fontSize(18)
          .margin({left:10})
          .fontColor('#ffc0dcdc')
          .position({x:120,y:150})
        Row(){
          this.ColumnItem($r('app.media.myorder'),'订单')
          this.ColumnItem($r('app.media.youhuiquan'),'优惠券')
          this.ColumnItem($r('app.media.address'),'收货地址')
        }
        .justifyContent(FlexAlign.SpaceAround)
        .borderRadius(10)
        .shadow({radius:10,color:'#ffc1bebe',offsetX:5,offsetY:10})
        .width('92%')
        .height(80)
        .backgroundColor('#fff')
      }
      .width('100%')
      this.RowItem($r('app.media.jiaoliu'),'交流反馈',30)
      this.RowItem($r('app.media.mymsg'),'我的消息',15)
      this.RowItem($r('app.media.aboutus'),'关于我们',15)
      this.RowItem($r('app.media.kefu'),'客服',15)
      this.RowItem($r('app.media.yaoqinghaoyou'),'邀请好友',15)
      this.RowItem($r('app.media.logout'),'退出',15)
    }
    .backgroundColor('#fff')
    .width('100%')
    .height('100%')
  }
}