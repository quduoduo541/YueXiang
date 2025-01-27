import { getCarDataList, goods } from "../api/OrderApi"
import { ApiResult } from "../utils/HttpCore"
import GoodsItem from "../components/GoodsItem"
import { router } from "@kit.ArkUI"
import Mytools from '../utils/MyTools'

@ComponentV2
export default struct ShopCar {
  @Local bookList:goods[]=[]
  @Local choiceCount:number=0
  @Local totalMoney:number=0
  //选中商品
  @Local bookChoiceList:goods[]=[]

  aboutToAppear(): void {
    this.getCarData()
  }

  async getCarData(){
    const res=await getCarDataList() as ApiResult
    this.bookList=res.data.bookList
    this.choiceCount=res.data.choiceCount
    this.totalMoney=res.data.totalMoney
  }

  build() {
    Column() {
        Image($r('app.media.refresh'))
          .width(40)
          .height(40)
          .offset({x:175,y:0})
          .onClick(()=>{
            this.getCarData()
          })
        List(){
          ForEach(this.bookList,(item:goods)=>{
            ListItem(){
              GoodsItem({
                item:item,
                choiceCount:this.choiceCount,
                totalMoney:this.totalMoney,
                bookChoiceList:this.bookChoiceList,
                changeFactory: (type: number,a:number,b:number) => {
                  //增加
                  if (type == 1) {
                    this.choiceCount++
                    this.totalMoney=Mytools.plus(this.totalMoney,Mytools.multiply(a,b))
                    //减少
                  } else if (type == 2) {
                    this.choiceCount--
                    this.totalMoney=Mytools.minus(this.totalMoney,Mytools.multiply(a,b))
                  }
                }
              })
            }
            .onClick(()=>{
              router.pushUrl({
                url:'pages/BookDetails',
                params:{bookId:item.goodsId}
              })
            })
          })
        }
        .height('85%')
        .backgroundColor('#f6f6f6')
        .width('100%')
        .alignListItem(ListItemAlign.Center)

      Row(){
          Row(){
            Text(`已选${this.choiceCount}件,合计:`).fontSize(19)
            Text('￥')
              .fontColor('#fffc0000')
              .fontSize(16)
            Text(this.totalMoney.toString())
              .fontColor('#fffc0000')
              .fontWeight(FontWeight.Bold)
              .fontSize(30)
          }
          Row(){
            Button('去结算')
              .backgroundColor('#e54433')
              .onClick(()=>{
                router.pushUrl({
                  url:'pages/AddOrder'
                })
              })
          }
      }
      .margin({left:15,right:15})
      .justifyContent(FlexAlign.SpaceBetween)
      .width('90%')
      .height('10%')
    }
    .backgroundColor('#f6f6f6')
    .height('100%')
    .width('100%')
  }
}