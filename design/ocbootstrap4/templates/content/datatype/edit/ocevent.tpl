{def $content = false()}
{if $attribute.has_content}
  {set $content = $attribute.content}
{/if}
<div id="ocevent_attribute_{$attribute.id}">
  <div class="row">
    <div class="col-md-12">
      <div class="form-group row mb-0">
        <div class="col-md-6">
          <label for="StartDate_{$attribute.id}">{'Start'|i18n('ocevents/attribute')}</label>
          <input id="StartDate_{$attribute.id}" type="text" class="form-control ocevent-calendar startDate" name="dtstart" data-value="{if and(is_set($content.input.startDateTime), $content.input.startDateTime)}{$content.input.startDateTime}{/if}" value="">
        </div>

        <div class="col-md-6">
          <label for="EndDate_{$attribute.id}">{'End'|i18n('ocevents/attribute')}</label>
          <input id="EndDate_{$attribute.id}" type="text" class="form-control ocevent-calendar endDate" name="dtEnd" data-value="{if and(is_set($content.input.endDateTime), $content.input.endDateTime)}{$content.input.endDateTime}{/if}" value="">
        </div>
      </div>

      <div class="form-group row mb-0">
        <div class="col-md-6">
          <div class=" recurrence-container">
            <label>{'Recurrence'|i18n('ocevents/attribute')}</label>
            <select class="form-control recurrence" name="freq">
              <option data-value="none" value="none" {if and(is_set($content.input.freq), $content.input.freq|eq('none'))}selected="selected"{/if}>{'None (run once)'|i18n('ocevents/attribute')}</option>
              <option data-value="daily" value="3" {if and(is_set($content.input.freq), $content.input.freq|eq('3'))}selected="selected"{/if}>{'Daily'|i18n('ocevents/attribute')}</option>
              <option data-value="weekly" value="2" {if and(is_set($content.input.freq), $content.input.freq|eq('2'))}selected="selected"{/if}>{'Weekly'|i18n('ocevents/attribute')}</option>
              <option data-value="monthly" value="1" {if and(is_set($content.input.freq), $content.input.freq|eq('1'))}selected="selected"{/if}>{'Monthly'|i18n('ocevents/attribute')}</option>
            </select>
          </div>
        </div>

        <div class="col-md-6">
          <div class="interval-container hide  mb-0">
            <label>{'every'|i18n('ocevents/attribute')}</label>
            <input class="form-control interval" type="number" min="1" name="interval" value="{if and(is_set($content.input.interval), $content.input.interval)}{$content.input.interval}{else}1{/if}">
          </div>
        </div>
      </div>

      <div class="form-group weekly-container hide mb-0">
        <label>{'Select week day'|i18n('ocevents/attribute')}</label>
        <div class="form-check form-check-inline">
          <input id="byweekday0_{$attribute.id}" class="form-check-input" type="checkbox" name="byweekday" value="0" {if and(is_set($content.input.byweekday), $content.input.byweekday|contains('0'))}checked="checked"{/if}>
          <label class="form-check-label" for="byweekday0_{$attribute.id}">{'Mon'|i18n('ocevents/attribute')}</label>
        </div>
        <div class="form-check form-check-inline">
          <input id="byweekday1_{$attribute.id}" class="form-check-input" type="checkbox" name="byweekday" value="1" {if and(is_set($content.input.byweekday), $content.input.byweekday|contains('1'))}checked="checked"{/if}>
          <label class="form-check-label" for="byweekday1_{$attribute.id}">{'Tue'|i18n('ocevents/attribute')}</label>
        </div>
        <div class="form-check form-check-inline">
          <input id="byweekday2_{$attribute.id}" class="form-check-input" type="checkbox" name="byweekday" value="2" {if and(is_set($content.input.byweekday), $content.input.byweekday|contains('2'))}checked="checked"{/if}>
          <label class="form-check-label" for="byweekday2_{$attribute.id}">{'Wed'|i18n('ocevents/attribute')}</label>
        </div>
        <div class="form-check form-check-inline">
          <input id="byweekday3_{$attribute.id}" class="form-check-input" type="checkbox" name="byweekday" value="3" {if and(is_set($content.input.byweekday), $content.input.byweekday|contains('3'))}checked="checked"{/if}>
          <label class="form-check-label" for="byweekday3_{$attribute.id}">{'Thu'|i18n('ocevents/attribute')}</label>
        </div>
        <div class="form-check form-check-inline">
          <input id="byweekday4_{$attribute.id}" class="form-check-input" type="checkbox" name="byweekday" value="4" {if and(is_set($content.input.byweekday), $content.input.byweekday|contains('4'))}checked="checked"{/if}>
          <label class="form-check-label" for="byweekday4_{$attribute.id}">{'Fri'|i18n('ocevents/attribute')}</label>
        </div>
        <div class="form-check form-check-inline">
          <input id="byweekday5_{$attribute.id}" class="form-check-input" type="checkbox" name="byweekday" value="5" {if and(is_set($content.input.byweekday), $content.input.byweekday|contains('5'))}checked="checked"{/if}>
          <label class="form-check-label" for="byweekday5_{$attribute.id}">{'Sat'|i18n('ocevents/attribute')}</label>
        </div>
        <div class="form-check form-check-inline">
          <input id="byweekday6_{$attribute.id}" class="form-check-input" type="checkbox" name="byweekday" value="6" {if and(is_set($content.input.byweekday), $content.input.byweekday|contains('6'))}checked="checked"{/if}>
          <label class="form-check-label" for="byweekday6_{$attribute.id}">{'Sun'|i18n('ocevents/attribute')}</label>
        </div>
      </div>

      <div class="form-group monthly-container hide mb-0"></div>

      <div class="row untiltype-container hide mb-0">
        <div class="col-md-6">
          <div class="form-group">
            <label>{'End recurrence'|i18n('ocevents/attribute')}</label>
            <input type="text" class="form-control until ocevent-calendar" name="until" data-value="{if and(is_set($content.input.until), $content.input.until)}{$content.input.until}{/if}" value="">
          </div>
        </div>

        <div class="col-md-6">
          <div class="form-group">
          <label>{'Recurrence text'|i18n('ocevents/attribute')}</label>
          <input type="text" id="events_text_{$attribute.id}"data-value="text" name="{$attribute_base}_ocevent_data_{$attribute.id}[text]"
                 class="form-control" value="{if is_set($content.text)}{$content.text}{/if}"/>
          </div>
        </div>
      </div>
    </div>

  </div>

  <div class="row hide">
    <div class="col-md-12">
      <input type="hidden" id="has_content_{$attribute.id}" value="{$attribute.has_content}">
      <h3>Text</h3>

      <h3>Input</h3>
      <textarea id="events_input_{$attribute.id}" data-value="input" name="{$attribute_base}_ocevent_data_{$attribute.id}[input]" rows="10" cols="50"
                class="form-control">{if is_set($content.input_json)}{$content.input_json}{/if}</textarea>

      <h3>Recurrences</h3>
      <textarea id="events_recurrences_{$attribute.id}" data-value="recurrences" name="{$attribute_base}_ocevent_data_{$attribute.id}[recurrences]" rows="10" cols="50"
                class="form-control">{if is_set($content.recurrences_json)}{$content.recurrences_json}{/if}</textarea>

      <h3>Events</h3>
      <textarea id="events_{$attribute.id}" data-value="events" name="{$attribute_base}_ocevent_data_{$attribute.id}[events]" rows="10" cols="50"
                class="form-control">{if is_set($content.events_json)}{$content.events_json}{/if}</textarea>
    </div>
  </div>

  <div class="block-calendar-default block-calendar-big my-3">
      <div class="calendar"></div>
  </div>

  <div class="modal fade" tabindex="-1" role="dialog">
    <div class="modal-dialog" role="document">
      <div class="modal-content">
        <div class="modal-header" style="display: block">
          <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
          <h3 class="modal-title">{'Modify event'|i18n('ocevents/attribute')}</h3>
        </div>
        <div class="modal-body">
          <input type="hidden" id="title"/>
          <div class="form-group">
            <label for="starts-at">{'Start'|i18n('ocevents/attribute')}</label>
            <input type="text" class="form-control" name="starts_at" id="starts-at">
          </div>
          <div class="form-group">
            <label for="ends-at">{'End'|i18n('ocevents/attribute')}</label>
            <input type="text" class="form-control" name="ends_at" id="ends-at">
          </div>
        </div>
        <div class="modal-footer">
          <button type="button" class="btn btn-danger pull-left" data-dismiss="modal" id="delete-event"><i
              class="fa fa-trash"></i> {'Delete'|i18n('ocevents/attribute')}
          </button>
          <button type="button" class="btn btn-success" data-dismiss="modal" id="save-event"><i
              class="fa fa-save"></i> {'Store'|i18n('ocevents/attribute')}
          </button>
        </div>
      </div><!-- /.modal-content -->
    </div><!-- /.modal-dialog -->
  </div><!-- /.modal -->
</div>

{def $moment_language = fetch( 'content', 'locale' , hash( 'locale_code', ezini('RegionalSettings', 'Locale') )).http_locale_code|explode('-')[0]|downcase()|extract_left( 2 )}
{ezscript_require(array(
  'bootstrap-datetimepicker.min.js',
  'fullcalendar/core/main.js',
  concat('fullcalendar/core/locales/', $moment_language, '.js'),
  'fullcalendar/daygrid/main.js',
  'fullcalendar/list/main.js',
  'rrule.js',
  'jquery.ocevent.js'
))}
{ezcss_require(array(
  'fullcalendar/core/main.css',
  'fullcalendar/daygrid/main.css',
  'fullcalendar/list/main.css',
  'ocevent.css',
  'bootstrap-datetimepicker.min.css'
))}

<script>
$(document).ready(function () {ldelim}
  $('#ocevent_attribute_{$attribute.id}').oceventgui({ldelim}
      endpoint: "{'/recurrence/parse'|ezurl(no)}",
      local: '{$moment_language}'
  {rdelim});
{rdelim});
</script>
{undef $moment_language}

