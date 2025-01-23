import { http } from "@kit.NetworkKit"
import CommonConfig from "./CommonConfig"
import MyTools from "./MyTools"
import TokenUtils from "./TokenUtils"

//请求类型枚举
export enum RequestMethod{
  GET='GET',
  POST='POST',
  PUT='PUT',
  DELETE='DELETE',
  OPTIONS='OPTIONS'
}

export interface requestOptions{
  url?:string
  method?:RequestMethod
  extraData?:object|string|ArrayBuffer
  header?:object
  queryParams?:Record<string,string>
}

export interface ApiResult{
  code:string
  message?:string
  data?
}

class HttpCore{
  request(requestOptions:requestOptions){
    return new Promise((resolve,reject)=>{
      const token=TokenUtils.getToken()
      const httpRequest=http.createHttp()
      httpRequest.request(
        CommonConfig.REQUEST_URL+requestOptions.url,
        {
          method:requestOptions.method,
          connectTimeout:10000,//连接超时时间
          readTimeout:60000,//读取超时时间
          header:{
            'Content-Type':'application/json',
            'terminal':'hm',
            'h-token':token
          },
          extraData:requestOptions.extraData
        },(err,data)=>{
          if(!err){
            const resobj=JSON.parse(data.result.toString())
            if(resobj.code!=10000){
              MyTools.alertMsg(resobj.message)
            }else{
              resolve(resobj)
            }
          }else{
            MyTools.alertMsg(`网络异常:${JSON.stringify(err)}`)
            reject(err)
          }
      }
      )
    })
  }
  post(url,option){
    const options={
      url,
      extraData:option,
      method:RequestMethod.POST
    }
    return this.request(options)
  }
  get(url,option={}){
    //把对象转成数组
    url=url+'?'+Object.keys(option).map((item:string)=>{
      return `${item}=${option[item]}`
    }).join('&')
    const options={
      url,
      method:RequestMethod.GET,
      extraData:{}
    }
    return this.request(options)
  }
}

export default new HttpCore()