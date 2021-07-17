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

// Grab post data
$var_advisor = mysqli_real_escape_string($conn, $_POST['form-advisor']);


$sql = "SELECT CONCAT(s.Fname, ' ', s.Lname) as StudentFullName, m.name as Major
FROM student as s, major as m, student_major as sm, people as p
WHERE s.student_id = sm.student_id AND m.major_id = sm.major_id AND p.emp_id = s.advisor_id AND p.emp_id = '$var_advisor' ORDER BY Major, StudentFullName";

$result = mysqli_query($conn, $sql);

if (mysqli_num_rows($result) > 0) {
	// output data of each row
	echo "<table border='1'>";
	echo "<tr><th>Student Name</th><th>Major</th></tr>";
	while($row = mysqli_fetch_assoc($result)) {
		 echo "<tr><td>" .$row['StudentFullName']. "</td><td>" .$row['Major']. "</td></tr>";
	} echo "</table>";
} else {
	echo "0 result";
}
//close connection
mysqli_close($conn);
?>
</body>
</html>
