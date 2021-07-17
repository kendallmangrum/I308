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
$var_course = mysqli_real_escape_string($conn, $_POST['form-course']);


$sql = "SELECT CONCAT(s.Fname, ' ', s.Lname) as StudentFullName FROM student as s, section as sx, section_student_grade as ssg WHERE s.student_id = ssg.student_id AND ssg.section_num = sx.section_num AND sx.course_id IN( SELECT cp.Prerequisite_id FROM course_prerequisite as cp WHERE cp.course_id = '$var_course') GROUP BY StudentFullName";

$result = mysqli_query($conn, $sql);

if (mysqli_num_rows($result) > 0) {
	// output data of each row
	echo "<table border='1'>";
	echo "<tr><th>Student Name</th></tr>";
	while($row = mysqli_fetch_assoc($result)) {
		 echo "<tr><td>" .$row['StudentFullName']. "</td></tr>";
	} echo "</table>";
} else {
	echo "0 result";
}
//close connection
mysqli_close($conn);
?>
</body>
</html>
