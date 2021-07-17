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
$var_room = mysqli_real_escape_string($conn, $_POST['form-room']);


$sql = "SELECT r.room_id as 'Room_Number', b.name as 'Building_Name', rf.feature as 'Room_Feature'
FROM room as r, building as b, room_feature as rf WHERE r.build_id = b.build_id AND r.room_id = rf.room_id AND feature = '$var_room' ORDER BY b.build_id;
";

$result = mysqli_query($conn, $sql);

if (mysqli_num_rows($result) > 0) {
	// output data of each row
	echo "<table border='1'>";
	echo "<tr><th>Room Number</th><th>Building Name</th><th>Room Feature</th></tr>";
	while($row = mysqli_fetch_assoc($result)) {
		 echo "<tr><td>" .$row['Room_Number']. "</td><td>" .$row['Building_Name']. "</td><td>" .$row['Room_Feature']. "</td></tr>";
	} echo "</table>";
} else {
	echo "0 result";
}
//close connection
mysqli_close($conn);
?>
</body>
</html>
