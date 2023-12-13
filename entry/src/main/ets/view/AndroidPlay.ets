import ArticleList from './ArticleList'
import Banner from './Banner'
@Component
export default struct AndroidPlay {

  build() {
    Stack(){
      ArticleList()
      Banner()
    }
    .alignContent(Alignment.Top)
  }
}

