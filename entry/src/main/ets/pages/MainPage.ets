import MusicTab from '../view/MusicTab';

@Entry
@Component
struct MainPage {

  @State currentTabIndex:number=0
  private tabsController:TabsController=new TabsController()

  build() {
    Tabs({
      barPosition:BarPosition.Start,
      controller: this.tabsController
    }){

      TabContent(){
        MusicTab()
      }
      .tabBar(
        this.TabBuilder(0,$r('app.media.ic_titlebar_music'))
      )

      TabContent(){
        MusicTab()
      }
      .tabBar(
        this.TabBuilder(1,$r('app.media.ic_titlebar_discover'))
      )

      TabContent(){
        MusicTab()
      }
      .tabBar(
        this.TabBuilder(2,$r('app.media.ic_titlebar_friends'))
      )
    }
    .width('100%')
    .barMode(BarMode.Fixed)
    .barWidth('50%')
    .barHeight($r('app.float.mainPage_barHeight'))
    .backgroundColor($r('app.color.tab_bar_color'))
    .onChange((index:number)=>{
      this.currentTabIndex=index
    })
  }

  @Builder TabBuilder(index: number,icon:Resource){
    Column(){
      Image(icon)
      .width(25)
      .height(25)
      .fillColor(this.getTabBarColor(index))

    }
    .width('100%')
    .height($r('app.float.mainPage_barHeight'))
    .justifyContent(FlexAlign.Center)
    .onClick(()=>{
        this.currentTabIndex=index
        this.tabsController.changeIndex(this.currentTabIndex)
    })
  }

  private getTabBarColor(index:number){
    return this.currentTabIndex==index?$r('app.color.tab_bar_select_color'):$r('app.color.tab_bar_normal_color')
  }
}