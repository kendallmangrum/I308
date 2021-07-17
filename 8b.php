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

$sql = "SELECT CONCAT(s.Fname, ' ', s.Lname) as StudentFullName, CONCAT(s.p_Fname, ' ', s.p_Lname) as ParentFullName, s.p_phone as ParentPhoneNumber
FROM student as s
WHERE s.student_id NOT IN(
SELECT s.student_id
FROM student as s, section_student_grade as ssg, course_section_semester_people_room as csspr, semester as sm
WHERE ssg.student_id = s.student_id AND ssg.section_num = csspr.section_num AND sm.sem_id = csspr.sem_id AND (sm.sem_id = 4 OR sm.sem_id = 3)
GROUP BY s.student_id
)
ORDER BY StudentFullName";

$result = mysqli_query($conn, $sql);

if (mysqli_num_rows($result) > 0) {
	// output data of each row
	echo "<table border='1'>";
	echo "<tr><th>Student Name</th><th>Parent Name</th><th>Parent Phone Number</th></tr>";
	while($row = mysqli_fetch_assoc($result)) {
		 echo "<tr><td>" .$row['StudentFullName']. "</td><td>" .$row['ParentFullName']. "</td><td>" .$row['ParentPhoneNumber']. "</td></tr>";
	} echo "</table>";
} else {
	echo "0 result";
}
//close connection
mysqli_close($conn);
?>
</body>
</html>
