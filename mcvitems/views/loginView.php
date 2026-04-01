<!-- Incluimos la cabecera -->
<?php include_once("common/cabecera.php"); ?>

<!-- Vista para hacer login en la aplicación -->

<body>
	<!-- Incluimos un menú para la aplicación -->
	<?php include_once("common/menu.php"); ?>

	<!-- Parte específica de nuestra vista -->
	<!-- Formulario para insertar un nuevo item -->
	<form action="index.php" method="post">
		<input type="hidden" name="controlador" value="App">
		<input type="hidden" name="accion" value="login">

		<?php echo isset($errores["login"]) ? "*" : "" ?>
		<label for="login">Login</label>
		<input type="text" name="login">
		</br>
		<label for="password">Password</label>
		<input type="password" name="password">
		</br>

		<input type="submit" name="submit" value="Entrar">
	</form>
	</br>

	<?php
	// Si hay errores se muestran
	if (isset($errores)):
		foreach ($errores as $key => $error):
			echo $error . "</br>";
		endforeach;
	endif;
	?>

	<!-- Incluimos el pie de la página -->
	<?php include_once("common/pie.php"); ?>
</body>

</html>