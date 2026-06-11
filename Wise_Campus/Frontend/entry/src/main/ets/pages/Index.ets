import window from '@ohos.window';
import http from '@ohos.net.http';
// 注意：不再需要导入 router，因为改用 UIContext 路由
// import { router } from '@kit.ArkUI';  // 已弃用，删除
import { UIContext } from '@kit.ArkUI';

@Entry
@Component


struct Index {
  @State currentTab: number = 0; // 0=主页，1=论坛，2=点餐，3=个人

  // 轮播图数据
  private bannerItems: BannerItem[] = [
    { id: 1, title: '校园春景摄影大赛', bgColor: '#FF6B6B', description: '记录美好瞬间，赢取丰厚奖品' },
    { id: 2, title: '学术讲座：AI前沿', bgColor: '#4ECDC4', description: '与顶尖学者面对面交流' },
    { id: 3, title: '社团招新进行时', bgColor: '#45B7D1', description: '寻找志同道合的伙伴' }
  ];

  // 工具栏数据
  private toolItems: ToolItem[] = [
    { icon: '🔍', name: '失物招领', color: '#FF9F43' },
    { icon: '📢', name: '校园活动', color: '#54A0FF' },
    { icon: '📅', name: '通知公告', color: '#5F27CD' },
    { icon: '📚', name: '我的课表', color: '#00CEC9' }
  ];

  // 资讯列表数据
  @State newsList: NewsItem[] = [
    { id: 1, title: '关于举办2024年校园文化节的通知', time: '2024-10-15', views: 1234 },
    { id: 2, title: '图书馆延长开放时间公告', time: '2024-10-14', views: 892 },
    { id: 3, title: '学术讲座：人工智能未来发展', time: '2024-10-13', views: 2156 },
    { id: 4, title: '校园美食节即将开幕', time: '2024-10-12', views: 743 },
    { id: 5, title: '体育场馆预约系统升级通知', time: '2024-10-11', views: 567 }
  ];

  // 论坛帖子数据
  @State forumPosts: ForumPost[] = [
    { id: 1, title: '大家觉得哪个食堂最好吃？', author: '美食家小张', time: '2小时前', replies: 45, likes: 123 },
    { id: 2, title: '求推荐好用的学习APP', author: '学习小助手', time: '5小时前', replies: 32, likes: 89 },
    { id: 3, title: '校园网速太慢了怎么办？', author: '网络达人', time: '昨天', replies: 67, likes: 156 },
    { id: 4, title: '周末有什么校园活动推荐？', author: '活动爱好者', time: '昨天', replies: 23, likes: 78 },
    { id: 5, title: '图书馆占座问题讨论', author: '读书人', time: '2天前', replies: 89, likes: 234 }
  ];

  // 餐厅数据
  @State restaurants: Restaurant[] = [
    { id: 1, name: '博雅苑', rating: 4.5, deliveryTime: '20分钟', minOrder: 3, image: '🍜' },
    { id: 2, name: '沁德苑', rating: 4.2, deliveryTime: '15分钟', minOrder: 2, image: '🍚' },
  ];

  build() {
    Column() {
      // 顶部搜索栏
      this.buildSearchBar()

      // 主内容区域
      Column() {
        if (this.currentTab === 0) {
          this.buildHomePage()
        } else if (this.currentTab === 1) {
          this.buildForumPage()
        } else if (this.currentTab === 2) {
          this.buildOrderPage()
        } else {
          this.buildProfilePage()
        }
      }
      .layoutWeight(1)
      .width('100%')

      // 底部导航栏
      this.buildBottomNavigation()
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F5F7FA')
  }

  // 顶部搜索栏（蓝色背景，白色文字，扩展到状态栏）
  @Builder buildSearchBar() {
    Row() {
      Row() {
        Text('🔍')
          .fontSize(18)
          .fontColor(Color.White)
          .margin({ left: 12 })

        TextInput({ placeholder: '搜索资讯、活动...' })
          .layoutWeight(1)
          .height(40)
          .padding({ left: 8, right: 8 })
          .fontSize(14)
          .fontColor(Color.Black)
          .placeholderColor('#E0E0E0')
          .border({ width: 0 })
      }
      .layoutWeight(1)
      .margin({ top: 5, right: 15, bottom: 5, left: 15 })
      .backgroundColor(Color.White)
      .borderRadius(5)

      Image($r('app.media.scan3'))
        .width(50)
        .height(50)
        .margin({ right: 12 })
        .zIndex(1)
        .onClick(() => {
          console.info('扫一扫功能，可在此跳转扫码页面');
        })
    }
    .width('100%')
    .backgroundColor('#3377FF')
    .padding({ left: 0, right: 0, top: 10, bottom: 10 })
    .shadow({ radius: 2, color: '#00000010', offsetY: 2 })
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP])
  }

  // 主页内容
  @Builder buildHomePage() {
    Column() {
      // 轮播图 - 使用 indicatorStyle（弃用警告但可编译运行）
      Swiper() {
        ForEach(this.bannerItems, (item: BannerItem) => {
          Column() {
            Text(item.title)
              .fontSize(22)
              .fontWeight(FontWeight.Bold)
              .fontColor(Color.White)
              .margin({ bottom: 8 })
            Text(item.description)
              .fontSize(14)
              .fontColor(Color.White)
              .opacity(0.9)
          }
          .width('100%')
          .height('100%')
          .justifyContent(FlexAlign.Center)
          .alignItems(HorizontalAlign.Center)
          .backgroundColor(item.bgColor)
          .borderRadius(16)
        }, (item: BannerItem) => item.id.toString())
      }
      .height(180)
      .width('100%')
      .margin({ top: 12, left: 16, right: 16 })
      .borderRadius(16)
      .autoPlay(true)
      .interval(3000)
      .loop(true)
      .indicator(true)
      .indicatorStyle({
        color: Color.White,
        selectedColor: '#3366DD'
      })

      // 图标工具栏
      Row() {
        ForEach(this.toolItems, (item: ToolItem) => {
          Column() {
            Text(item.icon)
              .fontSize(32)
              .margin({ bottom: 5 })
            Text(item.name)
              .fontSize(12)
              .fontColor('#333333')
          }
          .width(70)
          .height(70)
          .justifyContent(FlexAlign.Center)
          .alignItems(HorizontalAlign.Center)
          .borderRadius(12)
          .backgroundColor('#F8F9FA')
          .onClick(() => {
            console.info(`点击了：${item.name}`);
          })
        }, (item: ToolItem) => item.name)
      }
      .width('100%')
      .padding({ top: 15, bottom: 15 })
      .justifyContent(FlexAlign.SpaceAround)
      .margin({ top: 20, bottom: 10 })

      // 校园资讯栏目
      Column() {
        Row() {
          Text("校园资讯")
            .fontSize(18)
            .fontWeight(FontWeight.Bold)
            .fontColor(Color.White)
          Blank()
          Text("更多 >")
            .fontSize(12)
            .fontColor(Color.White)
            .opacity(0.8)
            .onClick(() => {
              console.info("查看更多资讯");
            })
        }
        .width('100%')
        .padding({ left: 20, right: 20, top: 12, bottom: 12 })
        .backgroundColor("#3377FF")

        List({ space: 10 }) {
          ForEach(this.newsList, (item: NewsItem) => {
            ListItem() {
              Column() {
                Row() {
                  Text(item.title)
                    .fontSize(16)
                    .fontWeight(FontWeight.Medium)
                    .fontColor('#222222')
                    .maxLines(1)
                    .textOverflow({ overflow: TextOverflow.Ellipsis })
                    .layoutWeight(1)
                  Text(`${item.views}阅读`)
                    .fontSize(11)
                    .fontColor('#999999')
                }
                .width('100%')
                .margin({ bottom: 8 })

                Row() {
                  Text(item.time)
                    .fontSize(11)
                    .fontColor('#999999')
                  Blank()
                  Text("查看详情")
                    .fontSize(11)
                    .fontColor("#3377FF")
                    .onClick(() => {
                      console.info(`查看资讯：${item.title}`);
                    })
                }
                .width('100%')
              }
              .width('100%')
              .padding(12)
              .backgroundColor(Color.White)
              .borderRadius(12)
              .shadow({ radius: 4, color: '#00000015', offsetX: 0, offsetY: 2 })
            }
            .height('auto')
          }, (item: NewsItem) => item.id.toString())
        }
        .layoutWeight(1)
        .width('100%')
        .padding({ left: 16, right: 16, top: 10 })
        .scrollBar(BarState.Auto)
      }
    }
    .width('100%')
    .backgroundColor('#F5F7FA')
  }

  // 论坛页面
  @Builder buildForumPage() {
    Column() {
      Row() {
        Text("校园论坛")
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor('#222222')
        Blank()
        Text("发帖")
          .fontSize(14)
          .fontColor('#3366DD')
          .padding({ left: 12, right: 12, top: 6, bottom: 6 })
          .backgroundColor('#E6F0FF')
          .borderRadius(16)
          .onClick(() => {
            console.info("发帖");
          })
      }
      .width('100%')
      .padding({ left: 16, right: 16, top: 16, bottom: 16 })

      List({ space: 8 }) {
        ForEach(this.forumPosts, (item: ForumPost) => {
          ListItem() {
            Column() {
              Row() {
                Text(item.title)
                  .fontSize(16)
                  .fontWeight(FontWeight.Medium)
                  .fontColor('#222222')
                  .maxLines(2)
                  .textOverflow({ overflow: TextOverflow.Ellipsis })
                  .layoutWeight(1)
              }
              .width('100%')
              .margin({ bottom: 8 })

              Row() {
                Text(item.author)
                  .fontSize(12)
                  .fontColor('#666666')
                Text(item.time)
                  .fontSize(12)
                  .fontColor('#999999')
                  .margin({ left: 16 })
                Blank()
                Row() {
                  Text('💬')
                    .fontSize(12)
                  Text(item.replies.toString())
                    .fontSize(12)
                    .fontColor('#666666')
                    .margin({ left: 4 })
                  Text('❤️')
                    .fontSize(12)
                    .margin({ left: 12 })
                  Text(item.likes.toString())
                    .fontSize(12)
                    .fontColor('#666666')
                    .margin({ left: 4 })
                }
              }
              .width('100%')
            }
            .width('100%')
            .padding(16)
            .backgroundColor(Color.White)
            .borderRadius(12)
            .shadow({ radius: 2, color: '#00000010', offsetX: 0, offsetY: 1 })
          }
          .height('auto')
        }, (item: ForumPost) => item.id.toString())
      }
      .layoutWeight(1)
      .width('100%')
      .padding({ left: 16, right: 16 })
    }
    .width('100%')
    .backgroundColor('#F5F7FA')
  }

  // 点餐页面
  @Builder buildOrderPage() {
    Column() {
      Row() {
        Text("校园点餐")
          .fontSize(20)
          .fontWeight(FontWeight.Bold)
          .fontColor('#222222')
        Blank()
        Text("我的订单")
          .fontSize(14)
          .fontColor('#3366DD')
          .onClick(() => {
            console.info("查看订单");
          })
      }
      .width('100%')
      .padding({ left: 16, right: 16, top: 16, bottom: 16 })

      List({ space: 12 }) {
        ForEach(this.restaurants, (item: Restaurant) => {
          ListItem() {
            Row() {
              Text(item.image)
                .fontSize(40)
                .width(60)
                .height(60)
                .backgroundColor('#F0F8FF')
                .borderRadius(12)
                .textAlign(TextAlign.Center)

              Column() {
                Row() {
                  Text(item.name)
                    .fontSize(16)
                    .fontWeight(FontWeight.Medium)
                    .fontColor('#222222')
                  Blank()
                  Row() {
                    Text('⭐')
                      .fontSize(12)
                    Text(item.rating.toString())
                      .fontSize(12)
                      .fontColor('#666666')
                  }
                }
                .width('100%')

                Row() {
                  Text(`配送: ${item.deliveryTime}`)
                    .fontSize(12)
                    .fontColor('#666666')
                  Text(`起送: ¥${item.minOrder}`)
                    .fontSize(12)
                    .fontColor('#666666')
                    .margin({ left: 16 })
                }
                .width('100%')
                .margin({ top: 4 })
              }
              .layoutWeight(1)
              .margin({ left: 12 })
            }
            .width('100%')
            .padding(16)
            .backgroundColor(Color.White)
            .borderRadius(12)
            .shadow({ radius: 2, color: '#00000010', offsetX: 0, offsetY: 1 })
            .onClick(() => {
              console.info(`进入餐厅：${item.name}`);
              try {
                const uiContext = this.getUIContext();
                const router = uiContext.getRouter();
                router.pushUrl({ url: 'pages/sonPages/Canteen/MerchantList' })
                  .catch((err: Error) => {
                    console.error('跳转失败：' + err.message);
                  });
              } catch (error) {
                console.error('获取路由失败：' + JSON.stringify(error));
              }
            })
          }
          .height('auto')
        }, (item: Restaurant) => item.id.toString())
      }
      .layoutWeight(1)
      .width('100%')
      .padding({ left: 16, right: 16 })

    }
    .width('100%')
    .backgroundColor('#F5F7FA')
  }


  @StorageProp('name') name: string = '';
  @StorageProp('userNo') userNo: string = '';

  // 个人页面
  @Builder
  buildProfilePage() {
    Column() {
      // 个人信息卡片 - 头像左，信息右
      Row() {
        // 左侧头像（可点击）
        Text('👤')
          .fontSize(50)
          .width(70)
          .height(70)
          .textAlign(TextAlign.Center)
          .backgroundColor('#F0F0F0')
          .borderRadius(35)
          .margin({ right: 16 })


        // 右侧个人信息（手机号 + 学号）
        Column() {
          if (this.name) {
            // 已登录：显示名字
            Text(`${this.name}`)
              .fontSize(20)
              .fontWeight(FontWeight.Bold)
              .margin({ bottom: 4 })
          } else {
            // 未登录：显示提示
            Text('未登录')
              .fontSize(20)
              .fontWeight(FontWeight.Bold)
              .margin({ bottom: 4 })
          }

          if (this.userNo) {
            // 已登录：显示名字
            Text(`学号：${this.userNo}`)
              .fontSize(14)
              .fontColor('#666')
          } else {
            // 未登录：显示提示
            Text('学号: 暂无')
              .fontSize(14)
              .fontColor('#666')
          }

        }
        .alignItems(HorizontalAlign.Start)
        .justifyContent(FlexAlign.Center)
        .layoutWeight(1)   // 占据剩余宽度
      }
      .onClick(() => {
        try {
          const uiContext = this.getUIContext();
          const router = uiContext.getRouter();
          router.pushUrl({ url: 'pages/sonPages/login' })
            .catch((err: Error) => {
              console.error('跳转失败：' + err.message);
            });
        } catch (error) {
          console.error('获取路由失败：' + JSON.stringify(error));
        }
      })
      .width('100%')
      .alignItems(VerticalAlign.Center)
      .padding({ left: 16, right: 16, top: 16, bottom: 16 })
      .backgroundColor(Color.White)
      .borderRadius(16)
      .margin({ top: 20, left: 16, right: 16 })

      // 功能菜单（保持不变）
      Column() {
        this.buildMenuItem('📞', '个人信息', '修改个人资料')
        this.buildMenuItem('⭐', '我的收藏', '收藏的帖子和餐厅')
        this.buildMenuItem('📝', '我的帖子', '发布的论坛内容')
        this.buildMenuItem('⚙️', '设置', '应用设置和偏好')
      }
      .width('100%')
      .backgroundColor(Color.White)
      .borderRadius(16)
      .margin({ top: 16, left: 16, right: 16 })
      .padding({ left: 16, right: 16 })
    }
    .width('100%')
    .backgroundColor('#F5F7FA')
  }

  // 底部导航栏
  @Builder buildBottomNavigation() {
    Column() {
      Row() {
        this.buildNavItem('🏠', '主页', 0)
        this.buildNavItem('💬', '论坛', 1)
        this.buildNavItem('🍜', '点餐', 2)
        this.buildNavItem('👤', '个人', 3)
      }
      .width('100%')
      .height(50)
      .justifyContent(FlexAlign.SpaceEvenly)
    }
    .width('100%')
    .backgroundColor(Color.White)
    .border({ width: { top: 0.5 }, color: '#EEEEEE' })
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.BOTTOM])
  }

  // 导航栏项
  @Builder buildNavItem(icon: string, title: string, index: number) {
    Column() {
      Text(icon)
        .fontSize(24)
        .margin({ bottom: 2 })
        .fontColor(this.currentTab === index ? '#3366DD' : '#999999')
      Text(title)
        .fontSize(12)
        .fontColor(this.currentTab === index ? '#3366DD' : '#999999')
    }
    .layoutWeight(1)
    .height('100%')
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
    .onClick(() => {
      this.currentTab = index;
    })
    .opacity(this.currentTab === index ? 1 : 0.6)
  }

  // 个人页面菜单项
  @Builder buildMenuItem(icon: string, title: string, subtitle: string) {
    Row() {
      Text(icon)
        .fontSize(24)
        .width(40)
      Column() {
        Text(title)
          .fontSize(16)
          .fontWeight(FontWeight.Medium)
          .fontColor('#222222')
        Text(subtitle)
          .fontSize(12)
          .fontColor('#999999')
      }
      .layoutWeight(1)
      .margin({ left: 12 })
      Blank()
      Text('>')
        .fontSize(16)
        .fontColor('#CCCCCC')
    }
    .width('100%')
    .padding({ top: 16, bottom: 16 })
    .border({ width: { bottom: 0.5 }, color: '#F0F0F0' })
    .onClick(() => {
      console.info(`点击菜单：${title}`);
    })
  }
}

// 类型定义
interface BannerItem {
  id: number;
  title: string;
  bgColor: string;
  description: string;
}

interface ToolItem {
  icon: string;
  name: string;
  color: string;
}

interface NewsItem {
  id: number;
  title: string;
  time: string;
  views: number;
}

interface ForumPost {
  id: number;
  title: string;
  author: string;
  time: string;
  replies: number;
  likes: number;
}

interface Restaurant {
  id: number;
  name: string;
  rating: number;
  deliveryTime: string;
  minOrder: number;
  image: string;
}