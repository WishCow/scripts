<?php

$first = array(
    '&amp;gt;' => '>',
    '&amp;lt;' => '<',
    '&lt;' => '<',
    '&gt;' => '>',
    '&amp;' => '&',
    '&amp;amp;' => '&',
    '&quot;' => '"',
);

$second = array(
    '<br />' => "\n",
);

while ($line = fgets(STDIN)) {
    $str = strtr($line, $first);
    $str = strtr($str, $second);

    echo $str;
}
