import { it } from '@ohos/hypium';
import { getOrderListByUserId, order, payOrder } from '../api/OrderApi';
import Empty from '../components/Empty';
import { ApiResult } from '../utils/HttpCore';
import { promptAction, router } from '@kit.ArkUI';

let customDialogId: number = 0

@Entry
@ComponentV2
struct MyOrder {
  @Local message: string = 'Hello World';
  private controller:TabsController=new TabsController()
  @Local currentIndex:number=0
  @Local fontColor:string='#182431'
  @Local selectedFontColor:string='#007dff'
  @Local bookList1:order[]=[]
  @Local bookList2:order[]=[]
  @Local code:string=''

  @Builder
  TabBuilder(index:number,name:string){
    Column(){
      Text(name)
        .fontSize(16)
        .lineHeight(20)
        .margin({top:16,bottom:8})
        .fontColor(this.currentIndex==index?this.selectedFontColor:this.fontColor)
        .fontWeight(this.currentIndex==index?500:400)
      Divider()
        .strokeWidth(2)
        .color('#007dff')
        .opacity(this.currentIndex==index?1:0)
    }.width('100%')
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

  @Builder
  GoodsRow(item:order,payType:string,buttonString?:string){
    Column(){
      Row(){
        Text(payType)
          .fontColor('#a8a8a8')
      }
      .padding({left:8,right:8})
      .justifyContent(FlexAlign.SpaceBetween)
      .width('100%')
      .margin({top:10})
      Divider().margin({top:7})
        .width('98%')
      Row(){
        Row(){
          Image(item.bookImg)
            .width(80)
            .height(80)
            .margin({left:5})
            .borderRadius(12)
          Text(item.bookName)
            .margin({left:5})
            .width('60%')
            .fontSize(18)
            .fontWeight(FontWeight.Bold)
        }
        .width('76%')

        Column(){
          if(payType=='待支付'||payType=='已取消'){
            Text(`￥${item.bookPrice}`)
              .fontSize(20)
              .fontWeight(FontWeight.Bold)
              .fontColor('#ffff0000')
          }else {
            Text(`￥${item.payMoney}`)
              .fontSize(20)
              .fontWeight(FontWeight.Bold)
              .fontColor('#ffff0000')
          }
          Text(`共${item.goodsCount}件`).fontColor('#a8a8a8')
        }
        .alignItems(HorizontalAlign.End)
      }
      .width('100%')
      .margin({top:8})

      Row(){
        Text(`订单编号:${item.orderNo}`)
          .fontColor('#111111')
          .fontSize(16)
          .margin({top:10,left:6})
        if(item.useYhq==1){
          Text('优惠券')
            .fontSize(12)
            .backgroundColor('ffff0000')
            .fontColor('#fff')
            .margin({left:10})
        }
      }
      .justifyContent(FlexAlign.Start)
      .height(28)
      .width('100%')

      Row(){
        if(buttonString){
          Button(buttonString)
            .width('30%')
            .height(35)
            .backgroundColor('#2f99ff')
            .fontColor('#fff')
            .borderRadius(20)
            .onClick(async ()=>{
              const res =await payOrder({orderNo:item.orderNo,type:'微信',yhqId:-1}) as ApiResult
              this.code=res.data.wx_code
              promptAction.openCustomDialog({
                builder: () => {
                  this.customDialogBuilder()
                }
              }).then((dialogId: number) => {
                customDialogId = dialogId
              })
            })
        }
      }
      .width('100%')
      .justifyContent(FlexAlign.End)
    }
    .backgroundColor('#fff')
    .height(220)
    .width('96%')
    .borderRadius(20)
    .margin({top:15})
  }
  aboutToAppear(): void {
    this.initData()
  }

  async initData(){
    const res=await getOrderListByUserId() as ApiResult
    this.bookList1=res.data.bookList1
    this.bookList2=res.data.bookList2
  }

  build() {
    Column(){
      Image($r('app.media.refresh'))
        .width(40)
        .height(40)
        .offset({x:175,y:0})
        .onClick(()=>{

        })

      Column(){
        Tabs({barPosition:BarPosition.Start,controller:this.controller}){
          TabContent(){
            if(this.bookList1.length){
              List(){
                ForEach(this.bookList1,(item:order)=>{
                  ListItem(){
                    Column(){
                      this.GoodsRow(item,"已支付")
                    }
                    .width('100%')
                  }
                })
              }
              .height('90%')
              .margin({bottom:62})
            }else {
              Empty({title:'暂无订单,赶紧去下单吧'})
            }
          }.tabBar(this.TabBuilder(0,'已支付'))
          TabContent(){
            if(this.bookList2.length){
              List(){
                ForEach(this.bookList1,(item:order)=>{
                  ListItem(){
                    Column(){
                      if(item.order_status==2){
                        this.GoodsRow(item,'待支付','去付款')
                      }else if(item.order_status==4){
                        this.GoodsRow(item,'已取消')
                      }
                    }
                    .width('100%')
                  }
                })
              }
              .height('90%')
              .margin({bottom:62})
            }else {
              Empty({title:'暂无订单,赶紧去下单吧'})
            }
          }.tabBar(this.TabBuilder(1,'待支付/已取消'))
        }
        .onChange((index:number)=>{
          this.currentIndex=index
        })
      }
    }.backgroundColor('#f1f3f5')
    .width('100%')
    .height('100%')
  }
}