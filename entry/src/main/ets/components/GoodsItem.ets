import { goods, selectCarData } from "../api/OrderApi"

@ComponentV2
export default struct GoodsItem{
  @Param item:goods={} as goods
  @Param choiceCount:number=0
  @Param totalMoney:number=0
  @Param bookChoiceList:goods[]=[]
  @Event changeFactory: (x: number,a:number,b:number) => void = (x: number,a:number,b:number) => {};

  build() {
    Column({space:20}){
      Column({space:10}){
        Row({space:6}){
          Text('自营').fontSize(18).backgroundColor('#e74432').fontColor('#fff')
          Text(this.item.bookShopName).fontSize(18)
        }
        .margin({top:5})
        .height(30)
        .width('95%')
        Row(){
          Checkbox({name:'checkbox',group:'checkboxGroup'})
            .select(this.item.checked)
            .selectedColor('#0xed6f21')
            .onChange((value:boolean)=>{
              selectCarData({id:this.item.id})
              if(value){
                this.bookChoiceList.push(this.item)
                this.changeFactory(1,this.item.bookPrice,this.item.goodsCount)
              }else {
                this.bookChoiceList.filter(obj=>obj.id!=this.item.id)
                this.changeFactory(2,this.item.bookPrice,this.item.goodsCount)
              }
            })
          Image(this.item.bookImg)
            .width(100)
            .borderRadius(15)
          Column({space:5}){
            Text(this.item.bookName)
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
            Text('数量:'+this.item.goodsCount)
              .fontSize(18)
            Row(){
              Text(`￥${this.item.bookPrice}`)
                .fontSize(25)
                .fontColor('#ffc0000')
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
  }
}