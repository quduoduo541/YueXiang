import { router } from '@kit.ArkUI'
import {
  addOrder,
  address_list, getAddressByUserId, getProduct, goods, order_data, order_params } from '../api/OrderApi'
import { ApiResult } from '../utils/HttpCore'
import { promptAction } from '@kit.ArkUI'


let customDialogId: number = 0

@Entry
@ComponentV2
struct AddOrder {
  private productId:string=(router.getParams() as order_params)?((router.getParams() as order_params)['productId']):''
  @Local bookList:goods[]=[]
  @Local totalMoney:number=0
  @Local show:boolean=false
  @Local addressList:address_list[]=[]
  @Local addressId:number=0
  @Local address:string=''
  @Local addressName:string=''
  @Local addressPhone:string=''
  @Local addressTag:string=''

  async aboutToAppear(): Promise<void> {
    //立即下单
    if(this.productId){
      const productRes=await getProduct({productId:this.productId}) as ApiResult
      this.bookList=productRes.data.bookList
      this.totalMoney=productRes.data.totalMoney
    }else{
      const productRes=await getProduct() as ApiResult
      this.bookList=productRes.data.bookList
      this.totalMoney=productRes.data.totalMoney
    }

    //获取地址列表
    const addressRes=await getAddressByUserId() as ApiResult
    this.addressList=addressRes.data
  }

@Builder
customDialogBuilder() {
  Column() {
    Text('请选择地址')
      .fontColor('#267acc')
      .fontWeight(FontWeight.Bold)
      .fontSize(20)
      .margin({top:10,bottom:10})
    List({space:10}){
      ForEach(this.addressList,(item:address_list)=>{
        ListItem(){
          Row(){
            Radio({group:'radioGroup',value:'Radio1'}).checked(false)
              .height(22)
              .width(22)
              .onChange((isChecked:boolean)=>{
                if(isChecked){
                  // this.changeFactory(item.id,item.address,item.addressName,item.addressPhone,item.addressTag)
                  this.addressId=item.id
                  this.address=item.address
                  this.addressName=item.addressName
                  this.addressPhone=item.addressPhone
                  this.addressTag=item.addressTag
                }
              })
            Column(){
              Row(){
                Text(item.address)
                  .fontSize(17)
                  .fontWeight(FontWeight.Bold)
              }
              Row(){
                Text(item.addressName)
                Text(item.addressPhone)
                  .margin({left:30}).fontColor('#ff928d8d')
                Text(item.addressTag)
                  .margin({left:10})
                  .backgroundColor('#5e85f4')
                  .fontColor('#fff')
              }
              .margin({top:8})
            }
            .alignItems(HorizontalAlign.Start)
            .width('92%')
          }
          .width('96%')
          .height(100)
          .backgroundColor('#fff')
          .justifyContent(FlexAlign.SpaceBetween)
          .padding({left:10,right:10})
          .borderRadius(10)
        }
        .onClick(()=>{

        })
        .width('100%')
      })
    }
    Row() {
      Button("确认").onClick(() => {
        this.show=true
        promptAction.closeCustomDialog(customDialogId)
      })
      Blank().width(50)
      Button("取消").onClick(() => {
        promptAction.closeCustomDialog(customDialogId)
      })
    }
  }
}

  build() {
    Column() {
      Column(){
        if(!this.show){
          Row(){
            Image($r('app.media.addAddress'))
              .height(30)
              .width(30)
            Text('选择收货地址').margin({left:10})
          }
          .margin({top:23})
          .justifyContent(FlexAlign.Center)
          .width('90%')
        }else {
          Column(){
            Row(){
              Text(this.address)
                .fontSize(17)
                .fontWeight(FontWeight.Bold)
            }
            Row(){
              Text(this.addressName)
              Text(this.addressPhone)
                .margin({left:30}).fontColor('#ff928d8d')
              Text(this.addressTag)
                .margin({left:10})
                .backgroundColor('#5e85f4')
                .fontColor('#fff')
            }
            .margin({top:8})
          }
          .backgroundColor('#fff')
          .width('92%')
          .margin({top:10})
          .alignItems(HorizontalAlign.Start)
        }
      }
      .backgroundColor('#fff')
      .width('95%')
      .height(100)
      .borderRadius(10)
      .margin({top:5})
      .onClick(()=>{
        promptAction.openCustomDialog({
          builder: () => {
            this.customDialogBuilder()
          }
        }).then((dialogId: number) => {
          customDialogId = dialogId
        })
      })

      List(){
        ForEach(this.bookList,(item:goods)=>{
          ListItem(){
            Column({space:10}){
              Row({space:6}){
                Text('自营').fontSize(18).backgroundColor('#e74432').fontColor('#fff')
                Text(item.bookShopName).fontSize(18)
              }
              .margin({top:5})
              .height(30)
              .width('95%')
              Row(){
                Image(item.bookImg)
                  .width(100)
                  .borderRadius(15)
                Column({space:5}){
                  Text(item.bookName)
                    .fontSize(20)
                    .fontWeight(FontWeight.Bold)
                    .width('62%')
                  Row(){
                    Text('买贵双倍赔')
                      .fontColor('#d9503e')
                      .border({
                        width:2,
                        color:'#d7403a'
                      })
                    Text('7天报价')
                      .fontColor('#b58049')
                      .margin({left:8})
                      .border({
                        width:2,
                        color:'#b58049'
                      })
                  }
                  //数量
                  Text('数量:'+item.goodsCount)
                    .fontSize(18)
                  Row(){
                    Text(`￥${item.bookPrice}`)
                      .fontSize(25)
                      .fontColor('#fffc0000')
                      .fontWeight(FontWeight.Bold)
                  }
                }
                .alignItems(HorizontalAlign.Start)
                .margin({left:20})
                .height('100%')
              }
              .height(130)
              .width('95%')
            }
            .backgroundColor('#fff')
            .borderRadius(15)
            .margin({top:10})
            .height(190)
            .width('96%')
          }
        })
      }
      .backgroundColor('#fff')
      .width('95%')
      .height('72%')
      .margin({top:5})
      .borderRadius(10)

      Row(){
        Row(){
          Text('￥')
            .fontSize(16)
            .fontColor('#fffc0000')
          Text(String(this.totalMoney))
            .fontSize(30)
            .fontWeight(FontWeight.Bold)
            .fontColor('#fffc0000')
        }
        Row(){
          Button('提交订单')
            .fontColor('#fff')
            .backgroundColor('#e54433')
            .onClick(()=>{
              AlertDialog.show({
                title:'请确认',
                message:'确认提交此订单吗?',
                autoCancel:true,
                alignment:DialogAlignment.Center,
                offset:{dx:0,dy:0},
                primaryButton:{
                  value:'确定',
                  fontColor:Color.Red,
                  action: async ()=>{
                    const Pdata={
                      addressId:this.addressId,
                      type:!this.productId?'gwc':'buyNow'
                    } as order_data
                    if(this.productId){
                      Pdata.productId=this.productId
                    }
                    const res= await addOrder(Pdata) as ApiResult
                    router.replaceUrl({
                      url:'pages/Pay',
                      params:{
                        totalMoney:res.data.totalMoney,
                        orderNo:res.data.orderNo
                      }
                    })
                  }
                },
                secondaryButton:{
                  value:'取消',
                  action:()=>{}
                }
              })
            })
        }
      }
      .backgroundColor('#fff')
      .height('8%')
      .width('95%')
      .justifyContent(FlexAlign.SpaceBetween)
      .margin({left:5,right:5})
    }
    .backgroundColor('#f6f6f6')
    .height('100%')
    .width('100%')
  }
}