import { book, book_type, getBookList, getBookTypeDataList } from "../api/BookApi";
import { ApiResult } from "../utils/HttpCore";
import { hilog } from "@kit.PerformanceAnalysisKit";

@ComponentV2
export default struct Classification {
  @Local bookTypeList:book_type[]=[]
  @Local bookList:book[]=[]

  async aboutToAppear(): Promise<void> {
    //发送请求获取书籍类型
    const bookTypeRes=await getBookTypeDataList() as ApiResult
    const bookTypeResData=bookTypeRes.data as book_type[]
    this.bookTypeList=bookTypeResData
    hilog.info(0x0000,'bookTypeRes','%{public}s',JSON.stringify(bookTypeRes.data))

    const bookInfoRes=await getBookList({}) as ApiResult
    hilog.info(0x0000,'bookInfoRes','%{public}s',JSON.stringify(bookInfoRes.data))
  }

  build() {
    Column(){
      Text('分类')
        .width('100%')
        .fontSize(24)
        .fontWeight(700)
        .margin({left:30,bottom:20})
      Grid(){
        ForEach(this.bookTypeList,(book:book_type)=>{
          GridItem(){
            Row(){

              Text(book.bookTypeName)
            }
          }.onClick(async ()=>{
            const result=await getBookList({categoryName:book.bookTypeName}) as ApiResult
            this.bookList=result.data
          })
        })
      }.columnsTemplate('1fr 1fr')
    }
  }
}