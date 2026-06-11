// LoginPage.ets
import http from '@ohos.net.http';
import { router } from '@kit.ArkUI';


// 请求参数
interface LoginParams {
  userNo: string;
  password: string;
}

// 后端返回的 data 对象实际结构
interface LoginData {
  id: number;
  userNo: string;
  name: string;
  avatar?: string;
}

// 后端返回的整体响应结构
interface LoginResponse {
  code: number;
  msg: string;
  data?: LoginData;
}

@Entry
@Component
struct LoginPage {
  @State userNo: string = '';
  @State password: string = '';
  @State isLoading: boolean = false;     // 登录加载状态
  @State showPassword: boolean = false;   // 密码是否明文显示

  // 执行登录
  async doLogin() {
    if (this.userNo.trim() === '' || this.password.trim() === '') {
      console.error('学号或密码不能为空');
      // 实际项目可弹 toast 提示，这里仅控制台输出
      return;
    }

    this.isLoading = true;
    const httpRequest = http.createHttp();
    const url = 'http://127.0.0.1:8080/web01/login';

    const requestBody: LoginParams = {
      userNo: this.userNo,
      password: this.password
    };

    try {
      const response = await httpRequest.request(url, {
        method: http.RequestMethod.POST,
        header: { 'Content-Type': 'application/json' },
        extraData: JSON.stringify(requestBody),
        connectTimeout: 10000,
        readTimeout: 10000
      });

      if (response.responseCode === 200) {
        const responseData: LoginResponse = JSON.parse(response.result as string);
        if (responseData.code === 200) {
          console.info('登录成功', responseData.msg);
          const userId = responseData.data?.id;
          const userName = responseData.data?.name;
          const userNo = responseData.data?.userNo;
          console.info(`用户ID: ${userId}, 用户名: ${userName}, 学号: ${userNo}`);

          // 跳转到首页（Index 页面）
          router.pushUrl({ url: 'pages/Index' })  // 注意路径根据实际情况调整
            .catch((err: Error) => {
              console.error('跳转失败：' + err.message);
            });
        } else {
          console.error('登录失败:', responseData.msg);
          // 可在此处提示用户，比如用 prompt.showToast
        }
      } else {
        console.error(`HTTP请求失败，状态码：${response.responseCode}`);
      }
    } catch (error) {
      console.error('请求异常：' + JSON.stringify(error));
    } finally {
      httpRequest.destroy();
      this.isLoading = false;
    }
  }

  // 构建输入框（带图标、圆角、占位符）
  @Builder
  buildInputItem(icon: string, placeholder: string, value: string, onChange: (val: string) => void, isPassword: boolean = false) {
    Row() {
      Text(icon)
        .fontSize(22)
        .width(36)
        .textAlign(TextAlign.Center)
        .fontColor('#666666')

      TextInput({ placeholder: placeholder, text: value })
        .layoutWeight(1)
        .height(48)
        .fontSize(16)
        .backgroundColor('transparent')
        .placeholderColor('#999999')
        .border({ width: 0 })
        .type(isPassword && !this.showPassword ? InputType.Password : InputType.Normal)
        .onChange(onChange)


    }
    .width('100%')
    .height(52)
    .backgroundColor('#F8F9FA')
    .borderRadius(12)
    .padding({ left: 12, right: 8 })
    .margin({ bottom: 18 })
  }

  build() {
    Column() {
      // 顶部装饰或留白（安全区扩展可选）
      Column()
        .height('8%')

      // 中间登录卡片区域
      Column() {
        // Logo / App 名称
        Row() {
          Image($r("app.media.schoolLogo"))
            .width(50)
            .margin({right:5})
          Text('西安文理学院')
            .fontSize(32)
            .fontWeight(FontWeight.Bold)
            .fontColor('#222222')
        }
        .margin({ top: 24, bottom: 32 })

        Text('智慧校园')
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .fontColor('#222222')
          .margin({ bottom: 8 })

        Text('请使用学号和密码登录')
          .fontSize(14)
          .fontColor('#888888')
          .margin({ bottom: 32 })

        // 学号输入框
        this.buildInputItem('👤', '学号', this.userNo, (val: string) => { this.userNo = val }, false)

        // 密码输入框（带眼睛切换）
        this.buildInputItem('🔒', '密码', this.password, (val: string) => { this.password = val }, true)

        // 登录按钮
        Button(this.isLoading ? '登录中...' : '登 录')
          .width('100%')
          .height(52)
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .backgroundColor('#3377FF')
          .borderRadius(26)
          .margin({ top: 10, bottom: 20 })
          .enabled(!this.isLoading)
          .onClick(() => {
            this.doLogin();
          })

        // 辅助链接（注册 / 忘记密码）
        Row() {
          Text('忘记密码？')
            .fontSize(14)
            .fontColor('#666666')
            .padding({ left: 8, right: 8 })
            .onClick(() => {
              console.info('跳转忘记密码');
              // 可跳转忘记密码页
              try {
                const uiContext = this.getUIContext();
                const router = uiContext.getRouter();
                router.pushUrl({ url: 'pages/sonPages/rePassword' })

                  .catch((err: Error) => {
                    console.error('跳转失败：' + err.message);
                  });
              } catch (error) {
                console.error('获取路由失败：' + JSON.stringify(error));
              }
            })

          Blank()

          Text('注册账号')
            .fontSize(14)
            .fontColor('#3377FF')
            .padding({ left: 8, right: 8 })
            .onClick(() => {
              console.info('跳转注册页面');
              // 可跳转注册页
              try {
                const uiContext = this.getUIContext();
                const router = uiContext.getRouter();
                router.pushUrl({ url: 'pages/sonPages/register' })

                  .catch((err: Error) => {
                    console.error('跳转失败：' + err.message);
                  });
              } catch (error) {
                console.error('获取路由失败：' + JSON.stringify(error));
              }
            })

        }
        .width('100%')
        .margin({ bottom: 28 })
      }
      .width('85%')
      .backgroundColor(Color.White)
      .borderRadius(28)
      .padding({ left: 24, right: 24, top: 20, bottom: 10 })
      .shadow({ radius: 16, color: '#0000001A', offsetY: 4 })

      // 底部版本信息
      Text('版权所有© Copyright 西安文理学院 版本V-1.0')
        .fontSize(12)
        .fontColor('#AAAAAA')
        .margin({ top: 40, bottom: 20 })
    }
    .width('100%')
    .height('100%')
    .justifyContent(FlexAlign.Center)
    .alignItems(HorizontalAlign.Center)
    .backgroundColor('#F5F7FA')
    .expandSafeArea([SafeAreaType.SYSTEM], [SafeAreaEdge.TOP, SafeAreaEdge.BOTTOM])
  }
}