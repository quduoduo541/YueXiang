import httpcore from "../utils/HttpCore"
import { http } from "@kit.NetworkKit";

export interface address_list {
  id: number;
  userId: number;
  address: string;
  addressName: string;
  addressPhone: string;
  addressTag: string;
}

export interface goods {
  id: number,
  goodsId: number,
  goodsCount: number,
  nickName: null,
  bookName: string,
  bookImg: string,
  bookPrice: number,
  bookShopName: string,
  checked: boolean,
  createTime: string
}

export interface order_params{
  productId:string
}

export interface order {
  id: number;
  goodsId: number;
  bookName: string;
  bookImg: string;
  bookShopName: string;
  bookPrice: number;
  orderNo: string;
  goodsCount: number;
  payType: null | string;
  payMoney: number;
  useYhq: number;
  order_status?: number;
}


export const addAddress=(data)=>{
  return httpcore.post('/hm/changeAddress',data)
}

export interface address_item{
  addressItem:string
}

export interface order_data{
  addressId:number
  type:string
  productId?:string
}

export interface pay_params{
  totalMoney:number,
  orderNo:string
}

export interface yhq {
  id: number;
  yhqDesc: string;
  startDate: string;
  endDate: string;
  yhqMoney: number;
  useFlag: number;
}


export const getAddressByUserId=()=>{
  return httpcore.get('/hm/getAddress')
}

export const addGoodsToCar=(data)=>{
  return httpcore.post('/hm/addBuyCar',data)
}

export const getCarDataList=()=>{
  return httpcore.get('/hm/getBuyCar')
}

export const selectCarData=(data)=>{
  return httpcore.post('/hm/selectCar',data)
}

export const getProduct=(params={})=>{
  return httpcore.get('/hm/getProduct',params)
}

export const addOrder=(data)=>{
  return httpcore.post('/hm/addOrder',data)
}

export const payOrder=(data)=>{
  return httpcore.post('/hm/payOrder',data)
}

export const getOrderListByUserId=()=>{
  return httpcore.get('/hm/orderList')
}

export const getMyAllYhq=(params={})=>{
  return httpcore.get('/hm/getMyAllYhq',params)
}
