
import axios, {  AxiosError, AxiosResponse, InternalAxiosRequestConfig } from '@ohos/axios'
import promptAction from '@ohos.promptAction';

export  const baseUrl='http://192.168.69.131:3000'//基础地址
//创建axios实例
export const instance= axios.create({
  baseURL:baseUrl,
  timeout: 5000//超时事件
})

// 添加请求拦截器
instance.interceptors.request.use((config: InternalAxiosRequestConfig):InternalAxiosRequestConfig => {
  const token:string = AppStorage.get('token')||''
  if (token!=='') {
    // 若token存在，则将其添加到请求头
    config.headers['authorization'] ='Bearer '+ token
  }
  console.log(token)
  return config;
}, (error: AxiosError) => {
  //若出现异常，则提示异常信息
  promptAction.showToast({ message: error.message })
  return Promise.reject(error);
});

// 添加响应拦截器
// 修改三，使用Promise对异步错误结果进行输出（Promise 对象表示异步操作最终的完成（或失败）以及其结果值。）
instance.interceptors.response.use((response: AxiosResponse):AxiosResponse|Promise<undefined> => {
  // 若服务器返回的是正常数据，不做任何处理
  if (response.data.code === 200) {
    return response
  } else {
    return response
  }
}, (error: AxiosError) => {
  //若出现异常，则提示异常信息
  console.log(error.message)
  promptAction.showToast({ message: error.message })
  return Promise.reject(error);
});
