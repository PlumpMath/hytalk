function fmt_code(cls, typ) {
    $(cls).each(function (i) {
        var node = $(this),
            input = node.html();
        node.load('/format/' + typ, {
            "code": input
        });
    });
}


function reload(input, output) {
    var input = input.val();
    output.load(
        '/hy2pycol',
        {"code": input}
    );
}


function reload(node) {
    var input = node.children(".repl-input"),
        output = node.children(".repl-output");

    var input = input.val();
    output.load(
        '/hy2pycol',
        {"code": input}
    );
}


function create_repl() {
    $(".repl").each(function (i) {
        var node = $(this),
            count = 0,
            pval = node.html(),
            tara;

        node.html("");
        node.append("<textarea class = 'repl-input repl-pane repl-left' >" +
            pval + "</textarea>");
        node.append("<div class = 'repl-output repl-pane repl-right'></div>");

        tara = node.children(".repl-input");

        // tara.keypress(function(e) {
        //     console.log(e);
        //     tara.append(e.keyCode);
        //     return false;
        // });

        node.keyup(function(e) {
            var curcount;
            count = count + 1;
            curcount = count;

            window.setTimeout(
                function() {
                    if ( curcount == count ) {
                        reload(node);
                    } else {
                        /* Pass. User is still typing */
                    }
                },
                500
            );
            return false;
        });
        reload(node);
    });
}


$(document).ready(function() {
    fmt_code(".lisp", "lisp");
    fmt_code(".python", "python");
    create_repl();
});
