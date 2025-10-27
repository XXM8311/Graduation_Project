import  {instance} from  './http'
import { Axios, AxiosResponse} from  '@ohos/axios'
interface returnType{
  code:number,
  msg:string,
}
interface HttpError {
  code: number;
  msg: string;
}
interface  loginType{
  phone:string,
  password:string
}
interface  regType{
  phone:string,
  password:string
  sex:string
  userName:string,
  address:string
}
interface  loginRetuenType extends  returnType{
  info:userInfo
  data:string
}
export  interface  userInfo{
  phone:string
  userName:string,
  id:number,
  address:string,
}
interface ChangePassword{
  phone:string,
  oldPassword:string,
  newPassword:string
}
export  interface  banner{
  id:number,
  url:string
}
  interface bannerType extends  returnType{
  data:banner[]
}
export  interface  news{
  id:number,
  title:string,
  desc:string,
  created_at:string,
  updated_at:string,
  author:string
}
interface newsType extends  returnType{
  data:news[]
}
export  interface   announcement{
  id:number
  name:string
  time:string
}
interface  announcementType extends  returnType{
  data:announcement[]
}
export  interface  announcementDetail{
  id:number
  content:string
}
interface  announcementDetailType extends returnType{
  data:announcementDetail
}
export const  toLogin=(data:loginType):Promise<AxiosResponse<loginRetuenType,HttpError>>=>{
  return instance.post('/user/login',data)
}

export const  toReg=(data:regType):Promise<AxiosResponse<returnType,HttpError>>=>{
  return instance.post('/user/register',data)
}

export  const getBannder=():Promise<AxiosResponse<bannerType,HttpError>>=>{
return  instance.get('/community/banner')
}

export  const updatePassword=(data:ChangePassword):Promise<AxiosResponse<returnType,HttpError>>=>{
  return instance.post('/user/updatePassword',data)
}

export  const getNews=():Promise<AxiosResponse<newsType,HttpError>>=>{
  return instance.get('/community/document')
}
export  interface  deliverySignFo{
  id: number,
  name: string,
  orderNum: string,
  time: string,
  deliveryMan: string,
  phone: string,
  address: string,
  state: string,
}
interface  deliverySignForType extends  returnType{
  data:deliverySignFo[]
}
interface  setDeliverySignFo{
  id:number
}
export  interface  clearData{
  typeName:string,
  contactName:string,
  contactPhone:string,
  content:string,
  date:string,
  time:string
}
export  interface  clearDetail{
  id:number
  typeName:string,
  contactName:string,
  contactPhone:string,
  content:string,
  date:string,
  time:string
}
interface clearDetailType{
  data:clearDetail[]
}
export  interface  garbage{
  id:number,
  title:string,
  content:string[]
}
interface  garbageType extends  returnType{
  data:garbage[]
}
interface  updateUserInfoData{
  userName:string,
  address:string
}
export  const getAnnouncement=():Promise<AxiosResponse<announcementType,HttpError>>=>{
  return instance.get('/community/announcementList')
}
export  const getAnnouncementDetail=(id:number):Promise<AxiosResponse<announcementDetailType,HttpError>>=>{
  return instance.get(`/community/announcementDetail?id=${id.toString()}`)
}
export const getDeliveryUnsignedList=():Promise<AxiosResponse<deliverySignForType,HttpError>>=>{
return instance.get('/community/deliveryUnsignedList')
}
export  const setDeliverySignFor=(data:setDeliverySignFo):Promise<AxiosResponse<returnType,HttpError>>=>{
  return instance.post('/community/deliverySignFor',data)
}
export const getDeliverySignedList=():Promise<AxiosResponse<deliverySignForType,HttpError>>=>{
  return instance.get('/community/deliverySignedList')
}
export  const addClearList=(data:clearData):Promise<AxiosResponse<returnType,HttpError>>=>{
  return instance.post('/community/cleaning',data)
}
export  const getCleaningList=():Promise<AxiosResponse<clearDetailType,HttpError>>=>{
  return instance.get('/community/cleaningList')
}
export  const getAarbageList=():Promise<AxiosResponse<garbageType,HttpError>>=>{
  return instance.get('/community/garbage')
}
export  const updateUserInfo=(data:updateUserInfoData):Promise<AxiosResponse<returnType,HttpError>>=>{
  return instance.post('/user/updeteInfo',data)
}
