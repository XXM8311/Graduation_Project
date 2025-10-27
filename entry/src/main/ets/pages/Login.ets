import { promptAction, router } from '@kit.ArkUI'
import  {toLogin,userInfo} from  '../utils/api'
@Entry
@Component
struct Login {
  @State phone:string=''
  @State password:string=''
  @StorageLink('token') token:string=''
  @StorageLink('userInfo') userInfo:userInfo={
    phone:'',
    userName:'',
    id:0,
    address:'',
  }
  build() {
    Column({space:20}){
    Text('数字社区欢迎您').fontSize(35).margin({top:40})
      Text('登录页')
      TextInput({
        placeholder:'请输入手机号'
      }).onChange((e)=>{
        this.phone=e
      })
      TextInput({
        placeholder:'请输入密码'
      }).type(InputType.Password).onChange((e)=>{
        this.password=e
      })
      Button('登录')
        .width('100%')
        .onClick(async()=>{
      const res =await toLogin({phone:this.phone,password:this.password})
          console.log(JSON.stringify(res.data))
          if(res.data.code==200){
            promptAction.showToast({
              duration:2000,
              message:'登录成功',
              bottom:300
            })
            this.token=res.data.data
            this.userInfo=res.data.info
            setTimeout(async ()=>{
              router.pushUrl({
                url:"pages/Index"
              })
            },1500)

          }else{
            promptAction.showToast({
              duration:2000,
              message:res.data.msg,
              bottom:300
            })
          }
        })
      Row({space:15}){
        Text('前往注册')
          .onClick(()=>{
            router.pushUrl({
              url:"pages/Reg"
            })
          })
      }
    }
    .backgroundImage($r("app.media.OIP_C"))
    .backgroundImageSize(ImageSize.Cover)
    .width('100%')
    .height('100%')
    .padding(20)
  }
}