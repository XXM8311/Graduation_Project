import { promptAction, router } from '@kit.ArkUI'
import  {getDeliveryUnsignedList,deliverySignFo,setDeliverySignFor} from  '../utils/api'
@Entry
@Component
struct Home_kd {
  @State deliverySignFo:deliverySignFo[]=[]
  async  aboutToAppear(): Promise<void> {
    const  res=await getDeliveryUnsignedList()
    this.deliverySignFo=res.data.data
  }
  @Builder navItem(id:number,EMS:string,waybillNo:string,Time:string,name:string,phone:string,add:string){
  Column({space:10}){
    Row(){
      Text(EMS)
        .fontWeight(700)
        .fontSize(26)
        .margin({left:20,top:10})
    }
    .alignSelf(ItemAlign.Start)
    Row(){
      Text('运单号')
      Text(waybillNo)
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceBetween)
    Row(){
      Text('派件时间')
      Text(Time)
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceBetween)
    Row(){
      Text('快递小哥')
      Text(name)
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceBetween)
    Row(){
      Text('联系电话')
      Text(phone.toString())
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceBetween)
    Row(){
      Text('取件地址')
      Text(add)
    }
    .width('100%')
    .justifyContent(FlexAlign.SpaceBetween)
    Button('签收快递').onClick(async ()=>{
      AlertDialog.show(
        {
          title: '温馨提示',
          message: '确定吗?',
          autoCancel: true,
          alignment: DialogAlignment.Center,
          gridCount: 4,
          offset: { dx: 0, dy: -20 },
          primaryButton: {
            value: '取消',
            action: () => {
            }
          },
          secondaryButton: {
            value: '确定',
            action:async  () => {
              const res=await setDeliverySignFor({id:id})
              console.log(JSON.stringify(res.data))
              if(res.data.code=200){
                promptAction.showToast({
                  message:"签收成功"
                })
                const  res=await getDeliveryUnsignedList()
                this.deliverySignFo=res.data.data
              }
            }
          }
        }
      )

    })

  }
  .padding(10)
  .margin({top:10})
  .borderRadius(20)
  .width('95%')
  .backgroundColor(Color.White)
  .border({width:1})
}
  build() {
    Column(){
      Row(){
        Image($r('app.media.fanhui'))
          .width(24)
          .onClick(()=>router.back())
        Text('快递签收')
          .fontWeight(700)
          .fontSize(24)
        Row(){
          Image($r('app.media.wuliukuaidiche'))
            .width(20)
          Text('签收记录')
            .fontSize(18)
        }
        .onClick(()=>{
          router.pushUrl({
            url:"components/Home_kd_Time"
          })
        })
      }
      .margin({top:20})
      .padding(5)
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      List(){
        ForEach(this.deliverySignFo,(item:deliverySignFo)=>{
          this.navItem(item.id,item.name,item.orderNum,item.time,item.deliveryMan,item.phone,item.address)
        })

      }
      .alignListItem(ListItemAlign.Center)
      .width('100%')
      .height(650)
    }
    .width('100%').height('100%')
    .backgroundImage($r("app.media.OIP_C"))
    .backgroundImageSize(ImageSize.Cover)

  }
}