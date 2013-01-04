$(document).ready(function() {
    var popshim = $(".popover");

    popshim.hide();
    popshim.click(function (e) {
        popshim.hide();
    });

    $(".lisp").click(function (e) {
        var node  = $(e.target),
            popo  = $("#popover"),
            input = node.html();

        popo.load(
            '/topy', {
                "code": input
            },
            function (resT, resS, xhr) {
                popshim.show();
            }
        );
    });
})
