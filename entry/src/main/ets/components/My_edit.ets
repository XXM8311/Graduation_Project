import { promptAction, router } from '@kit.ArkUI'
import {userInfo,updateUserInfo} from  '../utils/api'


@Entry
@Component
struct My_edit {
  @StorageLink('userInfo') userInfo:userInfo={
    phone:'',
    userName:'',
    id:0,
    address:'',
  }
  @State userName:string=this.userInfo.userName
  @State address:string=this.userInfo.address
  @Builder navItem(txt:string,content:string,index:number){
    Row({space:50}){
      Text(txt)
      TextInput({placeholder:content})
        .width('70%')
        .onChange((e)=>{
            if(index==0){
              this.userName=e
            }else {
              this.address=e
            }
        })
    }
    .justifyContent(FlexAlign.SpaceBetween)
    .width('100%')
    .padding({left:20,right:50,bottom:10,top:5})
    .margin({top:20})
    .border({width:1})
  }
  build() {
    Column(){
      Row(){
        Image($r('app.media.fanhui'))
          .width(24)
          .onClick(()=>router.back({
            url:"pages/Index"
          }))

        Text('修改个人信息')
          .fontWeight(700)
          .fontSize(24)
          .margin({right:'25%'})
      }
      .justifyContent(FlexAlign.SpaceBetween)
      .margin({top:20})
      .padding(5)
      .width('100%')

      Column(){
        Text(this.userInfo.phone)
          .fontWeight(900)
          .fontSize(30)
          .margin(10)
        this.navItem('昵称',this.userInfo.userName,0)
        this.navItem('地址',this.userInfo.address,1)
      }
      .borderRadius(20)
      .margin({top:10})
      .width('90%')
      .backgroundColor('#fff')
      Button('提交修改')
        .margin({top:10})
        .onClick(async ()=>{
        const res=await updateUserInfo({userName:this.userName,address:this.address})
          if(res.data.code=200){
            promptAction.showToast({
              message:'修改成功',
              duration:3000,
              bottom:350
            })
            this.userInfo.userName=this.userName
            this.userInfo.address=this.address
            setTimeout(()=>{
              router.back()
            },1000)
          }
        })
    }
    .backgroundImage($r("app.media.OIP_C"))
    .backgroundImageSize(ImageSize.Cover)
    .width('100%')
    .height('100%')
  }
}