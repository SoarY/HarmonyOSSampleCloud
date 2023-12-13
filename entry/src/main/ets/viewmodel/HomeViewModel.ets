import { ArticleDataBean } from '../bean/ArticleDataBean';
import { HomeBannerItemBean } from '../bean/HomeBannerItemBean';
import ResponseResult from '../bean/ResponseResult';
import { Constants } from '../constants/Constants';
import { httpRequestGet } from '../utils/HttpUtil';

export class HomeViewModel{
  static getHomeBanner(path:string):Promise<HomeBannerItemBean[]>{
    return new Promise(async (resolve:Function,reject:Function)=>{
      let url:string=`${Constants.SERVER}/${path}/`
      httpRequestGet(url).then((data:ResponseResult)=>{
        if (data.errorCode===Constants.SERVER_CODE_SUCCESS) {
          resolve(data.data)
        }else {
          reject(data.errorMsg)
        }
      }).catch(()=>{
        reject('getHomeBanner catch')
      })
    })
  }

  static getHomeArticleList(currentPage: number):Promise<ArticleDataBean>{
    return new Promise(async (resolve:Function,reject:Function)=>{
      let url:string=`${Constants.SERVER}/${Constants.GET_HOME_ARTICLE_LIST}/${currentPage}/json`
      httpRequestGet(url).then((data:ResponseResult)=>{
        if (data.errorCode===Constants.SERVER_CODE_SUCCESS) {
          resolve(data.data)
        }else {
          reject(data.errorMsg)
        }
      }).catch(()=>{
        reject('getHomeArticleList catch')
      })
    })
  }
}