import {getAarbageList,garbage} from '../utils/api'
import { router } from '@kit.ArkUI'
import text from '@ohos.graphics.text'

@Component
@Entry
export  struct Home_lj {
  async aboutToAppear(): Promise<void> {
    const res = await getAarbageList()
    this.garbageList = res.data.data
  }

  @State garbageList: garbage[] = []

  build() {
    Column() {
      Text('垃圾分类小知识').fontSize(32)
      List() {
        ForEach(this.garbageList, (item: garbage) => {
          ListItem() {
            Column() {
              Text(item.title).fontSize(18).fontWeight(FontWeight.Bold).margin({top:5})
              Row({space:10}){
                ForEach(item.content, (item: string) => {
                  Text(item).margin({top:20})
                })
              }
            }.height(70).width('100%').border({width:1}).backgroundColor('#fff').margin({top:20})
          }
        })
      }
      .backgroundImage($r("app.media.OIP_C"))
      .backgroundImageSize(ImageSize.Cover)
      .width('100%')
      .height('100%')
      .padding(20)
      .margin({top:20})
    }
  }
}