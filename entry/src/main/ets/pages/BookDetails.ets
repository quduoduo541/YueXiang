import { router } from '@kit.ArkUI'
import { book, book_params, getBookInfoById } from '../api/BookApi'
import { ApiResult } from '../utils/HttpCore'

@Entry
@ComponentV2
struct BookDetails {
  @Local bookParams:book_params=router.getParams() as book_params
  @Local bookItem:book={} as book

  async aboutToAppear(): Promise<void> {
    const res=await getBookInfoById({bookId:this.bookParams.bookId}) as ApiResult
    this.bookItem=res.data
  }
  build() {
    Column(){
      List(){
        ListItem(){
          Column(){
            Row(){
              Image(this.bookItem.bookImg)
                .width(190)
              Column({space:18}){
                Text(this.bookItem.bookName)
                  .fontWeight(FontWeight.Bold)
                  .fontSize(24)
                  .fontColor('#000')
                  .margin({top:35})
                Text(`已售 95`)
                Text(`库存 ${this.bookItem.kucun}`)
                  .fontColor('#ffa7a2a2')
                  .fontSize(13)
                Text(`店铺 ${this.bookItem.bookShopName}`)
                  .fontColor('#000')
                  .fontSize(15)
                Text(`作者 ${this.bookItem.bookAuthor}`)
                  .fontColor('#000')
                  .fontSize(18)
                Text(`￥ ${this.bookItem.bookPrice}`)
                  .fontColor('#ffff0000')
                  .fontSize(18)
              }.alignItems(HorizontalAlign.Start)
              .width('45%')
              .height('100%')
            }
            .width('100%')
            .height('40%')

            Flex({direction:FlexDirection.Row,justifyContent:FlexAlign.SpaceBetween}){
              Button('立即下单')
                .borderRadius(8)
                .width(150)
                .height(40)
                .margin({left:20})
                .onClick(()=>{})
              Button('加入购物车')
                .borderRadius(8)
                .width(150)
                .height(40)
                .margin({left:20})
                .backgroundColor('#ff9a02')
                .onClick(()=>{})
            }
            .margin({top:30})

            Text('简介')
              .fontSize(20)
              .fontColor('#ffe50808')
              .margin({top:30,bottom:6})
            Text(this.bookItem.bookBrief)
              .margin({top:10})
          }
          .padding(10)
          .width('100%')
          .alignItems(HorizontalAlign.Start)
        }
      }
      .height('90%')
      .scrollBar(BarState.Off)
      .divider({
        strokeWidth:2,
        color:'#efefef',
        startMargin:20,
        endMargin:20
      })
    }
    .width('100%')
  }
}