import { it } from '@ohos/hypium';
import { getMyAllYhq, yhq } from '../api/OrderApi';
import Empty from '../components/Empty';
import { ApiResult } from '../utils/HttpCore';

@Entry
@ComponentV2
struct Youhuiquan {
  @Local yhqList:yhq[]=[];

  aboutToAppear(): void {
    this.getList()
  }

  onPageShow(): void {
    this.getList()
  }

  async getList(){
    const res=await getMyAllYhq() as ApiResult
    this.yhqList=res.data
  }

  build() {
    Column(){
      if(!this.yhqList.length){
        Empty({title:'暂无优惠券可用'})
      }else {
        List(){
          ForEach(this.yhqList,(item:yhq)=>{
            ListItem(){
              Stack(){
                Image($r('app.media.youhuiquan_bg01'))
                  .width('100%')
                  .height(100)
                  .borderRadius(10)
                  .margin({top:10})
                Text(String(item.yhqMoney))
                  .fontSize(20)
                  .fontColor('#ffffe800')
                  .fontWeight(FontWeight.Bold)
                  .offset({x:-150,y:4})
                Text(item.yhqDesc)
                  .fontSize(29)
                  .fontColor('#ff000000')
                Text(item.startDate+ '-' +item.endDate)
                  .fontSize(13)
                  .fontColor('#ff8c8a8a')
                  .offset({y:28})
                if(item.useFlag==1){
                  Image($r('app.media.use_no'))
                    .width(90)
                    .height(90)
                    .offset({x:100,y:4})
                }
              }
              .width('100%')
            }
          })
        }
        .height('92%')
      }
    }
  }
}