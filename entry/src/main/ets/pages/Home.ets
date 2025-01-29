import Classification from './Classification';
import ShopCar from './ShopCar';
import StartPage from './StartPage';
import UserPage from './UserPage';
import { hilog } from '@kit.PerformanceAnalysisKit';
import TokenUtils from '../utils/TokenUtils';

@Entry
@Component
struct Home {
  private tabcontroller:TabsController=new TabsController();
  @State currentPage:number=0

  aboutToAppear(): void {
    hilog.info(0x0000, 'getToken', '%{public}s', JSON.stringify(TokenUtils.getToken()));
    hilog.info(0x0000, 'getUser', '%{public}s', JSON.stringify(TokenUtils.getUser()));
  }

  @Builder
  TabBuilder(text: string,index: number,icon_selected: Resource,icon: Resource) {
    Column() {
      Image(index === this.currentPage ? icon_selected : icon)
        .width(24)
        .height(24)
        .objectFit(ImageFit.Contain)
      Text(text)
        .fontSize(10)
        .fontWeight(500)
        .fontColor(this.currentPage === index ? "#007DFF" : "#999")
        .margin({ top: 4})
    }.justifyContent(FlexAlign.Center)
    .width('100%')
    .height('100%')
  }

  build() {
    Tabs({barPosition:BarPosition.End,controller:this.tabcontroller}){
      //首页
      TabContent() {
        StartPage()
      }.tabBar(this.TabBuilder('首页', 0, $r('app.media.home_1_chose'),$r('app.media.home_1')))

      //分类
      TabContent() {
        Classification()
      }.tabBar(this.TabBuilder('分类', 1, $r('app.media.home_2_chose'),$r('app.media.home_2')))

      //购物车
      TabContent() {
        ShopCar({active:this.currentPage==2})
      }.tabBar(this.TabBuilder('购物车', 2, $r('app.media.home_3_chose'),$r('app.media.home_3')))

      //我的
      TabContent() {
        UserPage()
      }.tabBar(this.TabBuilder('我的', 3, $r('app.media.home_4_chose'),$r('app.media.home_4')))

    }.onChange(index=>this.currentPage=index)
  }
}