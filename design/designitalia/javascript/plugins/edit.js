var select_to_string = function(element) {
    var newValue = $(element).val();
    var $input = $(element).next();
    if (newValue.length > 0) {
        var current = $input.val().length > 0 ? $input.val().split(',') : [];
        current.push(newValue);
        function unique(array){
            return array.filter(function(el, index, arr) {
                return index == arr.indexOf(el);
            });
        }
        $input.val(unique(current).join(','));
    }else{
        $input.val('');
    }
};
