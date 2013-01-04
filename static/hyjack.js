$(document).ready(function() {

    $(".lisp").each(function (i) {
        var node = $(this),
            input = node.html();
        node.load('/format/lisp', {
            "code": input
        });
    });

    $(".python").each(function (i) {
        var node = $(this),
            input = node.html();
        node.load('/format/python', {
            "code": input
        });
    });
})
