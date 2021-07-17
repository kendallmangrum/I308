<!doctype html>
<html>
	<body>
		<head>
			<style type="text/css">
				body {
					width: 100%;
				}
				table {
					margin: 0 auto;
					font-size: 24px;
				}
			</style>
		</head>
<?php
$servername = "db.sice.indiana.edu";
$username = "i308f19_team01";
$password = "team01";
$dbname = "i308f19_team01";

//Create Connection
$conn = mysqli_connect($servername, $username, $password, $dbname);

//Check connection
if (!conn) {
	die("Connection failed: " . mysqli_connect_error());
}

$sql = "SELECT m.name as Major, d.name as Department, m.hours_to_grad as CreditsToGraduate, m.gpa_to_grad as GPA
FROM major as m, department as d
WHERE m.dept_id = d.dept_id
ORDER BY d.dept_id, m.name";

$result = mysqli_query($conn, $sql);

if (mysqli_num_rows($result) > 0) {
	// output data of each row
	echo "<table border='1'>";
	echo "<tr><th>Major</th><th>Department</th><th>Credits to Graduate</th><th>Required GPA</th></tr>";
	while($row = mysqli_fetch_assoc($result)) {
		 echo "<tr><td>" .$row['Major']. "</td><td>" .$row['Department']. "</td><td>" .$row['CreditsToGraduate']. "</td><td>" .$row['GPA']. "</td></tr>";
	} echo "</table>";
} else {
	echo "0 result";
}
//close connection
mysqli_close($conn);
?>
</body>
</html>
