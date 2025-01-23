import { book, book_params, getHomeBookDataList } from '../api/BookApi'
import { ApiResult } from '../utils/HttpCore'
import { hilog } from '@kit.PerformanceAnalysisKit'
import { router } from '@kit.ArkUI'

@ComponentV2
export default struct StartPage {
  @Local searchcontrol:SearchController=new SearchController()
  @Local searchvalue:string=''
  @Local pageNum:number=1
  @Local pageSize:number=10
  @Local total:number=50
  @Local booklist:book[]=[]
  @Local allScale: number[] = [1, 1, 1, 1, 1, 1, 1, 1, 1, 1]

  aboutToAppear(): void {
    this.getListData(this.pageNum,this.pageSize)
  }

  async getListData(pageNum:number,pageSize:number,keyword:string=''){
    const res= await getHomeBookDataList({pageNum,pageSize,keyword:encodeURI(keyword)}) as ApiResult
    hilog.info(0x0000,'getHomeBookDataList','%{public}s',JSON.stringify(res.data))
    this.booklist=res.data.list
    this.total=res.data.total
    return res
  }

  build() {
    Scroll(){
      Column() {
        Text('首页')
          .width('100%')
          .fontSize(24)
          .fontWeight(700)
          .margin({left:30,bottom:20})
        Search({value:this.searchvalue,placeholder:"搜索书名",controller:this.searchcontrol})
          .width('90%')
          .height(40)
          .margin({bottom:40})
          .onSubmit(async (val)=>{
            this.searchvalue=val
            //重置页数
            this.pageNum=1
            const res =await this.getListData(this.pageNum,this.pageSize,this.searchvalue)
            this.booklist=res.data.list
          })
        Swiper() {
          ForEach(this.booklist, (book:book, index: number) => {
            Column() {
              Image(book.bookImg)
                .height(220)
                .width(160)
                .margin({bottom:15})
              Column(){
                Text(book.bookName)
                  .fontSize(20)
                  .fontWeight(600)
                Text(`${book.bookType} | ${book.bookAuthor} | ￥${book.bookPrice}`)
                  .fontColor('#666')
                  .fontSize(14)
              }
            }
            .width('100%')
            .scale({ x: this.allScale[index], y: this.allScale[index] })
          })
        }
        .width('100%')
        .height('45%')
        .prevMargin(110)
        .nextMargin(110)
        .indicator(false)
        .customContentTransition({
          timeout: 1000,
          transition: (proxy: SwiperContentTransitionProxy) => {
            console.log('opk',1.0 - (Math.abs(proxy.position)) * 0.1)
            let scale = 1.0 - (Math.abs(proxy.position)) * 0.4
            this.allScale[(proxy.index)%(this.allScale.length)] = scale
          }
        })

        List(){
          ForEach(this.booklist,(item:book)=>{
            ListItem(){
              Column(){
                Row(){
                  Image(item.bookImg)
                    .width(110)
                    .height(110)
                    .margin({left:10})
                    .borderRadius(12)
                  Column(){
                    Text(item.bookName)
                      .width('60%')
                      .fontSize(20)
                      .fontWeight(FontWeight.Bold)
                    Text(item.bookType)
                      .fontSize(14)
                      .fontColor('#787878')
                      .margin({top:10,bottom:20})
                    Text(`价格:${item.bookPrice}`)
                      .fontColor('#787878')
                  }.alignItems(HorizontalAlign.Start)
                  .margin({left:20})
                }
              }
              .margin({bottom:10})
              .borderRadius(8)
              .backgroundColor('#fff')
              .width('96%')
              .height(120)
              .justifyContent(FlexAlign.Center)
            }
            .margin({left:10})
            .onClick(()=>{
              router.pushUrl({
                url:"pages/BookDetails",
                params:{bookId:item.id}
              })
            })
          })
        }
        .scrollBar(BarState.Off)
        .height(530)
        .onScrollIndex(async (start:number,end:number)=>{
          const curTotal=this.pageNum*this.pageSize
          const curEnd=end+1
          if(curTotal==curEnd){
            //请求下一页数据
            this.pageNum+=1
            const res=await this.getListData(this.pageNum,this.pageSize)
            this.booklist.concat(res.data.list)
          }

        })
      }.size({ width: '100%', height: '100%' })
    }
  }
}