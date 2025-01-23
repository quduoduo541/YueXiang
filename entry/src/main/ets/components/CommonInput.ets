@Component
export default struct CommonInput {
  @Prop title:string
  @Prop icon:Resource
  @Prop placeholder:string
  @Prop inputType:InputType=InputType.PhoneNumber
  @Prop maxLength?:number=50
  @Prop defaultValue:string
  change:(val:string)=>void=()=>{}

  build() {
    Column(){
      Column(){
        Text(this.title)
          .width('100%')
          .textAlign(TextAlign.Start)
          .fontSize(16)
          .fontWeight(500)
          .fontColor('#001648')
          .margin({bottom:5})
      }
      .width('100%')
      .margin({bottom:12})
      .alignItems(HorizontalAlign.Start)

      //交叉轴对齐格式
      Flex({alignItems:ItemAlign.Center}){
        if(this.icon){
          Image(this.icon)
            .width(30)
            .height(30)
            .margin({right:5})
        }
        TextInput({
          placeholder:this.placeholder,
          text:this.defaultValue
        })
          .onChange((val)=>{
            this.change(val)
          })
          .maxLength(this.maxLength)
          .borderRadius(8)
          .placeholderColor('#999')
          .backgroundColor('#fbfbfb')
          .style(TextInputStyle.Inline)
          .width('100%')
          .type(this.inputType)
      }
      .height(50)
      .width('100%')
      .padding({left:10,right:10})
      .borderRadius(10)
      .border({width:1,color:'#fff'})
    }
  }
}