import {Home} from '../components/Home'
import {Announcement} from  '../components/Announcement'
import {My} from '../components/My'
@Entry
@Component
struct Index {

  build(){
    Tabs({barPosition:BarPosition.End}){
      TabContent(){
        Home()
      }
      .tabBar('首页')
      TabContent(){
        Announcement()
      }
      .tabBar('社区公告')
      TabContent(){
        My()
      }
      .tabBar('我的')
    }
    .animationDuration(500)
  }
}