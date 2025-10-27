import {getAnnouncement,announcement} from '../utils/api'
import { router } from '@kit.ArkUI'

@Component
export  struct Announcement {
 async  aboutToAppear(): Promise<void> {
  const  res=await getAnnouncement()
   console.log(JSON.stringify(res.data))
   this.announcement=res.data.data
  }
  @State announcement:announcement[]=[]
  build() {
    Column() {
      Text('公告').fontSize(32)
      List(){
        ForEach(this.announcement,(item:announcement)=>{
         ListItem(){
          Row({space:10}){
            Text(item.name)
            Text(item.time)
          }.border({width:1}).borderRadius(10).height(66).width('100%').justifyContent(FlexAlign.SpaceAround).margin({top:20})
         }.onClick(()=>{
           router.pushUrl({
             url:"components/AnnouncementDetail",
             params:{id:item.id}
           })
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