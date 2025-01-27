import { webview } from '@kit.ArkWeb';

@Entry
@ComponentV2
struct AddressMap {
  @Local message: string = 'Hello World';
  controller:webview.WebviewController=new webview.WebviewController()
  nativePort:webview.WebMessagePort|null=null//WebMessagePort可以进行消息的发送以及接收
  ports:webview.WebMessagePort[]=[]

  build() {
    Column(){
      Web({src:$rawfile('index.html'),controller:this.controller})
        .onPageEnd(()=>{
          //创建Web消息端口,方法返回一个数组,数组第一个元素是当前本地的端口,第二个是发送给H5的
          this.ports=this.controller.createWebMessagePorts(true)
          //发送Web消息端口到HTML
          //参数:要发送的消息名称,要发送的消息端口,接收该消息的URI
          this.controller.postMessage("init_web_messageport",[this.ports[1]],'*')
          //保存端口0到本地
          this.nativePort=this.ports[0]
          //监听H5回传来的消息
          this.nativePort?.onMessageEventExt((result)=>{

          })
        })
    }
  }
}