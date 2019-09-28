;(function ($, window, document, undefined) {

    'use strict';

    var pluginName = 'oceventgui',
        defaults = {
            endpoint: '/',
            local: 'it',
            maxDate: moment(2524607999000),
            dateFormat: 'DD/MM/YYYY HH:mm'
        };

    function Plugin(element, options) {
        this.settings = $.extend({}, defaults, options);
        this.container = $(element);
        this.fields = {
            startDate: this.container.find('.startDate'),
            endDate: this.container.find('.endDate'),
            recurrence: this.container.find('.recurrence'),
            interval: this.container.find('.interval'),
            until: this.container.find('.until'),
        };

        var plugin = this;
        this.calendar = new FullCalendar.Calendar(plugin.container.find('.calendar')[0], {
            plugins: [ 'dayGrid', 'list' ],
            header: {
                left: 'prev,next',
                center: 'title',
                right: 'today'
                //right: 'dayGridDay,dayGridWeek,dayGridMonth'
            },
            height: 'parent',
            locale: $.opendataTools.settings('locale'),
            eventLimit: false,
            defaultView: 'dayGridMonth',
            windowResize: function (view) {
                var windowWidth = $(window).width();
                if (windowWidth < 800) {
                    this.changeView('listWeek');
                } else {
                    this.changeView('dayGridMonth');
                }
            },
            eventClick: function (event, element) {
                plugin.onCalendarEventClick(event, element);
            },
            events: function (info, successCallback, failureCallback) {
                var events = plugin.container.find('[data-value="events"]').val() || '[]';
                successCallback(JSON.parse(events));
            }
        });

        this.modal = this.container.find('.modal');
        this.modal.find("#starts-at, #ends-at").datetimepicker({
            locale: $.opendataTools.settings('locale')
        });

        this.init();
    }

    $.extend(Plugin.prototype, {
        init: function () {
            var plugin = this;

            plugin.fields.startDate.datetimepicker({
                locale: plugin.settings.locale,
                defaultDate: plugin.fields.startDate.data('value') !== '' ? moment(plugin.fields.startDate.data('value')) : moment().set('hour', 10).set('minute', 0)
            });

            plugin.fields.endDate.datetimepicker({
                locale: plugin.settings.locale,
                defaultDate: plugin.fields.endDate.data('value') !== '' ? moment(plugin.fields.endDate.data('value')) : moment().set('hour', 10).set('minute', 0)
            });

            plugin.fields.until.datetimepicker({
                locale: plugin.settings.locale,
                format: 'L',
                maxDate: plugin.settings.maxDate,
                defaultDate: plugin.fields.until.data('value') !== '' ? moment(plugin.fields.until.data('value')) : moment().add(6, 'months')
            });

            plugin.fields.recurrence.on('change', function () {
                plugin.showByRecurenceValue();
            });

            $.each(plugin.fields, function () {
                $(this).on('change', function () {
                    plugin.updateEvents();
                });
            });
            plugin.fields.startDate.on('dp.change', function () {
                plugin.updateEvents();
            });
            plugin.fields.endDate.on('dp.change', function () {
                plugin.updateEvents();
            });
            plugin.fields.until.on('dp.change', function () {
                plugin.updateEvents();
            });
            plugin.container.find('input[type=checkbox]').on('change', function () {
                plugin.updateEvents();
            });

            plugin.showByRecurenceValue();
            plugin.renderCalendar();
            $('body').on('shown.bs.tab', function (e) {
                plugin.calendar.render();
            });
        },

        hideOptionsFields: function () {
            this.container.find('.interval-container, .weekly-container, .monthly-container, .untiltype-container, .block-calendar-default').addClass('hide');
        },

        showByRecurenceValue: function () {
            var plugin = this;
            plugin.hideOptionsFields();
            switch (plugin.fields.recurrence.val()) {
                case 'none':
                    break;
                case '3': // Daily
                    plugin.container.find('.interval-container, .untiltype-container, .block-calendar-default').removeClass('hide');
                    break;
                case '2': // Weekly
                    plugin.container.find('.interval-container, .weekly-container, .untiltype-container, .block-calendar-default').removeClass('hide');
                    break;
                case '1': // Monthly
                    plugin.container.find('.interval-container, .monthly-container, .untiltype-container, .block-calendar-default').removeClass('hide');
                    break;
            }
        },

        parseDateValue: function(value){
            return moment(value, this.settings.dateFormat).toDate();
        },

        getCurrentRule: function () {
            var plugin = this;

            var start = plugin.fields.startDate.data("DateTimePicker").date();
            var freq = plugin.fields.recurrence.val();
            var interval = plugin.fields.interval.val();
            var until = plugin.fields.until.val().length > 0 ? plugin.fields.until.data("DateTimePicker").date() : plugin.settings.maxDate;

            switch (freq) {
                case 'none':
                    plugin.hideOptionsFields();

                    return new RRule({
                        dtstart: plugin.parseDateValue(start),
                        freq: '3',
                        interval: '1',
                        count: '1'
                    });

                case '3': // Daily
                case '1': // Monthly

                    return new RRule({
                        dtstart: plugin.parseDateValue(start),
                        freq: freq,
                        interval: interval,
                        until: plugin.parseDateValue(until)
                    });

                case '2': // Weekly

                    return new RRule({
                        dtstart: plugin.parseDateValue(start),
                        freq: freq,
                        interval: interval,
                        until: plugin.parseDateValue(until),
                        byweekday: plugin.getWeeklyValues()
                    });
            }

            return new RRule();
        },

        getWeeklyValues: function() {
            return this.container.find('input[type=checkbox]:checked').map(function (_, el) {
                return $(el).val();
            }).get();
        },

        updateEvents: function () {
            var plugin = this;

            var start = plugin.fields.startDate.data("DateTimePicker").date();
            var end = plugin.fields.endDate.data("DateTimePicker").date();
            var until = plugin.fields.until.data("DateTimePicker").date();
            var inputData = {
                startDateTime: start.format(),
                endDateTime: end.format(),
                freq: plugin.fields.recurrence.val(),
                interval: plugin.fields.interval.val(),
                until: until.format(),
                byweekday: plugin.getWeeklyValues(),
                timeZone: {
                    name: 'W. Europe Standard Time',
                    offset: start.format('Z')
                },
                recurrencePattern: plugin.getCurrentRule().toString()
            };

            $.ajax({
                type: "POST",
                url: plugin.settings.endpoint,
                data: inputData,
                success: function (data) {
                    if (data.error){
                        console.log(data.error);
                    }else {
                        plugin.container.find('[data-value="input"]').val(JSON.stringify(inputData));
                        plugin.container.find('[data-value="text"]').val(data.text);
                        plugin.container.find('[data-value="recurrences"]').val(JSON.stringify(data.recurrences));
                        plugin.container.find('[data-value="events"]').val(JSON.stringify(data.recurrences));
                        plugin.renderCalendar();
                    }
                },
                error: function (jqXHR) {
                    console.log(jqXHR.statusText);
                }
            });
        },

        renderCalendar: function(){
            var plugin = this;

            plugin.calendar.refetchEvents();
            plugin.calendar.render();
            window.dispatchEvent(new Event('resize'));
        },

        onCalendarEventClick: function(calEvent, element){
            var plugin = this;
            plugin.modal.modal('show');
            plugin.modal.find('#starts-at').data("DateTimePicker").date(moment(calEvent.event.start));
            plugin.modal.find('#ends-at').data("DateTimePicker").date(moment(calEvent.event.end));

            var events = JSON.parse(plugin.container.find('[data-value="events"]').val());
            var id = calEvent.event.id;

            plugin.modal.find('#save-event').on('click', function () {
                $.each(events, function () {
                   if (this.id === id){
                       this.start = $('#starts-at').data("DateTimePicker").date();
                       this.end = $('#ends-at').data("DateTimePicker").date();
                   }
                });
                plugin.container.find('[data-value="events"]').val(JSON.stringify(events));
                plugin.renderCalendar();
                plugin.modal.find('input').val('');
                $("#save-event").unbind("click");
            });

            plugin.modal.find('#delete-event').on('click', function () {
                events = events.filter(function(value){
                    return value.id !== id;
                });
                plugin.container.find('[data-value="events"]').val(JSON.stringify(events));
                plugin.renderCalendar();
                $("#delete-event").unbind("click");
            });
        }
    });

    $.fn[pluginName] = function (options) {
        return this.each(function () {
            if (!$.data(this, 'plugin_' + pluginName)) {
                $.data(this, 'plugin_' +
                    pluginName, new Plugin(this, options));
            }
        });
    };

})(jQuery, window, document);