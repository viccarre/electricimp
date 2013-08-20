page <- @"
    <!DOCTYPE html>
    <html>
        <head>
            <title>%s</title>
            %s
        </head>
        <body>%s</body>
    </html>
";

head <- @"
    <script src = 'https://code.jquery.com/jquery-1.10.1.min.js'></script>
    <script src = 'https://code.jquery.com/jquery-migrate-1.2.1.min.js'></script>
    <script src = 'https://netdna.bootstrapcdn.com/twitter-bootstrap/2.3.2/js/bootstrap.min.js'></script>
    <link href = 'https://netdna.bootstrapcdn.com/twitter-bootstrap/2.3.2/css/bootstrap-combined.min.css' rel='stylesheet'>

    <meta name='viewport' content='width=device-width, initial-scale=1.0'>
    <style>.center { margin-left: auto; margin-right: auto; margin-bottom: auto; margin-top: auto; }</style>
";

index <- @"
	<script>
	        function logSuccess(title, message) {
            $('.container').prepend('<div class=\'alert alert-success\'><button type=\'button\' class=\'close\' data-dismiss=\'alert\'>x</button><strong>' + title + '</strong>' + message + '</div>');
        }

        function logError(title, message) {
            $('.container').prepend('<div class=\'alert alert-error\'><button type=\'button\' class=\'close\' data-dismiss=\'alert\'>x</button><strong>' + title + '</strong>' + message + '</div>');
        }

	</script>
    <div class='container'>
        <h1 class='text-center'>Hello World</h1>
        <div class='content center'>
        </div>
    </div>
";


function renderPage(body, title) {
    return format(page, title, head, body);
}

http.onrequest(function(req, resp) {
    try {
        resp.send(200, renderPage(index, "Hello world"));
    } catch (ex) {
        resp.send(500, "Internal Server Error: " + ex);
    }
});