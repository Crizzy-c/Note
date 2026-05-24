// 公共页眉（自动适配根目录和 views 子目录，由AI辅助生成）
window.renderHeader = function(activePage = 'chat') {
    // 判断当前页面是否在 views/ 目录下
    const inViews = window.location.pathname.includes('/views/');
    const prefix = inViews ? '../' : './';
    return `
        <header class="site-header">
            <div class="logo">💬 智能提醒助手</div>
            <ul class="nav-links">
                <li><a href="${prefix}index.html" class="${activePage === 'chat' ? 'active' : ''}">首页</a></li>
                <li><a href="${prefix}views/guide.html" class="${activePage === 'guide' ? 'active' : ''}">教程</a></li>
                <li><a href="${prefix}views/stats.html" class="${activePage === 'stats' ? 'active' : ''}">统计</a></li>
                <li><a href="${prefix}views/history.html" class="${activePage === 'history' ? 'active' : ''}">历史</a></li>
                <li><a href="${prefix}views/settings.html" class="${activePage === 'settings' ? 'active' : ''}">设置</a></li>
            </ul>
        </header>
    `;
};