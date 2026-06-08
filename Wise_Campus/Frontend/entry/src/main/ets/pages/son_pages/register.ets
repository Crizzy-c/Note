// RegisterPage.ets
import http from '@ohos.net.http';
import { router } from '@kit.ArkUI';

// 注册请求参数
interface RegisterParams {
  userNo: string;
  name: string;
  password: string;
}

// 后端返回的 data 对象结构
interface RegisterData {
  id: number;
  userNo: string;
  name: string;
  avatar?: string;
}

// 后端返回的整体响应结构
interface RegisterResponse {
  code: number;
  msg: string;
  data?: RegisterData;
}

@Entry
@Component
struct RegisterPage {
  @State userNo: string = '';
  @State phone: string = '';
  @State password: string = '';
  @State confirmPassword: string = '';
  @State isLoading: boolean = false;
  @State showPassword: boolean = false;
  @State showConfirmPassword: boolean = false;  // 确认密码的眼睛状态

  // 执行注册
  async doRegister() {
    // 前端校验
    if (this.userNo.trim() === '') {
      console.error('学号不能为空');
      return;
    }
    if (this.phone.trim() === '') {
      console.error('手机号不能为空');
      return;
    }
    if (this.password.trim() === '') {
      console.error('密码不能为空');
      return;
    }
    if (this.password !== this.confirmPassword) {
      console.error('两次输入的密码不一致');
      return;
    }

    this.isLoading = true;
    const httpRequest = http.createHttp();
    const url = 'http://127.0.0.1:8080/web01/register';  // 请替换为实际注册接口

    const requestBody: RegisterParams = {
      userNo: this.userNo,
      name: this.phone,
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
        const responseData: RegisterResponse = JSON.parse(response.result as string);
        if (responseData.code === 200) {
          console.info('注册成功', responseData.msg);
          // 注册成功跳转到登录页
          router.pushUrl({ url: 'pages/LoginPage' })
            .catch((err: Error) => {
              console.error('跳转失败：' + err.message);
            });
        } else {
          console.error('注册失败:', responseData.msg);
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

  // 构建输入框（完全复用登录页的 Builder，但支持独立的密码显示状态）
  @Builder
  buildInputItem(icon: string, placeholder: string, value: string, onChange: (val: string) => void, isPassword: boolean = false, passwordState?: boolean, onToggle?: () => void) {
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
        .type(isPassword && !(passwordState ?? false) ? InputType.Password : InputType.Normal)
        .onChange(onChange)

      if (isPassword) {
        Text(passwordState ? '🙈' : '👁️')
          .fontSize(20)
          .width(40)
          .textAlign(TextAlign.Center)
          .onClick(() => {
            if (onToggle) onToggle();
          })
          .fontColor('#888888')
      } else {
        Row().width(40)
      }
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
      // 顶部留白
      Column()
        .height('8%')

      // 中间登录卡片区域
      Column() {
        // Logo / App 名称
        Row() {
          Image($r("app.media.schoolLogo"))
            .width(50)
            .margin({ right: 5 })
          Text('西安文理学院')
            .fontSize(32)
            .fontWeight(FontWeight.Bold)
            .fontColor('#222222')
        }
        .margin({ top: 24, bottom: 32 })

        Text('注册账号')
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .fontColor('#222222')
          .margin({ bottom: 8 })

        Text('请填写信息完成注册')
          .fontSize(14)
          .fontColor('#888888')
          .margin({ bottom: 32 })

        // 学号输入框
        this.buildInputItem('👤', '学号', this.userNo, (val: string) => { this.userNo = val }, false)

        // 昵称输入框
        this.buildInputItem('📛', '手机号', this.phone, (val: string) => { this.phone = val }, false)

        // 密码输入框
        this.buildInputItem('🔒', '密码', this.password, (val: string) => { this.password = val }, true, this.showPassword, () => {
          this.showPassword = !this.showPassword
        })

        // 确认密码输入框
        this.buildInputItem('🔒', '确认密码', this.confirmPassword, (val: string) => { this.confirmPassword = val }, true, this.showConfirmPassword, () => {
          this.showConfirmPassword = !this.showConfirmPassword
        })

        // 注册按钮
        Button(this.isLoading ? '注册中...' : '注 册')
          .width('100%')
          .height(52)
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .backgroundColor('#3377FF')
          .borderRadius(26)
          .margin({ top: 10, bottom: 20 })
          .enabled(!this.isLoading)
          .onClick(() => {
            this.doRegister();
          })

        // 辅助链接（已有账号？去登录）
        Row() {
          Text('已有账号？')
            .fontSize(14)
            .fontColor('#666666')
            .padding({ left: 8, right: 8 })
            .onClick(() => {
              router.pushUrl({ url: 'pages/LoginPage' })
                .catch((err: Error) => {
                  console.error('跳转失败：' + err.message);
                });
            })

          Blank()

          Text('去登录')
            .fontSize(14)
            .fontColor('#3377FF')
            .padding({ left: 8, right: 8 })
            .onClick(() => {
              router.pushUrl({ url: 'pages/LoginPage' })
                .catch((err: Error) => {
                  console.error('跳转失败：' + err.message);
                });
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