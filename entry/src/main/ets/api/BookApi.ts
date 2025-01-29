import httpcore from "../utils/HttpCore"

export interface book {
  id:number
  bookName:string
  bookImg:string
  bookType:string
  bookShopName:string
  bookPrice:string
  bookBrief:string
  bookStatus:number
  bookAuthor:string
  tuijian:number
  kucun:number
  bookRead:null|string
}

export interface book_type {
  id: number
  createUserId: number
  createUserName: string
  createTime: string
  updateUserId: number
  updateUserName: string
  updateTime: string
  bookTypeName: string
  bookTypeSttaus: number
}

export interface book_params{
  bookId:number
}

export interface address_params{
  address:string
}

export const getHomeBookDataList=(params)=>{
  return httpcore.get('/hm/index',params)
}

export const getBookTypeDataList=()=>{
  return httpcore.get('/hm/category')
}

export const getBookList=(params)=>{
  return httpcore.get('/hm/categorybook',params)
}

export const getBookInfoById=(params)=>{
  return httpcore.get('/hm/bookDetail',params)
}