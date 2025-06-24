/*!
 * Author:  Mark Allan B. Meriales
 * Name:    Mark Your Calendar v0.0.1
 * License: MIT License
 */

(function($) {
    // 加入 Date 原型擴充方法：增加天數
    Date.prototype.addDays = function(days) {
        var date = new Date(this.valueOf());
        date.setDate(date.getDate() + days);
        return date;
    }

    // jQuery 插件：markyourcalendar
    $.fn.markyourcalendar = function(opts) {
        var prevHtml = `<div id="myc-prev-week">&lt;</div>`;
        var nextHtml = `<div id="myc-next-week">&gt;</div>`;

        var defaults = {
            availability: [[], [], [], [], [], [], []], // 每天的時段陣列
            isMultiple: false,
            months: ['jan', 'feb', 'mar', 'apr', 'may', 'jun', 'jul', 'aug', 'sep', 'oct', 'nov', 'dec'],
            prevHtml: prevHtml,
            nextHtml: nextHtml,
            selectedDates: [],
            startDate: new Date(),
            weekdays: ['sun', 'mon', 'tue', 'wed', 'thurs', 'fri', 'sat']
        };

        var settings = $.extend({}, defaults, opts);
        var onClick = settings.onClick;
        var onClickNavigator = settings.onClickNavigator;
        var instance = this;

        // 取得月份名稱
        this.getMonthName = function(idx) {
            return settings.months[idx];
        };

        // 格式化日期 yyyy-mm-dd
        var formatDate = function(d) {
            var date = '' + d.getDate();
            var month = '' + (d.getMonth() + 1);
            var year = d.getFullYear();
            if (date.length < 2) date = '0' + date;
            if (month.length < 2) month = '0' + month;
            return year + '-' + month + '-' + date;
        };

        // 導覽控制器
        this.getNavControl = function() {
            var previousWeekHtml = `<div id="myc-prev-week-container">` + settings.prevHtml + `</div>`;
            var nextWeekHtml = `<div id="myc-next-week-container">` + settings.nextHtml + `</div>`;
            var monthYearHtml = `
                <div id="myc-current-month-year-container">
                    ${this.getMonthName(settings.startDate.getMonth())} ${settings.startDate.getFullYear()}
                </div>`;

            return `
                <div id="myc-nav-container">
                    ${previousWeekHtml}
                    ${monthYearHtml}
                    ${nextWeekHtml}
                    <div style="clear:both;"></div>
                </div>`;
        };

        // 日期區塊標題列
        this.getDatesHeader = function() {
            var tmp = ``;
            for (var i = 0; i < 7; i++) {
                var d = settings.startDate.addDays(i);
                tmp += `
                    <div class="myc-date-header" id="myc-date-header-${i}">
                        <div class="myc-date-number">${d.getDate()}</div>
                        <div class="myc-date-display">${settings.weekdays[d.getDay()]}</div>
                    </div>`;
            }
            return `<div id="myc-dates-container">${tmp}</div>`;
        };

        // 顯示每一天的可預約時間
        this.getAvailableTimes = function() {
            var tmp = ``;
            var today = new Date();
            today.setHours(0, 0, 0, 0);

            for (var i = 0; i < 7; i++) {
                var tmpAvailTimes = ``;
                var d = settings.startDate.addDays(i);
                var isBeforeToday = d < today;

                $.each(settings.availability[i], function(index, slot) {
                    var className = isBeforeToday ? 'myc-available-time disabled' : 'myc-available-time';
                    var ariaAttr = isBeforeToday ? 'aria-disabled="true"' : '';

                    tmpAvailTimes += `
                        <a href="javascript:;" class="${className}" ${ariaAttr}
                            data-time="${slot.time}"
                            data-date="${formatDate(d)}"
                            data-week="${settings.weekdays[d.getDay()]}"
                            data-unique="${slot.id}">
                            ${slot.time}
                        </a>`;
                });

                if (tmpAvailTimes.trim() === ``) {
                    tmpAvailTimes = isBeforeToday
                        ? `<span class="no-available">無法預約</span>`
                        : `<span class="no-available">暫無可預約時段</span>`;
                }

                tmp += `
                    <div class="myc-day-time-container" id="myc-day-time-container-${i}">
                        ${tmpAvailTimes}
                        <div style="clear:both;"></div>
                    </div>`;
            }

            return tmp;
        };

        // 設定時段資料
        this.setAvailability = function(arr) {
            settings.availability = arr;
            render();
        };

        // 清除時段
        this.clearAvailability = function() {
            settings.availability = [[], [], [], [], [], [], []];
        };

        // 前一週按鈕事件
        this.on('click', '#myc-prev-week', function() {
            settings.startDate = settings.startDate.addDays(-7);
            instance.clearAvailability();
            render();

            if ($.isFunction(onClickNavigator)) {
                onClickNavigator.call(this, ...arguments, settings.startDate, instance);
            }
        });

        // 下一週按鈕事件
        this.on('click', '#myc-next-week', function() {
            settings.startDate = settings.startDate.addDays(7);
            instance.clearAvailability();
            render();

            if ($.isFunction(onClickNavigator)) {
                onClickNavigator.call(this, ...arguments, settings.startDate, instance);
            }
        });

        // 點選某個時段
        this.on('click', '.myc-available-time', function() {
            if ($(this).hasClass('disabled')) return;

            var date = $(this).data('date');
            var week = $(this).data('week');
            var time = $(this).data('time');
            var tmp = `${date}(${week}) ${time}`;

            if ($(this).hasClass('selected')) {
                $(this).removeClass('selected');
                var idx = settings.selectedDates.indexOf(tmp);
                if (idx !== -1) settings.selectedDates.splice(idx, 1);
            } else {
                if (settings.isMultiple) {
                    $(this).addClass('selected');
                    settings.selectedDates.push(tmp);
                } else {
                    settings.selectedDates = [tmp];
                    $('.myc-available-time').removeClass('selected');
                    $(this).addClass('selected');
                }
            }

            if ($.isFunction(onClick)) {
                onClick.call(this, ...arguments, settings.selectedDates);
            }
        });

        // 初始化畫面
        var render = function() {
            var ret = `
                <div id="myc-container">
                    ${instance.getNavControl()}
                    <div id="myc-week-container">
                        ${instance.getDatesHeader()}
                        <div id="myc-available-time-container">
                            ${instance.getAvailableTimes()}
                        </div>
                    </div>
                </div>`;
            instance.html(ret);
        };

        render();
    };
})(jQuery);
