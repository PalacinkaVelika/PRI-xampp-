<!DOCTYPE html>
<html lang="cs">

<?php $title = 'XML validátor' ?>

<head>
    <title>
        <?= $title ?>
    </title>
</head>

<body>
    <h1>
        <?= $title ?>
    </h1>

    <p>Nahrajte XML soubor, případně také DTD nebo XSD soubor.</p>
    <hr>
    <form enctype="multipart/form-data" method="POST">
        <table>
            <tr>
                <td>XML soubor:</td>
                <td><input type="file" name="xml" accept="text/xml" data-max-file-size="2M"></td>
            </tr>
            <tr>
                <td>DTD/XSD soubor:</td>
                <td><input type="file" name="schema" accept=".dtd,.xsd" data-max-file-size="2M"></td>
            </tr>
            <tr>
                <td></td>
                <td><input type="submit" value="Odeslat"></td>
            </tr>
        </table>
    </form>

    <a href='student.xml'>Student-xml</a>

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
    // XML
    $xml = new DOMDocument;
    $xml->load('student.xml');
    // XSL
    $xsl = new DOMDocument;
    $xsl->load('studenti.xsl');
    // transformer
    $xslt = new XSLTProcessor();
    $xslt->importStylesheet($xsl);
    $transformovany_xml = $xslt->transformToXml($xml);
    // output
    echo $transformovany_xml;
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

