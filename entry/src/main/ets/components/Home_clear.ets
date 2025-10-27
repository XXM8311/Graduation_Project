import router from '@ohos.router'
import {addClearList} from  '../utils/api'
import promptAction from '@ohos.promptAction'
@Entry
@Component
struct DomesticCleaningPage {
  @State date :string=''
  @State time :string=''
  @State typeName:string='轻度清洁'
  @State contactName:string=''
  @State contactPhone:string=''
  @State content:string=''
  private selectTime: Date = new Date()
  async  subscribe(){
    if (this.content==''||this.date==''||this.time==''||this.contactPhone==''||this.contactName=='' ||this.typeName==''
    ){
      promptAction.showToast({
        message:"缺少重要参数",
        duration:1500,
        bottom:350
      })
    }
    if(this.contactPhone.length!=11){
      promptAction.showToast({
        message:"联系方法格式错误",
        duration:1500,
        bottom:350
      })
    }
    const res=await addClearList({
      typeName:this.typeName,
      contactName:this.contactName,
      contactPhone:this.contactPhone,
      content:this.content,
      date:this.date,
      time:this.time
    })
    if(res.data.code==200){
      promptAction.showToast({
       message:'预约成功，等待物业工作人员上门',
        duration:3000,
        bottom:300
      })
      setTimeout(()=>{
        router.pushUrl({
          url:"pages/Index"
        })
      },1000)
    }
  }
  build() {

    Column() {
      Row(){
        Text('家政预约').fontSize(20)
        Row(){
          Image($r('app.media.order')).height(20)
          Text('预约记录')
        }.position({
          top:0,
          right:-140
        }).onClick(()=>{
          router.pushUrl({
            url:'components/Home_clearDetail'
          })
        })
      }.backgroundColor(Color.White).alignItems(VerticalAlign.Center)

      Scroll(){
        Column(){
          Text('服务内容')
            .fontSize(20)
            .margin({bottom:10}).width('100%')

          Column(){
            Row(){
              Text('请选择服务类型：')
                .margin({left:25})
              Select([
                { value: '轻度清洁' },
                { value: '中度清洁' },
                { value: '深度清洁'}
              ])
                .value('轻度清洁')
                .selected(0)
                .onSelect((e)=>{
                  if(e==0){
                    this.typeName='轻度清洁'
                  }else if(e==1){
                    this.typeName='中度清洁'
                  }else{
                    this.typeName='重度清洁'
                  }
                })
            }.width('100%')
            Text('请备注服务要求：').width('100%').margin({left:50})
            TextArea({placeholder:'请输入您的要求'})
              .height(110)
              .width('90%')
              .onChange((e)=>{
                if(e.length>50){
                  promptAction.showToast({
                    message:"字数不能超过50字",
                    duration:1500,
                    bottom:350
                  })
                }
                this.content=e
              })
          }
          .backgroundColor(Color.White)
          .borderRadius(15)
          .width('100%')
          .height(180)


          Text('联系人信息')
            .width('100%')
            .fontSize(20)
            .margin({top:10,bottom:10})

          Column(){
            Row({space:15}){
              Text('联系人姓名:')
              TextInput({placeholder:"请输入联系人姓名"})
                .width(200)
                .onChange((e)=>{
                  this.contactName=e
                })
            }
            Row({space:25}){
              Text('手机号码:')
              TextInput({placeholder:"请输入手机号码"})
                .width(210)
                .onChange((e)=>{
                  this.contactPhone=e
                })
            }
            .margin({top:10})

            Row({space:15}){
              Text('预约上门时间：')
              Text(`${this.date} ${this.time}`)
            }.margin({top:10}).width('100%')

            Row({space:10}){
              Button('预约日期')
                .backgroundColor('#f4f6f5')
                .fontSize(14)
                .fontColor(Color.Black).onClick(()=>{
                DatePickerDialog.show({
                  start:new Date('2025-1-1'),
                  end:new Date('2025-12-30'),
                  selected: this.selectTime,
                  onAccept:(e:DatePickerResult)=>{
                    let moth:number=e.month
                    this.date=`${e.year}-${moth+1}-${e.day}`
                  }
                })

              })
              Button('预约时间')
                .backgroundColor('#f4f6f5')
                .fontSize(14)
                .fontColor(Color.Black)
                .onClick(()=>{
                  TimePickerDialog.show({
                    selected: this.selectTime,
                    onAccept:(e)=>{
                      this.time=`${e.hour}:${e.minute}`
                    }
                  })
                })
            }.margin({top:10})

          }
          .padding(10)
          .backgroundColor(Color.White)
          .borderRadius(15)
          .width('100%')
          .height(190)

          Button('预约').width(200).margin({top:20}).onClick(()=>{this.subscribe()})
        }
      }.height(650)

    }
    .padding(20)
    .width('100%')
    .backgroundImage($r("app.media.OIP_C"))
    .backgroundImageSize(ImageSize.Cover)
  }
}
