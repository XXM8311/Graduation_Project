import {getAnnouncementDetail,announcementDetail} from  '../utils/api'
import { router } from '@kit.ArkUI';
interface  routerData{
  id:number
}
@Entry
@Component
struct Index {
  @State message: string = '详情公告';
  @State announcementDetail:announcementDetail={id:0,content:''}
  async  aboutToAppear(): Promise<void> {
    const routerData=router.getParams()  as routerData
    const  res=await getAnnouncementDetail(routerData.id)
    console.log(JSON.stringify(res.data.data))
    this.announcementDetail=res.data.data
  }
  build() {
    Column() {
      Text(this.message)
        .fontSize(35)
        .fontWeight(FontWeight.Bold)

      Text(this.announcementDetail.content).margin({
        top:30
      }).fontSize(20).height(300).width('95%').backgroundColor('#fff').padding(5).border({width:1}).borderRadius(10)
    }
    .backgroundImage($r("app.media.OIP_C"))
    .backgroundImageSize(ImageSize.Cover)
    .width('100%')
    .height('100%')
    .padding(20)
  }
}