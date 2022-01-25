$(document).ready(function () {
    $('#profile').click(function () {
        var clicks = $(this).data('clicks');
        if (clicks) {
            $(this).animate({opacity: 0.3}, 200);
            $('#profile_list').show(400);
         } else {
            $(this).animate({opacity: 1}, 200);
            $('#profile_list').hide(400);
         }
         $(this).data("clicks", !clicks);
    })
})