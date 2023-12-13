import { HomeBannerItemBean } from '../bean/HomeBannerItemBean'
import { Constants } from '../constants/Constants'
import { HomeViewModel } from '../viewmodel/HomeViewModel'
import promptAction from '@ohos.promptAction'

@Component
export default struct Banner{

  @State bannerData:Array<HomeBannerItemBean>=[]

  aboutToAppear(){
    HomeViewModel.getHomeBanner(Constants.GET_HOME_BANNER).then((data:HomeBannerItemBean[])=>{
        this.bannerData=data
    }).catch((err:string)=>{
      promptAction.showToast({
        message:err,
        duration:Constants.ANIMATION_DURATION
      })
    })
  }

  build(){
    Row(){
      Swiper(){
        ForEach(this.bannerData,(banner:HomeBannerItemBean)=>{
          Image(banner.imagePath)
        })
      }
      .width('60%')
      .height($r('app.float.android_play_head_height'))
      .autoPlay(true)
      .visibility(this.bannerData.length>0?Visibility.Visible:Visibility.Hidden)

      Column(){
        Image(this.bannerData.length>0?this.bannerData[0].imagePath:null)
          .width('100%')
          .layoutWeight(1)

        Image(this.bannerData.length>1?this.bannerData[1].imagePath:null)
          .width('100%')
          .layoutWeight(1)
      }
      .width('40%')
      .height($r('app.float.android_play_head_height'))
    }
    .width('100%')
    .height($r('app.float.android_play_head_height'))

  }
}