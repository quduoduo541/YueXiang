@ComponentV2
export default struct Empty{
  @Param title:string='暂无数据'
  build() {
    Column(){
      Image($r('app.media.obj_empty'))
        .width(230)
        .height(160)
        .margin({top:20})
      Text(this.title)
        .fontSize(30)
        .fontWeight(FontWeight.Bold)
        .margin({top:20})
    }
    .width('100%')
    .height('60%')
  }
}