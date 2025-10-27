import { promptAction, router } from '@kit.ArkUI'
import {toReg} from  '../utils/api'
@Entry
@Component
struct Reg {
  @State phone:string=''
  @State password:string=''
  @State sex:string='男'
  @State address:string=''
  @State userName:string=''
  build() {
    Column({space:20}){
      Text('数字社区欢迎您').fontSize(35).margin({top:40})
      Text('注册页')
      TextInput({
        placeholder:'请输入3-6位用户名'
      })
        .onChange((e)=>{
          this.userName=e
        })
      TextInput({
        placeholder:'请输入手机号'
      }) .onChange((e)=>{
        this.phone=e
      })
      TextInput({
        placeholder:'请输入密码'
      }).type(InputType.Password)
        .onChange((e)=>{
          this.password=e
        })
      TextInput({
        placeholder:'请输入居住地址'
      }).type(InputType.Password)
        .onChange((e)=>{
          this.address=e
        })
      Row({space:20}){
        Text('请选择性别')
        Select([
          {value:'男'},
          {value:'女'}
        ])
          .value('男')
          .onSelect((e)=>{
            if(e==1){
              this.sex='女'
            }else{
              this.sex='男'
            }
          })
      }.width('100%')
      Button('注册')
        .width('100%')
        .onClick(async ()=>{
        const res=await toReg({
          phone:this.phone,
          password:this.password,
          sex:this.sex,
          userName:this.userName,
          address:this.address
        })
          console.log(JSON.stringify(res))
          if(res.data.code==200){
            promptAction.showToast({
              duration:2000,
              message:'注册成功',
              bottom:300
            })
            setTimeout(()=>{
             router.back()
            },1500)
          }else{
            promptAction.showToast({
              duration:2000,
              message:res.data.msg,
              bottom:300
            })
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