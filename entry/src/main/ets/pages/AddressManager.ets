import Empty from '../components/Empty'
import { router } from '@kit.ArkUI'
import { address_list, getAddressByUserId } from '../api/OrderApi'
import { ApiResult } from '../utils/HttpCore'

@Entry
@ComponentV2
struct AddressManager {
  @Local addressList:address_list[]=[]

  async onPageShow(): Promise<void> {
    //请求后台接口获取地址列表数据
    const res=await getAddressByUserId() as ApiResult
    this.addressList=res.data
  }

  build() {
    Column() {
      if(!this.addressList.length){
        Empty({title:'暂无地址'})
      }else{
        List({space:10}){
          ForEach(this.addressList,(item:address_list)=>{
            ListItem(){
              Row(){
                Column(){
                  Row(){
                    Text(item.address)
                      .fontSize(17)
                      .fontWeight(FontWeight.Bold)
                  }
                  Row(){
                    Text(item.addressName)
                    Text(item.addressPhone)
                      .margin({left:30})
                      .fontColor('#ff928d8d')
                    Text(item.addressTag)
                      .margin({left:10})
                      .backgroundColor('#5e85f4')
                      .fontColor('#fff')
                  }
                  .margin({top:8})
                }
                .alignItems(HorizontalAlign.Start)
                .width('92%')

                Column(){
                  Image($r('app.media.edit'))
                    .height(30)
                    .onClick(()=>{
                      router.pushUrl({
                        url:'pages/AddAddress',
                        params:{addressItem:JSON.stringify(item)}
                      })
                    })
                }
              }
              .height(100)
              .backgroundColor('#fff')
              .padding({left:10,right:10})
              .width('96%')
              .borderRadius(10)
              .justifyContent(FlexAlign.SpaceBetween)
            }.width('100%')
          })
        }.height('87%')
      }
      Column(){
        Button('新建收货地址')
          .borderRadius(35)
          .height(50)
          .backgroundColor('#dc3a25')
          .onClick(()=>{
            router.pushUrl({
              url:'pages/AddAddress',
              params:{addressItem:''}
            })
          })
      }
      .layoutWeight(1)
      .justifyContent(FlexAlign.Center)
    }
    .backgroundColor('#f2f2f2')
    .height('100%')
    .width('100%')
  }
}