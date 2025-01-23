import httpcore from "../utils/HttpCore"

//注册接口
export const create=(data)=>{
  return httpcore.post('/hm/create',data)
}

//登录接口
export const login=(data)=>{
  return httpcore.post('/hm/login',data)
}