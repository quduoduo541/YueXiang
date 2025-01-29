import { router } from '@kit.ArkUI'
import { address_params } from '../api/BookApi'
import { addAddress, address_item, address_list } from '../api/OrderApi'

@Extend(TextInput) function myInputStyle(){
  .placeholderColor('#99000000')
  .height(40)
  .backgroundColor('#f6f6f6')
  .width('78%')
  .padding({left:10})
  .borderRadius(10)
}
@Entry
@ComponentV2
struct AddAddress {
  @Local addressName:string=''
  @Local addressPhone:string=''
  @Local address:string=''
  @Local choiceFlag1:boolean=false
  @Local choiceFlag2:boolean=false
  @Local choiceFlag3:boolean=false
  @Local addressTag:string=''
  @Local addressId:number=0
  private addressItemString?:string=(router.getParams() as address_item)['addressItem']
  private addressItem:address_list={} as address_list

  aboutToAppear(): void {
    if(this.addressItemString){
      this.addressItem=JSON.parse(this.addressItemString)
      this.addressId=this.addressItem.id
      this.addressName=this.addressItem.addressName
      this.addressPhone=this.addressItem.addressPhone
      this.address=this.addressItem.address
      this.addressTag=this.addressItem.addressTag
      if(this.addressTag=='家'){
        this.choiceFlag1=true
      }else if(this.addressTag=='公司'){
        this.choiceFlag2=true
      }else if(this.addressTag=='学校'){
        this.choiceFlag3=true
      }
    }
  }

  onPageShow(): void {
    const address=(router.getParams() as address_params)['address']
    if(address){
      this.address=address
    }
  }

  build() {
    Column() {
      Column({space:10}){
        Row(){
          Text('收货人')
          TextInput({placeholder:'请填写收货人姓名',text:this.addressName})
            .myInputStyle()
            .maxLength(20)
            .onChange((value)=>{
              this.addressName=value
            })
        }
        .margin({top:10})
        .padding({left:5,right:5})
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)

        Row(){
          Text("手机号码")
          TextInput({placeholder:'请填写收货人手机号',text:this.addressPhone})
            .myInputStyle()
            .maxLength(11)
            .onChange((value)=>{
              this.addressPhone=value
            })
        }
        .margin({top:10})
        .padding({left:5,right:5})
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)

        Row(){
          Column(){
            Text('详细地址')
          }
          Stack({alignContent:Alignment.BottomEnd}){
            TextArea({placeholder:'请填写收货人详细地址',text:this.address})
              .placeholderColor('#99000000')
              .height(130)
              .backgroundColor('#f6f6f6')
              .width('78%')
              .padding({left:10})
              .borderRadius(10)
              .onChange((value)=>{
                this.address=value
              })
            Button('选择地址')
              .onClick(()=>{
                router.pushUrl({
                  url:'pages/AddressMap'
                })
              })
          }
        }
        .height('20%')
        .margin({top:10})
        .padding({left:5,right:5})
        .width('100%')
        .justifyContent(FlexAlign.SpaceBetween)

        Row(){
          Column(){
            Text('标签')
          }
          .width('22%')
          .height('85%')
          Row(){
            Radio({value:'Radio1',group:'radioGroup'})
              .checked(this.choiceFlag1)
              .height(23)
              .onChange((isChecked:boolean)=>{
                if(isChecked){
                  this.addressTag='家'
                }
              })
            Text('家').fontColor('#182431').fontSize(16).margin({left:5})

            Radio({value:'Radio2',group:'radioGroup'})
              .checked(this.choiceFlag2)
              .height(23)
              .onChange((isChecked:boolean)=>{
                if(isChecked){
                  this.addressTag='公司'
                }
              })
            Text('公司').fontColor('#182431').fontSize(16).margin({left:5})

            Radio({value:'Radio3',group:'radioGroup'})
              .checked(this.choiceFlag3)
              .height(23)
              .onChange((isChecked:boolean)=>{
                if(isChecked){
                  this.addressTag='学校'
                }
              })
            Text('学校').fontColor('#182431').fontSize(16).margin({left:5})
          }
          .width('75%')
        }
        .height('3%')
        .margin({top:15})
        .padding({left:5,right:5})
        .width('100%')
      }
      .margin({top:10})
      .width('95%')
      .height('80%')
      .borderRadius(10)

      Column(){
        Button('保存')
          .width('80%')
          .height(42)
          .borderRadius(35)
          .onClick(async ()=>{
            await addAddress({
              id:this.addressId,
              addressName:this.addressName,
              addressPhone:this.addressPhone,
              address:this.address,
              addressTag:this.addressTag
            })
            router.back()
          })
      }
      .layoutWeight(1)
      .justifyContent(FlexAlign.Center)

    }
    .height('100%')
    .width('100%')
  }
}