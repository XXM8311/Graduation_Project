import { router } from '@kit.ArkUI'
import  {getBannder,banner,getNews,news} from  '../utils/api'
import {baseUrl} from  '../utils/http'
@Builder
function navItem(icon:string,txt:string,index:number){
  Column(){
    Image($r(`app.media.${icon}`))
      .width(36)
      .fillColor(Color.Black)
    Text(txt)
      .fontColor(Color.Black)
  }
  .onClick(()=>{
    if(index==0){
      router.pushUrl({
        url:'components/Home_kd'
      })
    }else if(index==1){
      router.pushUrl({
        url:'components/Home_clear'
      })
    }else{
      router.pushUrl({
        url:"components/Home_lj"
      })
    }
  })
}

@Entry
@Component
export struct Home {
  async  aboutToAppear(): Promise<void>{
       const bannerRes=await getBannder()
       if(bannerRes.data.code=200){
         console.log(JSON.stringify(bannerRes.data.data))
         this.bannerList=bannerRes.data.data
       }
       const newsRes=await getNews()
    if(newsRes.data.code=200){
      console.log(JSON.stringify(newsRes.data.data))
      this.newsList=newsRes.data.data
    }
     }
     @State bannerList:banner[]=[]
    @State newsList:news[]=[]

  build(){
    Navigation(){
    Column(){
      Swiper(){
       ForEach(this.bannerList,(item:banner)=>{
         Image(baseUrl+item.url).height(150)
       })
      }
      .loop(true)//开启循环
      .autoPlay(true)//自动播放
      .interval(4000)//自动播放间隔
      .vertical(false)//横向/纵向
      .width('100%')
      .indicator(
        Indicator.dot()
          .itemWidth(20)
          .itemHeight(5)
          .color(Color.Black)
          .selectedItemWidth(25)
          .selectedItemHeight(10)
          .selectedColor(Color.White)
      )
      Row(){
        navItem('kuaidiche','快递驿站',0)
        navItem('jiazhengfuwu','家政清洁',1)
        navItem('lajihuishou','垃圾分类',2)
      }
      .width('100%')
      .margin({top:10})
      .padding({top:5,bottom:15})
      .justifyContent(FlexAlign.SpaceAround)

        List(){
          ForEach( this.newsList,(item:news)=>{
            ListItem(){
              NavRouter(){
                Column(){
                  Text(item.title).width(300).fontSize(20).textAlign(TextAlign.Center).fontWeight(FontWeight.Medium).margin({top:5})
                  Text(item.desc).margin(5).height(100).textOverflow({overflow:TextOverflow.Ellipsis})
                    .maxLines(3)
                }.width('95%').height(140).backgroundColor('#fff').borderRadius(10).border({width:1})
              NavDestination(){
                Text(item.desc).fontSize(30)
              }
              .title(item.title)
              .hideTitleBar(false)//是否隐藏标题
              .height('100%')
              .backgroundColor(Color.White)
              }
            }
            .padding(10)
          })
        }
        .alignListItem(ListItemAlign.Center)
        .width('100%')
        .height(400)
      }

    }
    .width('100%').height('100%')
    .backgroundImage($r("app.media.OIP_C"))
    .backgroundImageSize(ImageSize.Cover)
  }
}