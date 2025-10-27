import { router } from '@kit.ArkUI'
import {userInfo} from  '../utils/api'
// 全局 Builder
@Builder
function navItem(txt:string,txtt:string){
  Row({space:10}){
    Text(txt).margin({top:5})
    Text(txtt)
  }
  .justifyContent(FlexAlign.SpaceAround)
  .width('100%')
  .margin({top:20})
}

@Entry
@Preview
@Component
export  struct My {
  @StorageLink('userInfo') userInfo:userInfo={
    phone:'',
    userName:'',
    id:0,
    address:'',
  }
  build() {
    Column(){

      Text('个人中心')
        .fontSize(34)
        .margin({top:20,bottom:20})
      Column(){
        Text(this.userInfo.userName)
        navItem('联系方式:',this.userInfo.phone)
        navItem('家庭住址:',this.userInfo.address)
      }
      .borderRadius(20)
      .margin({top:10})
      .width('90%')
      .backgroundColor('#fff')
      .border({width:1})
    Row({space:10}){
      Button('编辑')
        .margin({top:10})
        .onClick(()=>{
          router.pushUrl({
            url:"components/My_edit"
          })
        })
      Button('修改密码')
        .margin({top:10})
        .onClick(()=>{
          router.pushUrl({
            url:"components/ForgotPassword"
          })
        })
    }
    }
    .width('100%')
    .height('100%')
    .backgroundImage($r("app.media.OIP_C"))
    .backgroundImageSize(ImageSize.Cover)
  }
}