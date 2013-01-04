$(document).ready(function() {

    $(".lisp").each(function (i) {
        var node = $(this),
            input = node.html();

        console.log(input);

        node.load('/format/lisp', {
            "code": input
        });
    });
})
