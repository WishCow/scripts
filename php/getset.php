<?php


$props = array();
$getset = array();
while (!feof(STDIN)) {
    $line = fgets(STDIN);
    if (preg_match('%^\s*(private|protected|public) \$(.*?)(;| )%i', $line, $matches)) {
        $var = $matches[2];
        $props[] = rtrim($line);
        $getset[] = 'public function set' . ucfirst($var) . "(\$$var) {\n\$this->$var = \$$var;\n}\n";
        $getset[] = 'public function get' . ucfirst($var) . "() {\nreturn \$this->$var;\n}\n";
    }
}

$props[] = "";
echo implode("\n", array_merge($props, $getset));
