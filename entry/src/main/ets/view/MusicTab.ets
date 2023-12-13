import AndroidPlay from './AndroidPlay'
@Component
export default struct MusicTab {

  @State currentTabIndex:number=0
  private tabsController:TabsController=new TabsController()

  build() {
    Tabs({
      barPosition:BarPosition.Start,
      controller: this.tabsController
    }){

      TabContent(){
        AndroidPlay()
      }
      .tabBar(
        this.TabBuilder(0,$r('app.string.android'))
      )

      TabContent(){
        AndroidPlay()
      }
      .tabBar(
        this.TabBuilder(1,$r('app.string.navi'))
      )
    }
    .width('100%')
    .barMode(BarMode.Fixed)
    .barHeight($r('app.float.mainPage_tabHeight'))
    .backgroundColor($r('app.color.start_window_background'))
    .onChange((index:number)=>{
      this.currentTabIndex=index
    })
  }

  @Builder TabBuilder(index: number,tabRes:Resource){
    Column(){
      RelativeContainer(){
        Text(tabRes)
          .width('100%')
          .height('100%')
          .fontColor(this.getTabColor(index))
          .id("tabText")
          .textAlign(TextAlign.Center)
          .alignRules({
            center:{
              anchor: "__container__",
              align:VerticalAlign.Center
            }
          })

        Line()
          .width('100%')
          .height($r('app.float.tab_line_height'))
          .backgroundColor($r('app.color.colorAccent'))
          .id("tabLinet")
          .alignRules({
            center:{
              anchor: "__container__",
              align:VerticalAlign.Bottom
            }
          })
          .visibility(this.currentTabIndex==index?Visibility.Visible:Visibility.Hidden)
      }
      .width('100%')
      .height('100%')
    }
    .width('100%')
    .height($r('app.float.mainPage_tabHeight'))
    .justifyContent(FlexAlign.Center)
    .onClick(()=>{
      this.currentTabIndex=index
      this.tabsController.changeIndex(this.currentTabIndex)
    })
  }

  private getTabColor(index:number){
    return this.currentTabIndex==index?$r('app.color.tab_bar_color'):$r('app.color.colorTabText')
  }
}