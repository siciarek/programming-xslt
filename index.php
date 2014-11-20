<?php

$directory = __DIR__ . DIRECTORY_SEPARATOR . 'fractals';

$dir = dir($directory);

$protocol = 'http';

$urls = [];

while($file = $dir->read()) {
    if(!preg_match('/\.xml$/', $file)) {
        continue;
    }

    $url = sprintf('%s://%s/%s/%s', $protocol, $_SERVER['HTTP_HOST'], 'fractals', $file);

    $urls[] = $url;
}

foreach($urls as $u) {
    printf('<a target="_blank" href="%s">%s</a><br/>', $u, $u);
}
