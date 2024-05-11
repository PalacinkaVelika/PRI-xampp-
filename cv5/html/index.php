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
    <h1><?= $title ?></h1>

    <p>Nahrajte XML soubor, případně také DTD nebo XSD soubor.</p>
    <hr>
    <form class="w3-container" enctype="multipart/form-data" method="POST">
        <table class="w3-table">
            <tr>
                <td>XML soubor:</td>
                <td><input class="w3-input" type="file" name="xml" accept="text/xml" data-max-file-size="2M"></td>
            </tr>
            <tr>
                <td>DTD/XSD soubor:</td>
                <td><input class="w3-input" type="file" name="schema" accept=".dtd,.xsd" data-max-file-size="2M"></td>
            </tr>
            <tr>
                <td></td>
                <td><input class="w3-button w3-purple" type="submit" value="Odeslat"></td>
            </tr>
        </table>
    </form>

    <a class="w3-button w3-purple" href="student.xml">Student-xml</a>

    <hr>

    <?php
        $mysqli= new mysqli("localhost", "root", "", "pri_db");
		$mysqli->query("Set names utf8");
		if ($mysqli->connect_error) {
			echo $mysqli->connect_error;
			return;
		}

    ?>

    
    <?php

    $xml = simplexml_load_file('xml/student.xml');
   // print_r($xml);

    function traverseSimpleXML($xml, $level=0) {
        $space = function($level) { return str_repeat(' ', $level * 2); };
    
        $attributes = $xml->attributes();
    
        foreach ($attributes as $name => $value) {
            echo $space($level) . "$name - " . (string)$value . "<br>";
        }
    
        $children = $xml->children();
        foreach ($children as $name => $value) {
            if(count($value) > 0) {
                echo $space($level) . "$name: <br>";
                traverseSimpleXML($value, $level+1);
            } else {
                echo $space($level) . "$name = " . (string)$value . "<br>";
            }
        }
    }

    traverseSimpleXML($xml);

    ?>
<br><br>
    <?php
    /*
    $xml = new SimpleXMLElement('<fakulta/>');
    $xml->addAttribute('děkan', 'Jméno Děkana');

    $katedra = $xml->addChild('katedra');
    $katedra->addAttribute('zkratka_katedry', 'PRF-KAT');
    $katedra->addAttribute('webové_stránky', 'https://www.ujep.cz/prf-kat');

    $zamestnanci = $katedra->addChild('zaměstnanci');
    $zamestnanec1 = $zamestnanci->addChild('zaměstnanec');
    $zamestnanec1->addChild('jméno', 'Škvor Škvorus');
    $zamestnanec1->addChild('telefon', '779465123');
    $zamestnanec1->addChild('email', 'jskvor@prf.ujep.cz');
    $pozice1 = $zamestnanec1->addChild('pozice');
    $pozice1->addChild('vedoucí');

    $predmety = $katedra->addChild('předměty');
    $predmet1 = $predmety->addChild('předmět');
    $predmet1->addAttribute('zkratka', 'PRF101');
    $predmet1->addAttribute('typ', 'přednáška');
    $predmet1->addChild('název', 'APR1');
    $predmet1->addChild('popis', 'programko');


    echo $xml->asXML();
    */

    $query = "SELECT * FROM fakulty";
    $result = $mysqli->query($query);   
    if (!$result) {
        echo $mysqli->error;
        return;
    }

    $xml = new SimpleXMLElement('<fakulty/>');
    while ($row = $result->fetch_assoc()) {
        $fakulta = $xml->addChild('fakulta');
        $fakulta->addAttribute('jmeno_katedry', $row['jmeno']);

        $zamestnanci = $fakulta->addChild('zaměstnanci');

        $query2 = "SELECT * FROM zamestnanci WHERE id_fakulta = " . $row['id'];
        $result2 = $mysqli->query($query2);
        if (!$result2) {
            echo $mysqli->error;
            return;
        }

        while ($row2 = $result2->fetch_assoc()) {
            $zamestnanec = $zamestnanci->addChild('zaměstnanec');
            $query4 = "SELECT * FROM osobni_udaje WHERE id = " . $row2['osobni_udaje'];
            $result4 = $mysqli->query($query4);
            if (!$result4) {
                echo $mysqli->error;
                return;
            }
            while ($row4 = $result4->fetch_assoc()) {
                $zamestnanec->addChild('jméno', $row4['jmeno']);
                $zamestnanec->addChild('příjmení', $row4['prijmeni']);
                $zamestnanec->addChild('číslo', $row4['cislo']);
            }
            $query5 = "SELECT * FROM pozice WHERE id = " . $row2['id_pozice'];
            $result5 = $mysqli->query($query5);
            if (!$result5) {
                echo $mysqli->error;
                return;
            }
            while ($row5 = $result5->fetch_assoc()) {
                $zamestnanec->addChild('pozice', $row5['jmeno']);
            }
        }

    }

    echo $xml->asXML();
    ?>


    <?php
    function printErrors()
    { ?>
        <table>
            <?php foreach (libxml_get_errors() as $error) { ?>
                <tr>
                    <td>
                        <?= $error->line ?>
                    </td>
                    <td>
                        <?= $error->message ?>
                    </td>
                </tr>
            <?php } ?>
        </table>
        <?php
    }

    function validate($xmlPath, $schemaPath = '')
    {
        $doc = new DOMDocument;

        // proběhne kontrola well-formed
        libxml_use_internal_errors(true);
        $doc->loadXML(file_get_contents($xmlPath));
        printErrors();
        libxml_use_internal_errors(false);

        // Máme root a DTD/XSD?
        @$root = $doc->firstElementChild->tagName;
        if ($root && $schemaPath) {
            $root = $doc->firstElementChild->tagName;
            $systemId = 'data://text/plain;base64,' . base64_encode(file_get_contents($schemaPath));

            echo "<p>Validuji podle DTD/XSD. Kořen: <b>$root</b></p>";

            // použití XSD schématu pro validaci
            $doc->schemaValidate($systemId);
        } else {
            // validace bez DTD/XSD
            echo "<p>Validuji pouze well-formed XML.</p>";
            $isValid = $doc->validate();
        }

        printErrors();

        return $isValid;
    }

    // poslané soubory
    $xmlFile = @$_FILES['xml'];
    $schemaFile = @$_FILES['schema'];

    // Máme XML?
    if (@$xmlTmpName = $xmlFile['tmp_name']) {
        $schemaTmpName = $schemaFile['tmp_name'];
        $isValid = validate($xmlTmpName, $schemaTmpName);
        if ($isValid)
            echo "Nahraný XML soubor je validní.";
    }
    ?>

</body>

</html>

