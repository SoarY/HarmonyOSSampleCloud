import ResponseResult from '../bean/ResponseResult'
import http from '@ohos.net.http'
import { Constants } from '../constants/Constants'

export function httpRequestGet(url:string):Promise<ResponseResult>{
    let httpRequest=http.createHttp()
    let response=httpRequest.request(url,{
      method:http.RequestMethod.GET,
      header:{
        'Content-Type':'application/json'
      }
    })
    let serverData=new ResponseResult()
    return response.then((value:http.HttpResponse)=>{
      if (value.responseCode === Constants.HTTP_CODE_200) {
        let result=`${value.result}`
        let resultJson:ResponseResult=JSON.parse(result)
        serverData.data=resultJson.data
        serverData.errorCode=resultJson.errorCode
        serverData.errorMsg=resultJson.errorMsg
      }else {
        serverData.errorMsg='error code:'+value.responseCode
      }
      return serverData
    }).catch(()=>{
      serverData.errorMsg='catch error'
      return serverData
    })
}