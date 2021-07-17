<!DOCTYPE html>
<html>
	<body>
		<h1>Team01 Final Project</h1>

		<h3>1a - Section Roster</h3>
		<form action="1a.php" method="post">
			Section: <select name="form-section" required>
				<?php
				$conn = mysqli_connect("db.soic.indiana.edu","i308f19_team01","team01","i308f19_team01");
				// Check connection
				if (!$conn) {
				    die("Connection failed: " . mysqli_connect_error() . "<br>");
				}
				    $result = mysqli_query($conn,"SELECT distinct section_num FROM section ORDER BY Lname, Fname");
				    while ($row = mysqli_fetch_assoc($result)) {
				                  unset($id, $name);
				                  $id = $row['section_num'];
				                  $name = $row['section_num'];
				                  echo '<option value="'.$id.'">'.$name.'</option>';
				}
				?>
				    </select>
			<br><br>
			<input type="submit">
		</form>
	</body>
</html>
