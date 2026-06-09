// MerchantListPage.ets
// 商家列表子页面，展示校园周边/食堂商家，支持排序筛选
import http from '@ohos.net.http';
import { router } from '@kit.ArkUI';

// 商家数据结构
interface Merchant {
  id: number;
  name: string;           // 商家名称
  logo: string;          // 图标（emoji模拟）
  avgRating: number;         // 评分 0-5
  monthlySales: number;   // 月销量
  deliveryTimeMinutes: string;   // 配送时间
  minOrderAmount: number;       // 起送价
  distance: string;       // 距离
  tags: string[];         // 标签如“品牌连锁”“新店”
  avgPricePerPerson: number; // 人均价格
}

// 后端返回的原始商家数据结构
// 后端返回的原始商家数据结构（与JSON完全对应）
interface BackendMerchant {
  id: number;
  merchantNo: string | null;
  name: string;
  logo: string;
  intro: string;
  contactPerson: string | null;
  contactPhone: string | null;
  address: string;
  businessHours: string | null;
  avgRating: number | null;
  status: number;
  isDelete: number | null;
  gmtCreate: string | null;
  gmtModified: string | null;
  monthlySales: number | null;
  deliveryTimeMinutes: number | null;
  minOrderAmount: number | null;
  avgPricePerPerson: number | null;
}

@Entry
@Component
struct MerchantListPage {
  // 当前排序类型: 'default' 综合, 'sales' 销量, 'rating' 评分
  @State currentSort: string = 'default';
  // 展示的商家列表（排序后的）
  @State merchants: Merchant[] = [];
  // 加载状态
  @State isLoading: boolean = true;
  // 原始商家列表数据（从后端获取后保存，用于排序重置）
  private originalMerchants: Merchant[] = [];

  // 页面加载时请求数据
  aboutToAppear() {
    this.loadMerchants();
  }

  // 加载商家列表
  async loadMerchants() {
    this.isLoading = true;
    const data = await this.fetchMerchantsFromBackend();
    this.isLoading = false;

    if (data && data.length > 0) {
      this.originalMerchants = data;
      // 根据当前排序类型初始化列表
      this.sortMerchants(this.currentSort);
    } else {
      console.warn('获取商家列表失败或数据为空');
      this.merchants = [];
    }
  }

  // 从后端获取商家列表
  async fetchMerchantsFromBackend(): Promise<Merchant[]> {
    const httpRequest = http.createHttp();
    const url = 'http://127.0.0.1:8080/web01/merchant';

    try {
      const response = await httpRequest.request(url, {
        method: http.RequestMethod.GET,
        connectTimeout: 10000,
        readTimeout: 10000,
        expectDataType: http.HttpDataType.STRING
      });

      if (response.responseCode === 200) {
        const rawData: string = response.result as string;
        const parsed: Record<string, Object> = JSON.parse(rawData);

        if (parsed && typeof parsed === 'object') {
          const code = parsed['code'] as number;
          const data = parsed['data'];
          if (code === 200 && Array.isArray(data)) {
            const backendList = data as BackendMerchant[];
            const merchants: Merchant[] = backendList.map((item: BackendMerchant): Merchant => ({
              id: item.id,
              name: item.name,
              logo: item.logo,
              avgRating: item.avgRating ?? 0,
              monthlySales: item.monthlySales ?? 0,
              deliveryTimeMinutes: item.deliveryTimeMinutes ? `${item.deliveryTimeMinutes}分钟` : '30分钟',
              minOrderAmount: item.minOrderAmount ?? 0,
              distance: '1.2km',
              tags: [] as string[],       // 显式指定类型，避免 untyped 错误
              avgPricePerPerson: item.avgPricePerPerson ?? 0
            }));
            return merchants;
          }
        }
        console.error('后端返回数据结构异常:', parsed);
        return [];
      } else {
        console.error(`HTTP错误，状态码：${response.responseCode}`);
        return [];
      }
    } catch (error) {
      console.error('请求异常：' + JSON.stringify(error));
      return [];
    } finally {
      httpRequest.destroy();
    }
  }

  // 排序处理
  sortMerchants(sortType: string) {
    this.currentSort = sortType;
    if (this.originalMerchants.length === 0) return;

    let sorted = [...this.originalMerchants];
    if (sortType === 'sales') {
      sorted.sort((a, b) => b.monthlySales - a.monthlySales);
    } else if (sortType === 'rating') {
      sorted.sort((a, b) => b.avgRating - a.avgRating);
    } else {
      // 综合排序：按id原始顺序
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
    // 这里可跳转商家详情页
  }

  build() {
    Column() {
      // 顶部导航栏
      this.buildNavBar();
      // 排序/筛选栏
      this.buildSortBar();
      // 商家列表（含加载状态和空状态）
      this.buildMerchantList();
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F5F7FA')
  }

  // 顶部导航栏
  @Builder
  buildNavBar() {
    Row() {
      Text('←')
        .fontSize(28)
        .fontColor('#3377FF')
        .width(40)
        .height(40)
        .textAlign(TextAlign.Center)
        .onClick(() => this.goBack())

      Text('商家列表')
        .fontSize(20)
        .fontWeight(FontWeight.Bold)
        .fontColor('#222222')
        .layoutWeight(1)
        .textAlign(TextAlign.Center)

      Row().width(40).height(40)
    }
    .width('100%')
    .height(56)
    .padding({ left: 12, right: 12 })
    .backgroundColor(Color.White)
    .shadow({ radius: 2, color: '#00000010', offsetY: 2 })
  }

  // 排序栏
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

  // 商家列表（含加载状态、空状态）
  @Builder
  buildMerchantList() {
    if (this.isLoading) {
      Column() {
        LoadingProgress()
          .width(50)
          .height(50)
          .color('#3377FF')
      }
      .width('100%')
      .height('100%')
      .justifyContent(FlexAlign.Center)
    } else if (this.merchants.length === 0) {
      Column() {
        Text('暂无商家数据')
          .fontSize(14)
          .fontColor('#999999')
      }
      .width('100%')
      .height('100%')
      .justifyContent(FlexAlign.Center)
    } else {
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
  }

  // 单个商家卡片
  @Builder
  buildMerchantCard(merchant: Merchant) {
    Column() {
      Row() {
        Text(merchant.logo)
          .fontSize(44)
          .width(70)
          .height(70)
          .backgroundColor('#F0F8FF')
          .borderRadius(16)
          .textAlign(TextAlign.Center)

        Column() {
          Row() {
            Text(merchant.name)
              .fontSize(18)
              .fontWeight(FontWeight.Medium)
              .fontColor('#222222')
            Blank()
            Row() {
              Text('⭐ ' + merchant.avgRating.toFixed(1))
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

          Row() {
            Text(`⏱️ ${merchant.deliveryTimeMinutes}`)
              .fontSize(12)
              .fontColor('#666666')
            Text(`💰 起送 ¥${merchant.minOrderAmount}`)
              .fontSize(12)
              .fontColor('#666666')
              .margin({ left: 16 })
            Text(`📍 1.2km`)//Text(`📍 ${merchant.distance}`)//暂时写死示例
              .fontSize(12)
              .fontColor('#666666')
              .margin({ left: 16 })
          }
          .width('100%')
          .margin({ bottom: 6 })

          Row() {
            Text(`人均 ¥${merchant.avgPricePerPerson}`)
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