import { ListView } from '@app/refresh'
import { ArticleItemBean } from '../bean/ArticleItemBean'
import { RefreshController } from '@app/refresh'
import { HomeViewModel } from '../viewmodel/HomeViewModel'
import { ArticleDataBean } from '../bean/ArticleDataBean'
import promptAction from '@ohos.promptAction'
import hilog from '@ohos.hilog'

@Component
export default struct ArticleList{

  @State controller:RefreshController=new RefreshController()
  @State articleData:Array<ArticleItemBean>=[]
  @State currentPage:number=1
  @State hasMore:boolean=true

  aboutToAppear(){
    this.getHomeArticleList(true)
  }

  build(){
    ListView({
      marginHeader:150,
      items:this.articleData,
      itemLayout:(item,index)=>this.itemLayout(item,index),
      controller:this.controller,
      onRefresh:()=>{
        this.getHomeArticleList(true);
        this.controller.finishRefresh()
      },
      onLoadMore:()=>{
        this.getHomeArticleList(false)
        this.controller.finishLoadMore()
      }
    })
  }

  @Builder
  itemLayout(item:ArticleItemBean,index){
    Column(){
      Row(){
        Image($r('app.media.ic_new'))
          .width("30vp")
          .height("30vp")
          .visibility(item.isFresh?Visibility.Visible:Visibility.Hidden)

        Text(item.chapterName)
          .fontSize('13fp')
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)

      Text(item.title)
        .fontSize('14fp')
        .fontColor('#333333')
        .width('100%')
        .margin({
          top:'8vp',
          right:'8vp',
          bottom:'8vp'
        })

      Row(){
        Row(){
          Text(item.niceDate)
            .fontSize('11fp')
            .fontColor('#999')

          Text(`·${item.author}`)
            .fontSize('11fp')
            .fontColor('#999')
        }
        .height("25vp")
        .layoutWeight(1)

        Image($r('app.media.ic_uncollect'))
          .width("25vp")
          .height("25vp")
      }
      .width('100%')
      .alignItems(VerticalAlign.Center)
    }
    .width('100%')
    .padding('8vp')
  }

  getHomeArticleList(reset:boolean){
    HomeViewModel.getHomeArticleList(this.currentPage).then((data:ArticleDataBean)=>{
      if (data.curPage < data.pageCount) {
        this.currentPage++
        this.hasMore=true
      }else {
        this.hasMore=false
      }

      if (reset) {
        this.articleData=data.datas
      }else {
        this.articleData=this.articleData.concat(data.datas)
      }
    }).catch((err:string)=>{
      promptAction.showToast({message:err})
    })
  }
}