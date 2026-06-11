// ChangePasswordPage.ets
import http from '@ohos.net.http';
import { promptAction ,router} from '@kit.ArkUI';

// 修改密码请求参数
interface ChangePwdParams {
  userNo: string;      // 学号（通常需要用户标识，可从全局或本地存储获取）
  oldPassword: string;
  newPassword: string;
}

interface RePasswordData {
  id: number;
  userNo: string;
  name: string;
  avatar?: string;
}

// 后端返回的响应结构
interface ChangePwdResponse {
  code: number;
  msg: string;
  data?: RePasswordData;
}

@Entry
@Component
struct ChangePasswordPage {
  @State userNo: string = '';           // 学号（可从本地存储或登录状态获取）
  @State oldPassword: string = '';
  @State newPassword: string = '';
  @State confirmPassword: string = '';
  @State isLoading: boolean = false;

  // 密码显示状态
  @State showOldPassword: boolean = false;
  @State showNewPassword: boolean = false;
  @State showConfirmPassword: boolean = false;

  // 页面加载时，可尝试从存储获取学号（示例：通过 router 参数）
  aboutToAppear() {
    // 假设从 router 参数获取学号，如果没有则留空（需用户手动输入）
    const params = router.getParams() as Record<string, string>;
    if (params && params['userNo']) {
      this.userNo = params['userNo'];
    }
    // 实际项目中可从 Preferences 或 AppStorage 获取已登录学号
  }

  // 执行修改密码
  async doChangePassword() {
    // 前端校验
    if (this.userNo.trim() === '') {
      promptAction.showToast({
        message: '学号不能为空',
        duration: 500
      });
      console.error('学号不能为空');
      return;
    }
    if (this.oldPassword.trim() === '') {
      promptAction.showToast({
        message: '旧密码不能为空',
        duration: 500
      });
      console.error('旧密码不能为空');
      return;
    }
    if (this.newPassword.trim() === '') {
      promptAction.showToast({
        message: '新密码不能为空',
        duration: 500
      });
      console.error('新密码不能为空');
      return;
    }
    if (this.newPassword !== this.confirmPassword) {
      promptAction.showToast({
        message: '两次输入的新密码不一致',
        duration: 500
      });
      console.error('两次输入的新密码不一致');
      return;
    }
    if (this.newPassword.length < 6) {
      promptAction.showToast({
        message: '新密码长度至少6位',
        duration: 500
      });
      console.error('新密码长度至少6位');
      return;
    }
    if (this.oldPassword === this.newPassword) {
      promptAction.showToast({
        message: '新密码不能与旧密码相同',
        duration: 500
      });
      console.error('新密码不能与旧密码相同');
      return;
    }

    this.isLoading = true;
    const httpRequest = http.createHttp();
    const url = 'http://127.0.0.1:8080/web01/changePassword';  // 请替换为实际修改密码接口

    const requestBody: ChangePwdParams = {
      userNo: this.userNo,
      oldPassword: this.oldPassword,
      newPassword: this.newPassword
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
        const responseData: ChangePwdResponse = JSON.parse(response.result as string);
        if (responseData.code === 200) {
          console.info('修改密码成功', responseData.msg);
          // 修改成功后，可提示并跳转到登录页（或返回上一页）
          router.pushUrl({ url: 'pages/sonPages/login' })
            .catch((err: Error) => {
              console.error('跳转失败：' + err.message);
            });
        } else {
          console.error('修改密码失败:', responseData.msg);
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

  // 跳转到登录页
  goToLogin() {
    router.pushUrl({ url: 'pages/sonPages/login' })
      .catch((err: Error) => {
        console.error('跳转失败：' + err.message);
      });
  }

  // 构建输入框（完全复用登录页的 Builder，支持独立的密码显示状态）
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

      // 中间卡片区域
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

        Text('修改密码')
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .fontColor('#222222')
          .margin({ bottom: 8 })

        Text('请设置新密码，确保账号安全')
          .fontSize(14)
          .fontColor('#888888')
          .margin({ bottom: 32 })

        // 学号输入框（如果已登录可隐藏或只读，这里保留可编辑）
        this.buildInputItem('👤', '学号', this.userNo, (val: string) => { this.userNo = val }, false)

        // 旧密码输入框
        this.buildInputItem('🔒', '旧密码', this.oldPassword, (val: string) => { this.oldPassword = val }, true, this.showOldPassword, () => {
          this.showOldPassword = !this.showOldPassword
        })

        // 新密码输入框
        this.buildInputItem('🔒', '新密码', this.newPassword, (val: string) => { this.newPassword = val }, true, this.showNewPassword, () => {
          this.showNewPassword = !this.showNewPassword
        })

        // 确认新密码输入框
        this.buildInputItem('🔒', '确认新密码', this.confirmPassword, (val: string) => { this.confirmPassword = val }, true, this.showConfirmPassword, () => {
          this.showConfirmPassword = !this.showConfirmPassword
        })

        // 修改按钮
        Button(this.isLoading ? '提交中...' : '确认修改')
          .width('100%')
          .height(52)
          .fontSize(18)
          .fontWeight(FontWeight.Medium)
          .backgroundColor('#3377FF')
          .borderRadius(26)
          .margin({ top: 10, bottom: 20 })
          .enabled(!this.isLoading)
          .onClick(() => {
            this.doChangePassword();
          })

        // 辅助链接：返回登录
        Row() {
          Text('← 返回登录')
            .fontSize(14)
            .fontColor('#3377FF')
            .padding({ left: 8, right: 8 })
            .onClick(() => {
              this.goToLogin();
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
      Text('© 2025 校园通 · 智慧校园')
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