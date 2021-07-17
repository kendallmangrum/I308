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

$sql = "SELECT CONCAT(p.Fname, ' ', p.Lname) as ProfessorFullName, c.course_num as Course, COUNT(course_num) as TimesTaught FROM course as c, people as p, course_section_semester_people_room as csspr WHERE p.emp_id = csspr.emp_id AND csspr.course_id = c.course_id GROUP BY p.emp_id, c.course_num";

$result = mysqli_query($conn, $sql);

if (mysqli_num_rows($result) > 0) {
	// output data of each row
	echo "<table border='1'>";
	echo "<tr><th>Professor Name</th><th>Course</th><th>Times Taught</th></tr>";
	while($row = mysqli_fetch_assoc($result)) {
		 echo "<tr><td>" .$row['ProfessorFullName']. "</td><td>" .$row['Course']. "</td><td>" .$row['TimesTaught']. "</td></tr>";
	} echo "</table>";
} else {
	echo "0 result";
}
//close connection
mysqli_close($conn);
?>
</body>
</html>
