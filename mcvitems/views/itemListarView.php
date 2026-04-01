<!-- Incluimos la autentificación -->
<?php include_once("common/autentificacion.php"); ?>

<!-- Incluimos la cabecera -->
<?php include_once("common/cabecera.php"); ?>
<body>
    <!-- Incluimos el menú --> 
    <?php include_once("common/menu.php"); ?>

    <table>
        <tr>
            <th>Codigo</th>
            <th>Nombre</th>
        </tr>
        <?php
        foreach ($items as $item) {
            ?>
            <tr>
                <td>
                    <?php echo $item->getCodigo() ?>
                </td>
                <td>
                    <?php echo $item->getNombre() ?>
                </td>
                <td>
                    <a href="index.php?controlador=Item&accion=editar&codigo=<?php echo $item->getCodigo() ?>">Editar</a>
                </td>
                <td>
                    <a href="index.php?controlador=Item&accion=borrar&codigo=<?php echo $item->getCodigo() ?>">Borrar</a>
                </td>
            </tr>
            <?php
        }
        ?>
    </table>
    <a href="index.php?controlador=Item&accion=nuevo">Nuevo</a>

    <!-- Incluimos el pie de página -->
    <?php include_once("common/pie.php"); ?>
</body>

</html>