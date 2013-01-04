function fmt_code(cls, typ) {
    $(cls).each(function (i) {
        var node = $(this),
            input = node.html();

        node.load('/format/' + typ, {
            "code": input
        });
    });
}


$(document).ready(function() {
    fmt_code(".lisp", "lisp");
    fmt_code(".python", "python");
})
