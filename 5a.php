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
$var_student = mysqli_real_escape_string($conn, $_POST['form-student']);


$sql = "SELECT CONCAT(s.Fname, ' ', s.Lname) as StudentName, c.course_num as CourseName, ssg.grade as GradeReceived, sm.start_date as ClassStartDate
FROM student as s, course as c, section as sx, grade as g, course_section_semester_people_room as csspr, section_student_grade as ssg, semester as sm
WHERE csspr.course_id = c.course_id AND csspr.section_num = sx.section_num AND sm.sem_id = csspr.sem_id AND c.course_id = sx.course_id AND sx.section_num = ssg.section_num AND g.gLetter = ssg.grade AND ssg.student_id = s.student_id AND s.student_id = '$var_student'
ORDER BY sm.start_date";

$result = mysqli_query($conn, $sql);

if (mysqli_num_rows($result) > 0) {
	// output data of each row
	echo "<table border='1'>";
	echo "<tr><th>Student Name</th><th>Course Name</th><th>Grade Receieved</th><th>Class Start Date</th></tr>";
	while($row = mysqli_fetch_assoc($result)) {
		 echo "<tr><td>" .$row['StudentName']. "</td><td>" .$row['CourseName']. "</td><td>" .$row['GradeReceived']. "</td><td>" .$row['ClassStartDate']."</tr>";
	} echo "</table>";
} else {
	echo "0 result";
}
//close connection
mysqli_close($conn);
?>
</body>
</html>
