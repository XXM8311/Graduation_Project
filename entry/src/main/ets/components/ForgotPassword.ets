import { promptAction, router } from '@kit.ArkUI'
import  {updatePassword} from  '../utils/api'
@Entry
@Component
struct Pasw {
  @State phone:string=''
  @State oldPassword:string=''
  @State newPassword:string=''
  build() {
    Column({space:20}){
      Text('数字社区欢迎您').fontSize(35).margin({top:40})
      Text('修改密码页')
      TextInput({
        placeholder:'请输入手机号'
      }).onChange((e)=>{
        this.phone=e
      })
      TextInput({
        placeholder:'请输入旧密码'
      }).type(InputType.Password)
        .onChange((e)=>{
          this.oldPassword=e
        })
      TextInput({
        placeholder:'请输入新密码'
      }).type(InputType.Password)
        .onChange((e)=>{
          this.newPassword=e
        })
      Button('确定')
        .width('100%')
        .onClick(async ()=>{
          if(this.oldPassword==this.newPassword){
            promptAction.showToast({
              duration:2000,
              message:'新旧密码不能一致',
              bottom:300
            })
            return
          }
          const res=await updatePassword({phone:this.phone,oldPassword:this.oldPassword,newPassword:this.newPassword})
          if (res.data.code=200){
            promptAction.showToast({
              duration:2000,
              message:res.data.msg,
              bottom:300
            })
            router.back()
          }
        })
    }
    .backgroundImage($r("app.media.OIP_C"))
    .backgroundImageSize(ImageSize.Cover)
    .width('100%')
    .height('100%')
    .padding(20)
  }
}