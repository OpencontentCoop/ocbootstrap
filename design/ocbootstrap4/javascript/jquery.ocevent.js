;(function ($, window, document, undefined) {

    'use strict';

    var pluginName = 'oceventgui',
        defaults = {
            endpoint: '/',
            locale: 'it',
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
            locale: plugin.settings.locale,
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
                var events = plugin.container.find('[data-value="events"]').val();                
                if (events.length > 0 && events !== 'null'){
                    successCallback(JSON.parse(events));
                }else{
                    successCallback([]);
                }
            }
        });

        this.modal = this.container.find('.modal');
        this.modal.find("#starts-at, #ends-at").datetimepicker({
            locale: plugin.settings.locale
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
                defaultDate: plugin.fields.endDate.data('value') !== '' ? moment(plugin.fields.endDate.data('value')) : moment().set('hour', 12).set('minute', 0)
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
            var end = plugin.fields.endDate.data("DateTimePicker").date();
            var freq = plugin.fields.recurrence.val();
            var interval = plugin.fields.interval.val();
            var until = plugin.fields.until.val().length > 0 ? plugin.fields.until.data("DateTimePicker").date() : plugin.settings.maxDate;

            switch (freq) {
                case 'none':
                    plugin.hideOptionsFields();

                    return new RRule({
                        dtstart: plugin.parseDateValue(start),
                        dtend: plugin.parseDateValue(end),
                        freq: '3',
                        interval: '1',
                        count: '1'
                    });

                case '3': // Daily
                case '1': // Monthly

                    return new RRule({
                        dtstart: plugin.parseDateValue(start),
                        dtend: plugin.parseDateValue(end),
                        freq: freq,
                        interval: interval,
                        until: plugin.parseDateValue(until)
                    });

                case '2': // Weekly

                    return new RRule({
                        dtstart: plugin.parseDateValue(start),
                        dtend: plugin.parseDateValue(end),
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
                    offset: start.format('Z')
                },
                recurrencePattern: plugin.getCurrentRule().toString()
            };

            var csrfToken;
            var tokenNode = document.getElementById('ezxform_token_js');
            if ( tokenNode ){
                csrfToken = tokenNode.getAttribute('title');
            }

            $.ajax({
                type: 'POST',
                url: plugin.settings.endpoint,
                headers: {'X-CSRF-TOKEN': csrfToken},
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
                    console.log(jqXHR.responseJSON.error);
                    if (jqXHR.responseJSON.code === 100) {
                        plugin.fields.endDate.data("DateTimePicker").date(new Date(moment(inputData.startDateTime).add('1', 'minutes').format()));
                    }
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
                       this.start = moment($('#starts-at').data("DateTimePicker").date()).format('YYYY-MM-DDTHH:mm:ssZ');
                       this.end = moment($('#ends-at').data("DateTimePicker").date()).format('YYYY-MM-DDTHH:mm:ssZ');
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