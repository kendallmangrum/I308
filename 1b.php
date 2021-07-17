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
$var_sectionb = mysqli_real_escape_string($conn, $_POST['form-sectionb']);


$sql = "(SELECT CONCAT(s.Fname, ' ', s.Lname) as StudentNames, ssg.grade as GradeReceived, g.gpaValue as gpaEarned
FROM student as s, section_student_grade as sx, section_student_grade as ssg, grade as g
WHERE sx.student_id = s.student_id AND sx.section_num = ssg.section_num AND ssg.grade = g.gLetter AND s.student_id = ssg.student_id AND sx.section_num = '$var_sectionb'
ORDER BY s.Lname, s.Fname)
UNION
(SELECT '' as StudentNames, '' as GradeReceived, CONCAT('Average GPA: ', AVG(g.gpaValue)) as gpaEarned
FROM student as s, section_student_grade as sx, section_student_grade as ssg, grade as g
WHERE sx.student_id = s.student_id AND sx.section_num = ssg.section_num AND ssg.grade = g.gLetter AND s.student_id = ssg.student_id AND sx.section_num = '$var_sectionb'
)";

$result = mysqli_query($conn, $sql);

if (mysqli_num_rows($result) > 0) {
	// output data of each row
	echo "<table border='1'>";
	echo "<tr><th>Student Name</th><th>Grade Received</th><th>GPA Earned</th></tr>";
	while($row = mysqli_fetch_assoc($result)) {
		 echo "<tr><td>" .$row['StudentNames']. "</td><td>" .$row['GradeReceived']. "</td><td>" .$row['gpaEarned']. "</td></tr>";
	} echo "</table>";
} else {
	echo "0 result";
}
//close connection
mysqli_close($conn);
?>
</body>
</html>
