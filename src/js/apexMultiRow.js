var readOnly,
    apexItem,
    defaults = {
    clearInputs: 1,
    separator: ':',
    inputSeparator: '||',
    onElementAdd: null,
    onElementRemove: null

};

function Plugin(el,custom) {

this.options = defaults;
this.custom = custom;

readOnly = custom.readOnly;
apexItem = $(el);

this.element =  $(el);
this.elementId = this.element.attr('id'); 
this.elementInput = $('<input>').attr({
    name: this.elementId + 'Input',
    id: this.elementId + 'Input',
    type: 'text',
    class: custom.itemCss,
    placeholder: custom.itemPlaceholder,
    size: custom.itemSize,
    maxlength: custom.itemMaxLength
});

    this.addLink = $('<a>').addClass('add').css('cursor', 'pointer').html('<i  style="top: -4px;" class="fa fa-lg '+custom.addItemIcon+'"></i><span > </span>');
    this.removeLink = $('<a></i>').addClass('remove').css('cursor', 'pointer').html('<i style="top: -4px;left: -9px;" class="fa fa-lg '+custom.removeItemIcon+'"></i><span ></span>');

this.elementInputs = null;
this.elementCount = 0;
this.escSeparator = this.options.separator.replace(/[\-\[\]\/{}()*+?.\\^$|]/g, '\\$&');
this.escInputSeparator = this.options.inputSeparator.replace(/[\-\[\]\/{}()*+?.\\^$|]/g, '\\$&');
this.trimEx = new RegExp('^(' + this.escSeparator + ')+|(' + this.escSeparator + ')+$', 'gm');
this.trimExInput = new RegExp('^(' + this.escInputSeparator + ')+|(' + this.escInputSeparator + ')+$', 'gm');

this.init();
}

Plugin.prototype = {
/*
 * Initialize apexMultiRow plugin
 */
init: function () {
    var _this = this;
    if (_this.element.length) {
        _this.elementInputs = _this.fillElementsValues(_this.element);
        _this.element.hide().before(_this.elementInputs);
    }
    return this;
},
/**
 * Clear all inputs of an element
 */
clearInputs: function (el) {
    var _this = this;
    $(':input', el).each(function () {
       $(this).val('');
    });
    _this.saveElementsValues();
},
/**
 * Create one element
 */
createElement: function (el, suffix, data) {
    var _this = this;
    var clone = el.clone(false);
    var cloneWrap = $('<div>').addClass('inputWrapper').hide().append(clone);
    $('[id]', cloneWrap).each(function () {
        $(this).attr('id', $(this).attr('id') + (suffix));
    });
        $('[id]', cloneWrap).each(function () {
            $(this).attr('id', $(this).attr('name') + (suffix));
        });
    $('.number', clone).text(suffix + 1);

    _this.clearInputs(cloneWrap);
        var values = data.split(_this.options.inputSeparator);

    var inputs = $(':input', cloneWrap);
        if (values.length) {
            for (var k = 0; k < values.length; k++) {
                $(inputs[k]).val(values[k]);
            }
        }
    if (!readOnly){ 
    var add = _this.addLink.clone(false).click(function (e) {
        e.preventDefault();
        if (_this.elementCount < _this.custom.limit) {
            var clone = _this.createElement(_this.elementInput, _this.elementCount, '');
            var number = $(this).parents('.inputWrapper').index();
            $('.number', clone).text(number + 2);
            $(this).parents('.inputWrapper').after(clone);
            $(this).parents('.inputWrapper').nextAll('.inputWrapper').each(function (index) {
                $(this).find('.number').text(number + index + 2);
            });

            clone.show(0, function () {
                $(this).removeAttr('style');
            });
            _this.elementCount++;
            _this.addElementEvents(clone);
            _this.saveElementsValues();
            apex.jQuery(apexItem).trigger("change");
        } else {
            apex.message.clearErrors();
            apex.message.showErrors([{type:"error",
                                      location:   "page",
                                      message:    _this.custom.limitMessage,
                                       unsafe:     false
                                      }
                                     ]);

        }
    });  
    var remove = _this.removeLink.clone(false).click(function (e) {
        e.preventDefault();
        if ($('.inputWrapper', _this.elementInputs).length > 1) {
            var number = $(this).parents('.inputWrapper').index();
            $(this).parents('.inputWrapper').nextAll('.inputWrapper').each(function (index) {
                $(this).find('.number').text(number + index + 1);
            });
            $(this).parents('.inputWrapper').hide(0, function () {
                $(this).remove();
                _this.saveElementsValues();
                _this.elementCount--;
            });
            apex.jQuery(apexItem).trigger("change");
        } else {
            _this.clearInputs($(this).parent());
        }
        if (typeof _this.options.onElementRemove === 'function') {
            _this.options.onElementRemove(el, _this);
        }
    });
    }
    cloneWrap.append(add).append(remove);
    return cloneWrap;
},
/*
  Fill elements with values
 */
fillElementsValues: function (el) {
    var _this = this,
        id = el.attr('id'),
        values;
        values = el.html().replace(/[\s\r\n]+$/, '').split(_this.options.separator);
    var required = (el.hasClass('required')) ? 'required' : '',
        inputs = $('<div>').attr('id', id + 'Inputs').addClass('apexMultiRow'),
        input;
    if (values.length) {
        for (var k = 0; k < values.length; k++) {
            input = _this.createElement(_this.elementInput, k, values[k]).addClass(id + 'Input').addClass(required).show();
            inputs.append(input);
            _this.elementCount++;
            _this.addElementEvents(input);
        }
    } else {
        input = _this.createElement(_this.elementInput, 0, '').addClass(id + 'Input').show();
        inputs.append(input);
        _this.elementCount++;
        _this.addElementEvents(input);
    }
    return (inputs);
},
/*
  Add events to an element
 */
addElementEvents: function (el) {
    var _this = this;
    $('[id]', el).bind('change keyup mouseup', function () {
        _this.saveElementsValues();
        return false;
    });
    if (typeof _this.options.onElementAdd === 'function') {
        _this.options.onElementAdd(el, _this);
    }
},
/**
 * Save elements values
 */
saveElementsValues: function () {
    var _this = this;
    if (_this.elementInputs) {
        var elements = _this.elementInputs.children('.inputWrapper');
        var data = [];
        elements.each(function () {
            var inputs = $(':input', $(this));
            var values = [];
            $.each(inputs, function () {
                var name = $(this).attr('name');

                    values.push($(this).val());
                    

            });
                values = values.join(_this.options.inputSeparator);
                data.push(values);
        });
            var value = data.join(_this.options.separator);
            _this.element.text(value);
            _this.element.val(value);

    }
}
};

/*
 * Call apexMultiRow plugin
 */

$.fn['apexMultiRow'] = function (custom) {
    
    return this.each(function () {
        if (!$.data(this, 'plugin_apexMultiRow')) {
            $.data(this, 'plugin_apexMultiRow', new Plugin(this,custom));
        }
    });
};
