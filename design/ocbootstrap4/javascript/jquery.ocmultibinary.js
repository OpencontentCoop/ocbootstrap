;(function($) {

    $.fn.ocmultibinary = function(method) {

        var methods = {

            init : function(options) {
                this.ocmultibinary.settings = $.extend({}, this.ocmultibinary.defaults, options);
                return this.each(function() {
                    var $element = $(this),
                        element = this;

                    var $buttonContainer = $element.find('.upload-button-container');
                    var $spinner = $element.find('.upload-button-spinner');
                    var $fileList = $element.find('.upload-file-list');
                    var $conflictBox = $element.find('.upload-conflict-box');
                    var $conflictAnchor = $element.find('.upload-conflict-anchor');
                    var $conflictList = $conflictBox.find('.upload-conflict-box-list');
                    var $conflictRowTemplate = $element.find('.upload-conflict-row-template');

                    var csrfToken;
                    var tokenNode = document.getElementById('ezxform_token_js');
                    if ( tokenNode ){
                        csrfToken = tokenNode.getAttribute('title');
                    }

                    var _sort = function(el) {
                        $(el).sortable({
                            update: function( event, ui ) {
                                var files = [];
                                $(this).children().each(function(index) {
                                    $(this).find('.sort').val(index);
                                    files.push($(this).find('.sort').data('filename'));
                                });

                                $.ajax({
                                    url: $fileList.data('sorturl'),
                                    headers: {'X-CSRF-TOKEN': csrfToken},
                                    dataType: "json",
                                    type: "post",
                                    cache: false,
                                    data: {
                                        files: JSON.stringify(files)
                                    },
                                    success: function (response) {
                                        //console.log(response)
                                    }
                                });


                            }
                        });
                    };

                    // Add sort feature to list
                    _sort($fileList.find('.list tbody'));

                    // Names of the files already attached to this field, used to detect
                    // a name conflict before a new upload starts. Kept decoded (human
                    // readable) since eZMultiBinaryFile stores original_filename urlencoded.
                    var _existingFilenames = function () {
                        var names = [];
                        $fileList.find('.list tbody tr .sort[data-filename]').each(function () {
                            var raw = $(this).data('filename');
                            if (raw === undefined || raw === null || raw === '') {
                                return;
                            }
                            try {
                                // original_filename is stored with PHP's urlencode(), which
                                // encodes spaces as "+" rather than "%20": decode that first.
                                names.push(decodeURIComponent(String(raw).replace(/\+/g, ' ')));
                            } catch (e) {
                                names.push(String(raw));
                            }
                        });
                        return names;
                    };

                    // Shows the conflict box for the given file names and asks the editor,
                    // per file, whether to replace the existing attachment or keep both.
                    // Calls onConfirm(choices) with choices = {filename: true|false} (true = replace)
                    // or onCancel() if the editor cancels the whole batch.
                    var _showConflictBox = function (conflictingNames, onConfirm, onCancel) {
                        $conflictList.empty();

                        $.each(conflictingNames, function (index, name) {
                            var $row = $conflictRowTemplate.length && $conflictRowTemplate[0].content ?
                                $(document.importNode($conflictRowTemplate[0].content, true)).find('.upload-conflict-row') :
                                $($conflictRowTemplate.html());

                            var groupName = 'upload-conflict-choice-' + index;
                            var $replaceInput = $row.find('.upload-conflict-row-replace');
                            var $keepInput = $row.find('.upload-conflict-row-keep');
                            var replaceId = groupName + '-replace';
                            var keepId = groupName + '-keep';

                            $replaceInput.attr({name: groupName, id: replaceId});
                            $replaceInput.closest('.form-check').find('label').attr('for', replaceId);
                            $keepInput.attr({name: groupName, id: keepId});
                            $keepInput.closest('.form-check').find('label').attr('for', keepId);

                            $row.find('.upload-conflict-row-name').text(name);
                            $row.data('filename', name);
                            $conflictList.append($row);
                        });

                        $conflictBox.show();
                        // Bring the box into view and move focus to it: the editor may be
                        // scrolled elsewhere in a long edit form when the upload completes.
                        // Focus targets a dedicated wrapper (not the alert itself) so the
                        // browser's default focus outline never lands on the alert, which
                        // has no matching focus style of its own in this admin theme.
                        var conflictAnchorEl = $conflictAnchor.get(0);
                        if (conflictAnchorEl && conflictAnchorEl.scrollIntoView) {
                            conflictAnchorEl.scrollIntoView({behavior: 'smooth', block: 'center'});
                        }
                        $conflictAnchor.focus();

                        $conflictBox.find('.upload-conflict-box-confirm').off('click').on('click', function () {
                            var choices = {};
                            $conflictList.find('.upload-conflict-row').each(function () {
                                var name = $(this).data('filename');
                                choices[name] = $(this).find('.upload-conflict-row-replace').is(':checked');
                            });
                            $conflictBox.hide();
                            onConfirm(choices);
                        });

                        $conflictBox.find('.upload-conflict-box-cancel').off('click').on('click', function () {
                            $conflictBox.hide();
                            onCancel();
                        });
                    };

                    // blueimp fires the "add" callback once PER FILE, even when several
                    // files are selected together in the OS file picker (verified: a
                    // 2-file selection triggers two separate "add" calls, each with a
                    // single-file data.files). Without queuing, each call would pop its
                    // own conflict box synchronously and immediately replace the previous
                    // one, so the editor would only ever see the last file's box. Instead,
                    // queue every conflicting file found during the same call stack and
                    // flush once (setTimeout 0), showing a single box listing all of them.
                    var pendingConflicts = []; // [{data: <blueimp data>, names: [...]}]
                    var flushTimer = null;

                    var _flushPendingConflicts = function () {
                        flushTimer = null;
                        var toProcess = pendingConflicts;
                        pendingConflicts = [];
                        if (toProcess.length === 0) {
                            return;
                        }

                        var allNames = [];
                        $.each(toProcess, function (i, item) {
                            allNames = allNames.concat(item.names);
                        });

                        _showConflictBox(allNames, function (choices) {
                            $.each(toProcess, function (i, item) {
                                var itemChoices = {};
                                $.each(item.names, function (j, name) {
                                    itemChoices[name] = choices[name];
                                });
                                item.data.formData = function (form) {
                                    return form.serializeArray().concat([{
                                        name: 'OcMultibinaryReplaceChoice',
                                        value: JSON.stringify(itemChoices)
                                    }]);
                                };
                                item.data.submit();
                            });
                        }, function () {
                            // Editor cancelled: none of the queued files are uploaded.
                        });
                    };

                    $element.find('.input-upload').fileupload({
                        dropZone: $element,
                        formData: function (form) {
                            return form.serializeArray();
                        },
                        dataType: 'json',
                        autoUpload: true,
                        add: function (e, data) {
                            // Conflict box markup is only rendered when
                            // NameConflictSettings.EnableUploadConflictCheck is enabled
                            // (ocmultibinary.ini): if absent, keep the historical behaviour.
                            if ($conflictBox.length === 0) {
                                data.submit();
                                return;
                            }

                            var existingNames = _existingFilenames();
                            var conflictingNames = [];
                            $.each(data.files, function (i, file) {
                                if ($.inArray(file.name, existingNames) !== -1) {
                                    conflictingNames.push(file.name);
                                }
                            });

                            if (conflictingNames.length === 0) {
                                data.submit();
                                return;
                            }

                            pendingConflicts.push({data: data, names: conflictingNames});
                            if (flushTimer === null) {
                                flushTimer = setTimeout(_flushPendingConflicts, 0);
                            }
                        },
                        submit: function (e, data) {
                            $buttonContainer.hide();
                            $spinner.show();
                        },
                        done: function (e, data) {
                            if (data.result.errors.length > 0) {
                                var errorContainer = $('<div class="alert alert-danger"></div>');
                                $.each(data.result.errors, function() {
                                    $('<p>' + this+ '</p>').appendTo(errorContainer)
                                });
                                $buttonContainer.html(errorContainer);
                            } else if (typeof data.result.content != 'undefined') {
                                $fileList.html(data.result.content);

                                // Add sort feature to list
                                _sort($fileList.find('.list tbody'));
                            }
                            $buttonContainer.show();
                            $spinner.hide();
                        }
                    });

                });

            }
        };

        if (methods[method]) {
            return methods[method].apply(this, Array.prototype.slice.call(arguments, 1));
        } else if (typeof method === 'object' || !method) {
            return methods.init.apply(this, arguments);
        } else {
            $.error( 'Method "' +  method + '" does not exist in ocmultibinary plugin!');
        }

    };

    $.fn.ocmultibinary.defaults = {};

    $.fn.ocmultibinary.settings = {};

})(jQuery);