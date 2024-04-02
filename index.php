<!DOCTYPE html>
<html lang="cs">

<?php $title = 'PRI-XML srandy' ?>

<head>
    <title><?= $title ?></title>
</head>

<body>
    <h1><?= $title ?></h1>

    <?php
        // DB
        $mysqli= new mysqli("localhost", "root", "", "pri_db");
        $mysqli->query("Set names utf8");
        if ($mysqli->connect_error) {
            echo $mysqli->connect_error;
            return;
        }

        /* SimpleXML */
/*
        // Získání všeho z xml
        $xml = simplexml_load_file('xml/studenti.xml');

        function traverseSimpleXML($xml, $level=0) {
            $space = function($level) {
                return str_repeat(' ', $level * 2);
            };
        
            $attributes = $xml->attributes();
        
            foreach ($attributes as $name => $value) {
                echo $space($level) . "$name - " . (string)$value . "<br>";
            }
        
            $children = $xml->children();
            foreach ($children as $name => $value) {
                if(0 < $value->count()) {
                    echo $space($level) . "$name: <br>";
                    traverseSimpleXML($value, $level+1);
                } else {
                    echo $space($level) . "$name = " . (string)$value . "<br>";
                }
            }
        }

        traverseSimpleXML($xml);
        
        // Získání něčeho ze souboru    
        $xml = simplexml_load_file('xml/studenti.xml');
        echo (string)($xml->student[0]->note->Fname);
*/


        // TVORBA z DB 
        $xml = new SimpleXMLElement('<?xml-stylesheet type="text/xsl" href="xml/studenti.xsl"?><student/>');
      
        $sql= "SELECT * FROM student";
		$result = $mysqli->query($sql);
		while($row = $result->fetch_assoc()){
            $studenti = $xml->addChild('student');
            $studenti->addChild('jmeno',$row["Fname"]);
            $studenti->addChild('primeni',$row["Lname"]);
            $studenti->addChild('katedra',$row["katedra"]);
            $studenti->addChild('rocnik',$row["studyYear"]);
        }
        
        header('Content-Type: application/xml');
        echo $xml->asXML();
    
    
    
    ?>


</body>

</html>
