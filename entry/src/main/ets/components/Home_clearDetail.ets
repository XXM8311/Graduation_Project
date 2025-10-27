import router from '@ohos.router'
import  {clearDetail,getCleaningList} from  '../utils/api'
@Entry
@Component
struct ClearDetail {
  @State recordsList:clearDetail[]=[]
  async  aboutToAppear(): Promise<void> {
    const  res=await getCleaningList()
    this.recordsList=res.data.data
  }
  build() {
    Column() {
      Column(){
        Row(){
          Text('预约记录').fontSize(20).margin({left:120})
        }.width('100%').margin({top:22,bottom:60})
        if(this.recordsList.length>0){
          List(){
            ForEach(this.recordsList,(item:clearDetail)=> {
              ListItem(){
                Column(){
                  Row(){
                    Text('预约编号')
                    Text(item.id.toString())
                      .width(100)
                      .textAlign(TextAlign.Center)
                      .fontColor('#888')
                  }.recordsRow()
                  Row(){
                    Text('服务类型')
                    Text(item.typeName)
                      .width(100)
                      .textAlign(TextAlign.Center)
                      .fontColor('#888')
                  }.recordsRow()
                  Row(){
                    Text('联系人')
                    Text(item.contactName)
                      .width(100)
                      .textAlign(TextAlign.Center)
                      .fontColor('#888')
                  }.recordsRow()
                  Row(){
                    Text('联系方式')
                    Text(item.contactPhone)
                      .width(150)
                      .textAlign(TextAlign.Center)
                      .fontColor('#888')
                  }.recordsRow()
                  Row(){
                    Text('上门时间')
                    Text(`${item.date} ${item.time}`)
                      .width(150)
                      .textAlign(TextAlign.Center)
                      .fontColor('#888')
                  }.recordsRow()
                  Row(){
                    Text('服务评分')
                    Text('满意')
                      .width(100)
                      .textAlign(TextAlign.Center)
                      .fontColor('#888')
                  }.recordsRow()
                }
                .width('100%')
                .padding(20)
                .height(225)
                .backgroundColor(Color.White).
                margin({top:20})
                .borderRadius(20)
              }
              .padding(5)
              .margin({top:10})
              .borderRadius(20)
              .width('95%')
              .backgroundColor(Color.White)
              .border({width:1})
            })
          }.height(600)
        }
        else{
          Text('空空如也').fontSize(24).margin({top:150})
        }
      }
      .height('100%')
    }
    .padding(10)
    .height('100%')
    .width('100%')
    .backgroundImage($r("app.media.OIP_C"))
    .backgroundImageSize(ImageSize.Cover)
  }
}
@Extend(Row)
function  recordsRow(){
  .margin(5)
  .width('100%')
  .justifyContent(FlexAlign.SpaceAround)
}
