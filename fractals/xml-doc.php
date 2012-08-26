<?php

$template = isset($_REQUEST['tmpl']) ? $_REQUEST['tmpl'] : 'chaos-game-2';

$doc = '<?xml version="1.0" encoding="UTF-8"?>';
$doc .= '<?xml-stylesheet type="text/xml" href="' . $template . '-template.xsl"?>';

$doc_fmt = '<rand count="%d">%s</rand>';

$count = 19500;

$rnd = '';

for($i = 0; $i < $count; $i++)
{
	$rnd .= sprintf('%0.2f ', rand(0, $count) / $count);
}

$doc .= sprintf($doc_fmt, $count, $rnd);

header('Content-type: application/xml');
echo $doc;
