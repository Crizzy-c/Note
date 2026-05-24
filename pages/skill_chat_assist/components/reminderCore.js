// 核心提醒模块（由AI辅助生成）
window.reminderCore = (function() {
    const STORAGE_KEY = 'smart_reminders';
    let activeTimeouts = {};

    //从本地读取历史记录（if）
    function getReminders() {
        const stored = localStorage.getItem(STORAGE_KEY);
        return stored ? JSON.parse(stored) : [];
    }
    function saveReminders(reminders) {
        localStorage.setItem(STORAGE_KEY, JSON.stringify(reminders));
    }

    // 自然语言解析（提取数字和事件）
    function parseNaturalLanguage(input) {
        // 数字 + 分钟/分/min/m + 可选“后” + 可选“提醒我” + 剩余内容
        const regex = /(\d+)\s*(分钟|分|min|m)\s*(后)?\s*(提醒我)?\s*(.*)/i;
        const match = input.match(regex);
        if (!match) return null;
        let minutes = parseInt(match[1]);
        let eventPart = (match[5] || "").trim();
        if (eventPart === "") {
            // 如果没提取到事件，尝试去掉数字和单位后的整个剩余部分重新提取
            const withoutNumber = input.replace(/^\d+\s*(分钟|分|min|m)\s*(后)?\s*(提醒我)?\s*/i, '').trim();
            eventPart = withoutNumber || "提醒事项";
        }
        if (eventPart === "") eventPart = "事项";
        return { minutes, event: eventPart };
    }

    function addReminder(minutes, eventText, onAddCallback) {
        if (isNaN(minutes) || minutes <= 0) {
            if (onAddCallback) onAddCallback('error', '分钟数必须是1~120之间的数字');
            return false;
        }
        if (minutes > 120) {
            if (onAddCallback) onAddCallback('error', '最长只能120分钟');
            return false;
        }
        if (!eventText.trim()) {
            if (onAddCallback) onAddCallback('error', '请填写事情内容');
            return false;
        }
        const id = Date.now();
        const triggerAt = Date.now() + minutes * 60 * 1000;
        const newReminder = {
            id: id,
            text: eventText.trim(),
            duration: minutes,
            triggerAt: triggerAt,
            done: false,
            notified: false
        };
        
        const reminders = getReminders();
        reminders.push(newReminder);
        saveReminders(reminders);
        scheduleReminder(newReminder);
        if (onAddCallback) onAddCallback('success', { minutes, event: eventText, triggerAt });
        return true;
    }

    function scheduleReminder(reminder) {
        if (reminder.done) return;
        const now = Date.now();
        const delay = reminder.triggerAt - now;
        if (delay <= 0) {
            triggerReminder(reminder.id);
            return;
        }
        const timeoutId = setTimeout(() => triggerReminder(reminder.id), delay);
        activeTimeouts[reminder.id] = timeoutId;
    }

    function triggerReminder(id) {
        const reminders = getReminders();
        const index = reminders.findIndex(r => r.id === id);
        if (index === -1) return;
        const rem = reminders[index];
        if (rem.done) return;
        rem.done = true;
        rem.notified = true;
        saveReminders(reminders);
        if (activeTimeouts[id]) {
            clearTimeout(activeTimeouts[id]);
            delete activeTimeouts[id];
        }
        // 安全调用页面弹窗函数
        if (typeof window.showAlertMessage === 'function') {
            window.showAlertMessage(`🔔 提醒：${rem.text}`);
        } else {
            alert(`🔔 提醒：${rem.text}`);
        }
        // 浏览器通知
        if (Notification.permission === 'granted') {
            new Notification('⏰ 定时提醒', { body: rem.text });
        }
        if (typeof window.onReminderTrigger === 'function') {
            window.onReminderTrigger(rem.text);
        }
    }

    function deleteReminder(id) {
        if (activeTimeouts[id]) {
            clearTimeout(activeTimeouts[id]);
            delete activeTimeouts[id];
        }
        let reminders = getReminders();
        reminders = reminders.filter(r => r.id !== id);
        saveReminders(reminders);
    }

    function getUpcomingReminders() {
        const now = Date.now();
        const reminders = getReminders();
        return reminders.filter(r => !r.done && r.triggerAt > now)
                        .sort((a,b) => a.triggerAt - b.triggerAt);
    }

    function getHistoryReminders() {
        const reminders = getReminders();
        return reminders.filter(r => r.done === true)
                        .sort((a,b) => b.triggerAt - a.triggerAt);
    }

    function reloadAllTimers() {
        Object.values(activeTimeouts).forEach(tid => clearTimeout(tid));
        activeTimeouts = {};
        const reminders = getReminders();
        reminders.forEach(rem => {
            if (!rem.done && rem.triggerAt > Date.now()) {
                scheduleReminder(rem);
            }
        });
    }

    function clearAllData() {
        Object.values(activeTimeouts).forEach(tid => clearTimeout(tid));
        activeTimeouts = {};
        localStorage.removeItem(STORAGE_KEY);
    }

    return {
        parseNaturalLanguage,
        addReminder,
        deleteReminder,
        getUpcomingReminders,
        getHistoryReminders,
        reloadAllTimers,
        clearAllData,
        getReminders,
        saveReminders
    };
})();