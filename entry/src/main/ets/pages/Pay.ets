import { promptAction, router } from '@kit.ArkUI';
import { payOrder, pay_params } from '../api/OrderApi';
import { ApiResult } from '../utils/HttpCore';

let customDialogId: number = 0

@Entry
@ComponentV2
struct Pay {
  @Local totalMoney: number=(router.getParams() as pay_params)['totalMoney']
  @Local orderNo:string=(router.getParams() as pay_params)['orderNo']
  @Local payType:string=''
  @Local yhqId:number=-1
  @Local code:string=''

  @Builder
  payItem(img:Resource,bankName:string,payType:string){
    Row(){
      Row(){
        Image(img)
          .height(25)
        Text(bankName)
          .fontColor('#929397')
          .fontSize(18)
          .margin({left:10})
      }
      Blank()
      Row(){
        Radio({group:'radioGroup',value:'radio'}).checked(false)
          .height(22)
          .width(22)
          .onChange((isChecked:boolean)=>{
            if(isChecked){
              this.payType=payType
            }
          })
      }
    }
    .backgroundColor('#fff')
    .width('100%')
    .height(40)
    .padding({left:10,right:10})
    .margin({top:15})

    Divider()
      .width('90%')
  }

  @Builder
  customDialogBuilder(){
    Column(){
      Text('请使用微信扫码支付')
        .fontSize(18)
        .fontWeight(FontWeight.Bold)
        .margin(10)
        .width('100%')
        .padding({bottom:5})
        .border({width:{bottom:1}})
        .borderColor('#999')
      QRCode(this.code).width(140).height(140)
      Text('X')
        .border({width:1})
        .borderRadius('50%')
        .width(20)
        .height(20)
        .margin(20)
        .textAlign(TextAlign.Center)
        .onClick(()=>{
          promptAction.closeCustomDialog(customDialogId)
          router.replaceUrl({
            url:'pages/MyOrder'
          })
        })
    }
  }

  build() {
    Column(){
      Column(){
        Row(){
          Text(`￥${this.totalMoney}`)
            .fontColor('#ffff0000')
            .fontWeight(FontWeight.Bold)
            .fontSize(35)
        }
        .width('100%')
        .height('15%')
        .justifyContent(FlexAlign.Center)

        //支付方式
        Row(){
          Text('支付方式')
            .fontColor('#929397')
            .fontSize(16)
            .margin({bottom:10,left:10})
        }
        .width('100%')
        .justifyContent(FlexAlign.Start)

        List(){
          ListItem(){
            Column(){
              Column(){
                this.payItem($r('app.media.pay_nongye'),'农业银行储蓄卡(9527)','农业银行储蓄卡')
                this.payItem($r('app.media.pay_jianshe'), '建设银行储蓄卡（9527）', '建设银行储蓄卡');
                this.payItem($r('app.media.pay_gongshang'), '工商银行储蓄卡（9527）', '工商银行储蓄卡');
                this.payItem($r('app.media.pay_weixin'), '微信支付', '微信');
                this.payItem($r('app.media.pay_zhifubao'), '支付宝支付', '支付宝');
                this.payItem($r('app.media.pay_userMoney'), '余额支付', '余额');
              }
              .backgroundColor('#fff')
              .borderRadius(20)
              .width('95%')
              .height('68%')
            }
            .width('100%')
          }
        }

        Row(){
          Button('确认付款')
            .borderRadius(20)
            .height(40)
            .width('85%')
            .margin({top:8})
            .backgroundColor('#e8483c')
            .onClick(()=>{
              AlertDialog.show({
                title:'请确认',
                message:'确认付款吗?',
                autoCancel:true,
                alignment:DialogAlignment.Center,
                offset:{dx:0,dy:0},
                primaryButton:{
                  value:'确定',
                  fontColor:Color.Red,
                  action: async () => {
                    const res=await payOrder({orderNo:this.orderNo,type:this.payType,yhqId:this.yhqId}) as ApiResult
                    this.code=res.data.wx_code
                    promptAction.openCustomDialog({
                      builder: () => {
                        this.customDialogBuilder()
                      }
                    }).then((dialogId: number) => {
                      customDialogId = dialogId
                    })
                  }
                },
                secondaryButton: {
                  value: '取消',
                  action: () => {}
                }
              })
            })
        }
      }
      .backgroundColor('#f1f2f6')
      .width('100%')
      .height('100%')
    }
  }
}