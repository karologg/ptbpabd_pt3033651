--QUESTÃO 01--
CREATE PROCEDURE student_grade_points
	@grade VARCHAR(2)
AS
BEGIN
	SELECT 
		s.name AS StudentName,
		s.dept_name AS studentdept,
		c.title AS coursetitle,
		c.dept_name AS coursedept,
		t.semester,
		t.year,
		t.grade AS abcgrade,
		gp.points AS numgrade
	FROM
		student s
		JOIN takes t ON s.s_ID = t.s_ID
		JOIN course c ON t.course_ID = c.course_ID
		JOIN grade_points gp ON t.grade = gp.grade
	WHERE
		t.grade = @grade;
END;



--QUESTÃO 02--
CREATE FUNCTION return_instructor_location
(
    @InstructorName VARCHAR(100)
)
RETURNS TABLE
AS
RETURN
(
    SELECT
        i.name AS InstructorName,
        c.title AS CourseTitle,
        sec.semester,
        sec.year,
        sec.building,
        sec.room_number
    FROM
        instructor i
        JOIN teaches t ON i.ID = t.ID
        JOIN section sec ON t.course_id = sec.course_id AND t.sec_id = sec.sec_id 
                         AND t.semester = sec.semester AND t.year = sec.year
        JOIN course c ON sec.course_id = c.course_id
    WHERE
        i.name = @InstructorName
);
