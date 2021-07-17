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

$sql = "SELECT CONCAT(s.Fname, ' ', s.Lname) as StudentName, AVG(g.gpaValue) as GPA, CONCAT(p.Fname, ' ', p.Lname) as AdvisorName, pex.area_expert as AdvisorExpertise, pe.email_address as Email
FROM student as s, grade as g, section_student_grade as ssg, people as p, people_expertise as pex, people_email as pe
WHERE s.student_id = ssg.student_id AND ssg.grade = g.gLetter AND s.advisor_id = p.emp_id AND p.emp_id = pex.emp_id AND pe.emp_id = p.emp_id AND pe.type = 'work'
GROUP BY s.student_id
HAVING(GPA < 2.75)
ORDER BY p.emp_id";

$result = mysqli_query($conn, $sql);

if (mysqli_num_rows($result) > 0) {
	// output data of each row
	echo "<table border='1'>";
	echo "<tr><th>Student Name</th><th>GPA</th><th>Advisor Name</th><th>Advisor Expertise</th><th>Email</th></tr>";
	while($row = mysqli_fetch_assoc($result)) {
		 echo "<tr><td>" .$row['StudentName']. "</td><td>" .$row['GPA']. "</td><td>" .$row['AdvisorName']. "</td><td>" .$row['AdvisorExpertise']. "</td><td>" .$row['Email']. "</td></tr>";
	} echo "</table>";
} else {
	echo "0 result";
}
//close connection
mysqli_close($conn);
?>
</body>
</html>
