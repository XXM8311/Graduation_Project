import { router } from '@kit.ArkUI'
import  {getDeliverySignedList,deliverySignFo} from  '../utils/api'

@Entry
@Component
struct Home_kd_Time {
  @State deliverySignFo:deliverySignFo[]=[]
  async  aboutToAppear(): Promise<void> {
    const  res=await getDeliverySignedList()
    this.deliverySignFo=res.data.data
  }
  @Builder navItem(id:number,EMS:string,waybillNo:string,name:string,phone:string,add:string){
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
    .width('100%')
    .justifyContent(FlexAlign.SpaceBetween)
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

          Text('快递签收历史页')
          .fontWeight(700)
          .fontSize(24)
            .margin({right:'25%'})
      }
      .justifyContent(FlexAlign.SpaceBetween)
      .margin({top:20})
      .padding(5)
      .width('100%')
      List(){
        ForEach(this.deliverySignFo,(item:deliverySignFo)=>{
          this.navItem(item.id,item.orderNum,item.deliveryMan,item.name,item.phone,item.address)
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