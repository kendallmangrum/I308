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
$var_courseb = mysqli_real_escape_string($conn, $_POST['form-courseb']);

$sql = "SELECT CONCAT(p.Fname, ' ', p.Lname) as EmployeeFullName, p.phone as PhoneNumber, pe.email_address as Email, p.rank as EmployeePosition
FROM people as p, people_email as pe
WHERE p.emp_id = pe.emp_id AND pe.type = 'work' AND p.rank != 'Advisor' AND p.emp_id NOT IN(
SELECT p.emp_id
FROM people as p, course_section_semester_people_room as csspr, course as c
WHERE c.course_id = csspr.course_id AND p.emp_id = csspr.emp_id AND c.course_id = '$var_courseb'
ORDER BY p.emp_id
)
ORDER BY EmployeeFullName";

$result = mysqli_query($conn, $sql);

if (mysqli_num_rows($result) > 0) {
	// output data of each row
	echo "<table border='1'>";
	echo "<tr><th>Employee Name</th><th>Phone Number</th><th>Email</th><th>Employee Position</th></tr>";
	while($row = mysqli_fetch_assoc($result)) {
		 echo "<tr><td>" .$row['EmployeeFullName']. "</td><td>" .$row['PhoneNumber']. "</td><td>" .$row['Email']. "</td><td>" .$row['EmployeePosition']."</tr>";
	} echo "</table>";
} else {
	echo "0 result";
}
//close connection
mysqli_close($conn);
?>
</body>
</html>
