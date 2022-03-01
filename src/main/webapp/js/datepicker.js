$(document).ready(function(){
    
    $datepicker = $('.datepicker');

    $datepicker.flatpickr({
        "locale" : "ko",
        dateFormat: "Y-m-d",
        minDate: "today",
        disableMobile: "true"
        // onChange: function(date) {
        //     console.log(date);
        // }
    });

    if($datepicker.data('mode') === 'range') $datepicker.mode = "range";

});