<?php

$out = array();
$params = array();
while (!feof(STDIN)) {
    $line = fgets(STDIN);
    if (preg_match('%^\s*(private|protected|public) \$(.*?)(;| )%i', $line, $matches)) {
        $props[] = rtrim($line);
        $params[] = $matches[2];
    }
}

$out[] = sprintf("public function __construct(%s) {", implode(', ', array_map(function($e) {
    return '$' . $e;
}, $params)));
foreach ($params as $p) {
    $out[] = sprintf('$this->%s = $%s;', $p, $p);
}
$out[] = '}';

$props[] = "";
echo implode("\n", array_merge($props, $out));
