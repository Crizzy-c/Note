// MerchantListPage.ets
// 商家列表子页面，展示校园周边/食堂商家，支持排序筛选
import window from '@ohos.window';
import http from '@ohos.net.http';

// 商家数据结构
interface Merchant {
  id: number;
  name: string;           // 商家名称
  image: string;          // 图标（emoji模拟）
  rating: number;         // 评分 0-5
  monthlySales: number;   // 月销量
  deliveryTime: string;   // 配送时间
  minOrder: number;       // 起送价
  distance: string;       // 距离
  tags: string[];         // 标签如“品牌连锁”“新店”
  pricePerPerson: number; // 人均价格
}

@Entry
@Component
struct MerchantListPage {
  // 当前排序类型: 'default' 综合, 'sales' 销量, 'rating' 评分
  @State currentSort: string = 'default';
  // 原始商家列表数据（用于排序重置）
  private originalMerchants: Merchant[] = [
    {
      id: 1,
      name: '博雅苑餐厅',
      image: '🍜',
      rating: 4.5,
      monthlySales: 1280,
      deliveryTime: '20分钟',
      minOrder: 3,
      distance: '200m',
      tags: ['人气爆棚', '学生优惠'],
      pricePerPerson: 15
    },
    {
      id: 2,
      name: '沁德苑美食城',
      image: '🍚',
      rating: 4.2,
      monthlySales: 980,
      deliveryTime: '15分钟',
      minOrder: 2,
      distance: '350m',
      tags: ['多样小吃', '夜宵供应'],
      pricePerPerson: 18
    },
    {
      id: 3,
      name: '星巴克咖啡',
      image: '☕',
      rating: 4.8,
      monthlySales: 560,
      deliveryTime: '25分钟',
      minOrder: 25,
      distance: '600m',
      tags: ['品牌连锁', '适合自习'],
      pricePerPerson: 32
    },
    {
      id: 4,
      name: '麦当劳',
      image: '🍔',
      rating: 4.6,
      monthlySales: 2100,
      deliveryTime: '22分钟',
      minOrder: 20,
      distance: '450m',
      tags: ['快餐巨头', '24h'],
      pricePerPerson: 28
    },
    {
      id: 5,
      name: '海底捞火锅',
      image: '🍲',
      rating: 4.9,
      monthlySales: 420,
      deliveryTime: '35分钟',
      minOrder: 50,
      distance: '1.2km',
      tags: ['聚会首选', '服务好'],
      pricePerPerson: 85
    },
    {
      id: 6,
      name: '瑞幸咖啡',
      image: '🧋',
      rating: 4.4,
      monthlySales: 1340,
      deliveryTime: '18分钟',
      minOrder: 10,
      distance: '300m',
      tags: ['性价比高', '新品多'],
      pricePerPerson: 16
    },
    {
      id: 7,
      name: '杨国福麻辣烫',
      image: '🍲',
      rating: 4.3,
      monthlySales: 1670,
      deliveryTime: '16分钟',
      minOrder: 15,
      distance: '280m',
      tags: ['麻辣烫', '自选菜品'],
      pricePerPerson: 22
    },
    {
      id: 8,
      name: '必胜客',
      image: '🍕',
      rating: 4.5,
      monthlySales: 890,
      deliveryTime: '28分钟',
      minOrder: 39,
      distance: '800m',
      tags: ['披萨专家', '套餐划算'],
      pricePerPerson: 45
    }
  ];

  @State merchants: Merchant[] = this.originalMerchants;

  // 排序处理
  sortMerchants(sortType: string) {
    this.currentSort = sortType;
    let sorted = [...this.originalMerchants];
    if (sortType === 'sales') {
      sorted.sort((a, b) => b.monthlySales - a.monthlySales);
    } else if (sortType === 'rating') {
      sorted.sort((a, b) => b.rating - a.rating);
    } else {
      // 综合排序：按id原始顺序（可改成热度权重，这里保持原序）
      sorted.sort((a, b) => a.id - b.id);
    }
    this.merchants = sorted;
  }

  // 返回上一页
  goBack() {
    try {
      const uiContext = this.getUIContext();
      const router = uiContext.getRouter();
      router.back();
    } catch (error) {
      console.error('返回失败：' + JSON.stringify(error));
    }
  }

  // 点击商家卡片（预留跳转商家详情）
  onMerchantClick(merchant: Merchant) {
    console.info(`点击商家：${merchant.name}，id=${merchant.id}`);
    // 这里可跳转商家详情页，例如：
    // const uiContext = this.getUIContext();
    // const router = uiContext.getRouter();
    // router.pushUrl({ url: 'pages/MerchantDetailPage', params: { merchantId: merchant.id } });
  }

  build() {
    Column() {
      // 顶部导航栏（仿照Index风格，白底+返回+标题）
      this.buildNavBar();

      // 排序/筛选栏
      this.buildSortBar();

      // 商家列表
      this.buildMerchantList();
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F5F7FA')
  }

  // 顶部导航栏（左侧返回箭头+标题“商家列表”，右侧留空可放搜索图标）
  @Builder
  buildNavBar() {
    Row() {
      // 返回按钮
      Text('←')
        .fontSize(28)
        .fontColor('#3377FF')
        .width(40)
        .height(40)
        .textAlign(TextAlign.Center)
        .onClick(() => this.goBack())

      // 标题居中
      Text('商家列表')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .fontColor('#222222')
        .layoutWeight(1)
        .textAlign(TextAlign.Center)

      // 占位保持对称
      Row()
        .width(40)
        .height(40)
    }
    .width('100%')
    .height(56)
    .padding({ left: 12, right: 12 })
    .backgroundColor(Color.White)
    .shadow({ radius: 2, color: '#00000010', offsetY: 2 })
  }

  // 排序栏（综合/销量/评分）
  @Builder
  buildSortBar() {
    Row() {
      this.buildSortItem('综合排序', 'default')
      this.buildSortItem('销量最高', 'sales')
      this.buildSortItem('评分最优', 'rating')
    }
    .width('100%')
    .padding({ top: 10, bottom: 10, left: 16, right: 16 })
    .justifyContent(FlexAlign.SpaceAround)
    .backgroundColor(Color.White)
    .margin({ top: 0 })
  }

  @Builder
  buildSortItem(title: string, sortType: string) {
    Text(title)
      .fontSize(14)
      .fontColor(this.currentSort === sortType ? '#3377FF' : '#666666')
      .fontWeight(this.currentSort === sortType ? FontWeight.Medium : FontWeight.Normal)
      .padding({ left: 12, right: 12, top: 6, bottom: 6 })
      .borderRadius(20)
      .backgroundColor(this.currentSort === sortType ? '#E6F0FF' : 'transparent')
      .onClick(() => this.sortMerchants(sortType))
  }

  // 商家列表（卡片风格与Index中保持一致）
  @Builder
  buildMerchantList() {
    List({ space: 12 }) {
      ForEach(this.merchants, (merchant: Merchant) => {
        ListItem() {
          this.buildMerchantCard(merchant)
        }
        .height('auto')
      }, (merchant: Merchant) => merchant.id.toString())
    }
    .layoutWeight(1)
    .width('100%')
    .padding({ left: 16, right: 16, top: 12 })
    .scrollBar(BarState.Auto)
  }

  // 单个商家卡片（丰富信息，与点餐页面餐厅卡片风格统一但更全面）
  @Builder
  buildMerchantCard(merchant: Merchant) {
    Column() {
      Row() {
        // 左侧图标（模拟图片）
        Text(merchant.image)
          .fontSize(44)
          .width(70)
          .height(70)
          .backgroundColor('#F0F8FF')
          .borderRadius(16)
          .textAlign(TextAlign.Center)

        // 右侧信息区域
        Column() {
          // 第一行：名称 + 评分/月售标签
          Row() {
            Text(merchant.name)
              .fontSize(18)
              .fontWeight(FontWeight.Medium)
              .fontColor('#222222')
            Blank()
            Row() {
              Text('⭐ ' + merchant.rating.toFixed(1))
                .fontSize(12)
                .fontColor('#FF9800')
              Text(' 月销 ' + merchant.monthlySales)
                .fontSize(12)
                .fontColor('#666666')
                .margin({ left: 8 })
            }
          }
          .width('100%')
          .margin({ bottom: 6 })

          // 第二行：配送时间 / 起送价 / 距离
          Row() {
            Text(`⏱️ ${merchant.deliveryTime}`)
              .fontSize(12)
              .fontColor('#666666')
            Text(`💰 起送 ¥${merchant.minOrder}`)
              .fontSize(12)
              .fontColor('#666666')
              .margin({ left: 16 })
            Text(`📍 ${merchant.distance}`)
              .fontSize(12)
              .fontColor('#666666')
              .margin({ left: 16 })
          }
          .width('100%')
          .margin({ bottom: 6 })

          // 第三行：人均价格 + 标签
          Row() {
            Text(`人均 ¥${merchant.pricePerPerson}`)
              .fontSize(12)
              .fontColor('#3377FF')
              .fontWeight(FontWeight.Medium)

            if (merchant.tags && merchant.tags.length > 0) {
              Row({ space: 6 }) {
                ForEach(merchant.tags, (tag: string) => {
                  Text(tag)
                    .fontSize(10)
                    .fontColor('#FF6B6B')
                    .padding({ left: 6, right: 6, top: 2, bottom: 2 })
                    .backgroundColor('#FFF0F0')
                    .borderRadius(10)
                }, (tag: string) => tag)
              }
              .margin({ left: 12 })
            }
          }
          .width('100%')
        }
        .layoutWeight(1)
        .margin({ left: 12 })
        .alignItems(HorizontalAlign.Start)
      }
      .width('100%')
      .padding(16)
      .backgroundColor(Color.White)
      .borderRadius(16)
      .shadow({ radius: 4, color: '#00000015', offsetY: 2 })
    }
    .onClick(() => this.onMerchantClick(merchant))
  }
}