@Component
export default struct UserPage {
  @State message: string = 'Hello World';

  build() {
    Column(){
      Stack(){
        //背景
        Image($r('app.media.myinfo_background'))
      }
    }
  }
}