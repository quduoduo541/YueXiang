import httpcore from "../utils/HttpCore"

export interface user_info{
  id:number
  createUserId :number
  createUserName:string
  createTime :string
  updateUserId :number
  updateUserName :string
  updateTime :string
  loginName :string
  loginPass :string
  nickName :string
  userImg :string
  userSex :number
  userPhone :string
  UserStatus :number
  lastLoginTime :string
  registerTime :string
  userSchool :string
  userMajor :string
  userMoney :number
}

export const getUserInfoById=()=>{
  return httpcore.get('/hm/getUserInfoById')
}