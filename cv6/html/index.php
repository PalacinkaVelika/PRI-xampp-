<!DOCTYPE html>
<html lang="cs">

<?php $title = 'XML validátor' ?>

<head>
    <title>
        <?= $title ?>
    </title>
    <link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
</head>

<body style="background-color: black; font-size: 15px; color: white">
<?php
$xml = new DOMDocument();
$xml->load('xml/studium.xml');
$xsl = new DOMDocument();
$xsl->load('xml/studium-1.xsl');
$proc = new XSLTProcessor();
$proc->importStyleSheet($xsl);
$html = $proc->transformToXML($xml);
echo $html;
?>
<hr>
<?php
$xml = new DOMDocument();
$xml->load('xml/studium.xml');
$xsl = new DOMDocument();
$xsl->load('xml/studium-2.xsl');
$proc = new XSLTProcessor();
$proc->importStyleSheet($xsl);
$html = $proc->transformToXML($xml);
echo $html;
?>
<hr>
<?php
$xml = new DOMDocument();
$xml->load('xml/studium.xml');
$xsl = new DOMDocument();
$xsl->load('xml/studium-3.xsl');
$proc = new XSLTProcessor();
$proc->importStyleSheet($xsl);
$html = $proc->transformToXML($xml);
echo $html;
?>
</body>

</html>

