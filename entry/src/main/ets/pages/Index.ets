import router from '@ohos.router'
@Entry
@Component
struct Index {

  private DELAY_TIME=3000;

  aboutToAppear(){
    setTimeout(()=>{
      router.pushUrl(
        {
          url:'pages/MainPage'
        })
    },this.DELAY_TIME)
  }

  build() {
    Column() {
      Image($r('app.media.ic_splash'))
    }
    .width('100%')
    .height('100%');
  }

}