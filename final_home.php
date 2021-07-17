<!doctype html>
<html>
<body>
    <head>
        <style type="text/css">
            body {
                text-align: center;
                margin-left: 20%;
                margin-right: 20%;
            }
        </style>
    </head>

<h1>I308 Final Project</h1>
<h3>Team01 - Kendall Mangrum, Matthew Murphy, Alec Tourner, Zac Zamiara</h3>

<hr>

<h3>1a - Roster for Specific Section</h3>
<p>Sections 27, 30, 34, 41, 43, and 46 are empty, so they will return 0 results</p>
<form action="1a.php" method="POST">
Section: <select name='form-section' required><?php
$conn = mysqli_connect("db.soic.indiana.edu","i308f19_team01","team01","i308f19_team01");
// Check connection
if (!$conn) {
    die("Connection failed: " . mysqli_connect_error() . "<br>");
}
    $result = mysqli_query($conn,"SELECT DISTINCT CONCAT(csspr.section_num,' - ', c.course_num) as SectionCourse, csspr.section_num FROM course_section_semester_people_room as csspr, course as c WHERE csspr.course_id = c.course_id ORDER BY csspr.section_num");
    while ($row = mysqli_fetch_assoc($result)) {
                  unset($id, $name);
                  $id = $row['section_num'];
                  $name = $row['SectionCourse'];
                  echo '<option value="'.$id.'">'.$name.'</option>';
}
?>
    </select>
</br><br>
<input type="submit" value="Select Roster">
</form>

<br><hr><br>



<h3>2a - Rooms Equipped with a Feature</h3>
<form action="2a.php" method="post">
    Room: <select name='form-room' required><?php
    $conn = mysqli_connect("db.soic.indiana.edu","i308f19_team01","team01","i308f19_team01");
    // Check connection
    if (!$conn) {
        die("Connection failed: " . mysqli_connect_error() . "<br>");
    }
        $result = mysqli_query($conn,"SELECT distinct feature FROM room_feature ORDER BY feature");
        while ($row = mysqli_fetch_assoc($result)) {
                      unset($id, $name);
                      $id = $row['feature'];
                      $name = $row['feature'];
                      echo '<option value="'.$id.'">'.$name.'</option>';
    }
    ?>
        </select>
    </br><br>
    <input type="submit" name="submit" value="Select Rooms with Feature">
</form>

<br><hr><br>

<h3>3a - Faculty and Every Course They Have Taught</h3>
<form action="3a.php" method="post">

    <input type="submit" name="submit" value="Select Faculty and Their Courses">
</form>

<br><hr><br>

<h3>4a - Students Who Are Eligible to Register for a Specific Course with a Prerequisite</h3>
<form action="4a.php" method="post">

    Course: <select name="form-course" required>
                <option value="4">INFO-I 210</option>
                <option value="5">INFO-I 211</option>
                <option value="6">INFO-I 202</option>
                <option value="10">INFO-I 201</option>
                <option value="16">INFO-I 342</option>
                <option value="17">INFO-I 360</option>
                <option value="20">SPH-I 190</option>
            </select><br><br>

    <input type="submit" name="submit" value="Select Eligible Students">
</form>

<br><hr><br>

<h3>5a - Chronological List of All Courses Taken by a Student and GPA</h3>
<form action="5a.php" method="post">

    Student: <select name='form-student' required><?php
    $conn = mysqli_connect("db.soic.indiana.edu","i308f19_team01","team01","i308f19_team01");
    // Check connection
    if (!$conn) {
        die("Connection failed: " . mysqli_connect_error() . "<br>");
    }
        $result = mysqli_query($conn,"SELECT distinct CONCAT(Fname, ' ', Lname) as StudentName, student_id FROM student ORDER BY Lname");
        while ($row = mysqli_fetch_assoc($result)) {
                      unset($id, $name);
                      $id = $row['student_id'];
                      $name = $row['StudentName'];
                      echo '<option value="'.$id.'">'.$name.'</option>';
    }
    ?>
        </select>
    </br><br>

    <input type="submit" name="submit" value="Select Student">
</form>

<br><hr><br>

<h3>7a - Students and their Advisor</h3>
<form action="7a.php" method="post">

    Advisor: <select name="form-advisor" required>
                <option value="1">Wake McDoual</option>
                <option value="2">Ninetta Ortega</option>
                <option value="3">Suzi Bubb</option>
                <option value="4">Rubin Shearsby</option>
                <option value="5">Franz Bidder</option>
        </select>
    </br><br>

    <input type="submit" name="submit" value="Select Student">
</form>

<br><hr><br>

<h3>9a - List of Majors Offered With Department and Requirements to Graduate</h3>
<form action="9a.php" method="post">
    <input type="submit" name="submit" value="Select Majors">
</form>


<br><hr><br>

<h3>1b - Roster for Specific Section with Average Grade</h3>
<p>Sections 27, 30, 34, 41, 43, and 46 are empty, so they will return 0 results</p>
<form action="1b.php" method="post">

    Section: <select name='form-sectionb' required><?php
    $conn = mysqli_connect("db.soic.indiana.edu","i308f19_team01","team01","i308f19_team01");
    // Check connection
    if (!$conn) {
        die("Connection failed: " . mysqli_connect_error() . "<br>");
    }
    $result = mysqli_query($conn,"SELECT DISTINCT CONCAT(csspr.section_num,' - ', c.course_num) as SectionCourse, csspr.section_num FROM course_section_semester_people_room as csspr, course as c WHERE csspr.course_id = c.course_id ORDER BY csspr.section_num");
    while ($row = mysqli_fetch_assoc($result)) {
                  unset($id, $name);
                  $id = $row['section_num'];
                  $name = $row['SectionCourse'];
                  echo '<option value="'.$id.'">'.$name.'</option>';
    }
    ?>
        </select>
    </br><br>

    <input type="submit" name="submit" value="Select Roster with Average">
</form>

<br><hr><br>

<h3>3b - Faculty Who Have Never Taught A Specific Course</h3>
<form action="3b.php" method="post">
    Room: <select name='form-courseb' required><?php
    $conn = mysqli_connect("db.soic.indiana.edu","i308f19_team01","team01","i308f19_team01");
    // Check connection
    if (!$conn) {
        die("Connection failed: " . mysqli_connect_error() . "<br>");
    }
        $result = mysqli_query($conn,"SELECT distinct course_id, course_num FROM course ORDER BY course_id");
        while ($row = mysqli_fetch_assoc($result)) {
                      unset($id, $name);
                      $id = $row['course_id'];
                      $name = $row['course_num'];
                      echo '<option value="'.$id.'">'.$name.'</option>';
    }
    ?>
        </select>
    </br><br>
    <input type="submit" name="submit" value="Select Faculty">
</form>

<br><hr><br>

<h3>5b - Chronological List of All Courses Taken by a Student, Grades Earned, Overall Hours Taken, and GPA</h3>
<form action="5b.php" method="post">

    Student: <select name='form-studentb' required><?php
    $conn = mysqli_connect("db.soic.indiana.edu","i308f19_team01","team01","i308f19_team01");
    // Check connection
    if (!$conn) {
        die("Connection failed: " . mysqli_connect_error() . "<br>");
    }
        $result = mysqli_query($conn,"SELECT distinct CONCAT(Fname, ' ', Lname) as StudentName, student_id FROM student ORDER BY Lname");
        while ($row = mysqli_fetch_assoc($result)) {
                      unset($id, $name);
                      $id = $row['student_id'];
                      $name = $row['StudentName'];
                      echo '<option value="'.$id.'">'.$name.'</option>';
    }
    ?>
        </select>
    </br><br>

    <input type="submit" name="submit" value="Select Student">
</form>

<br><hr><br>


<h3>8b - Students Who Haven't Attended the Two Most Recent Semesters</h3>
<form action="8b.php" method="post">
    <input type="submit" name="submit" value="Select Students">
</form>

<br><hr><br>

<h3>5c - Chronological List of All Courses Taken by a Student and GPA, Overall GPA, and Credits Earned</h3>
<form action="5c.php" method="post">

    Student: <select name='form-studentc' required><?php
    $conn = mysqli_connect("db.soic.indiana.edu","i308f19_team01","team01","i308f19_team01");
    // Check connection
    if (!$conn) {
        die("Connection failed: " . mysqli_connect_error() . "<br>");
    }
        $result = mysqli_query($conn,"SELECT distinct CONCAT(Fname, ' ', Lname) as StudentName, student_id FROM student ORDER BY Lname");
        while ($row = mysqli_fetch_assoc($result)) {
                      unset($id, $name);
                      $id = $row['student_id'];
                      $name = $row['StudentName'];
                      echo '<option value="'.$id.'">'.$name.'</option>';
    }
    ?>
        </select>
    </br><br>

    <input type="submit" name="submit" value="Select Student">
</form>

<br><hr><br>

<h3>9c - Students with Credit Hours Earned, Overall GPA, and have met Graduation Requirements for any Major</h3>
<form action="9c.php" method="post">
    <input type="submit" name="submit" value="Select Students">
</form>

<br><hr><br>

<h3>Additional 1 - Alphabetical List of Employees and Their Phone Numbers and Emails With Certain Rank</h3>
<form action="A1.php" method="post">

    Employee Rank: <select name='form-rank' required><?php
    $conn = mysqli_connect("db.soic.indiana.edu","i308f19_team01","team01","i308f19_team01");
    // Check connection
    if (!$conn) {
        die("Connection failed: " . mysqli_connect_error() . "<br>");
    }
        $result = mysqli_query($conn,"SELECT distinct rank FROM people ORDER BY rank");
        while ($row = mysqli_fetch_assoc($result)) {
                      unset($id, $name);
                      $id = $row['rank'];
                      $name = $row['rank'];
                      echo '<option value="'.$id.'">'.$name.'</option>';
    }
    ?>
        </select>
    </br><br>

    <input type="submit" name="submit" value="Select Employees">
</form>

<br><hr><br>

<h3>Additional 2 - List of Students Who Don't Meet the Minimum GPA Requirement, and Their Advisor, Area of Expertise, and Email</h3>
<form action="A2.php" method="post">
    <input type="submit" name="submit" value="Select Students">
</form>

</body>
</html>
