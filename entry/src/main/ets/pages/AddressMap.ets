import { webview } from '@kit.ArkWeb';
import { router } from '@kit.ArkUI';

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
          //1.创建Web消息端口,返回本地的端口和发送给H5的端口
          this.ports=this.controller.createWebMessagePorts(true)
          //2.发送端口1到HTML5
          this.controller.postMessage("init_web_messageport",[this.ports[1]],'*')
          //保存端口0到本地
          this.nativePort=this.ports[0]
          //监听H5回传来的消息
          this.nativePort?.onMessageEventExt((result)=>{
              router.back({url:'pages/AddAddress',params:{address:result.getString()}})
          })
        })
    }
  }
}