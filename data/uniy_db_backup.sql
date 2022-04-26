--
-- PostgreSQL database dump
--

BEGIN;
-- Dumped by pg_dump version 11.4


ALTER TABLE IF EXISTS sections DROP CONSTRAINT IF EXISTS sections_fkey_teacher;
ALTER TABLE IF EXISTS sections DROP CONSTRAINT IF EXISTS sections_fkey_course;
ALTER TABLE IF EXISTS enrolls DROP CONSTRAINT IF EXISTS enrolls_fkey_student;
ALTER TABLE IF EXISTS enrolls DROP CONSTRAINT IF EXISTS enrolls_fkey_section;
ALTER TABLE IF EXISTS enrolls DROP CONSTRAINT IF EXISTS enrolls_fkey_course;
ALTER TABLE IF EXISTS teachers DROP CONSTRAINT IF EXISTS teachers_pkey;
ALTER TABLE IF EXISTS students DROP CONSTRAINT IF EXISTS students_pkey;
ALTER TABLE IF EXISTS sections DROP CONSTRAINT IF EXISTS sections_pkey;
ALTER TABLE IF EXISTS enrolls DROP CONSTRAINT IF EXISTS enrolls_pkey;
ALTER TABLE IF EXISTS courses DROP CONSTRAINT IF EXISTS courses_pkey;
DROP TABLE IF EXISTS teachers;
DROP TABLE IF EXISTS students;
DROP TABLE IF EXISTS sections;
DROP TABLE IF EXISTS enrolls;
DROP TABLE IF EXISTS courses;
SET default_with_oids = false;

--
-- Name: courses; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE courses (
    course_id smallint NOT NULL,
    course_name character(20),
    department character(16),
    num_credits smallint
);


--
-- Name: enrolls; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE enrolls (
    course_id smallint NOT NULL,
    section_id smallint NOT NULL,
    student_id smallint NOT NULL,
    grade smallint
);


--
-- Name: sections; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE sections (
    course_id smallint NOT NULL,
    section_id smallint NOT NULL,
    teacher_id smallint,
    num_students smallint
);


--
-- Name: students; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE students (
    student_id smallint NOT NULL,
    student_name character(18),
    address character(20),
    city character(10),
    state character(2),
    zip character(5),
    gender character(1)
);


--
-- Name: teachers; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE teachers (
    teacher_id smallint NOT NULL,
    teacher_name character(18),
    phone character(10),
    salary numeric(10,2)
);


--
-- Data for Name: courses; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO courses (course_id, course_name, department, num_credits) VALUES (450, 'Western Civilization', 'History         ', 3);
INSERT INTO courses (course_id, course_name, department, num_credits) VALUES (730, 'Calculus IV         ', 'Math            ', 4);
INSERT INTO courses (course_id, course_name, department, num_credits) VALUES (290, 'English Composition ', 'English         ', 3);
INSERT INTO courses (course_id, course_name, department, num_credits) VALUES (480, 'Compiler Writing    ', 'Computer Science', 3);
INSERT INTO courses (course_id, course_name, department, num_credits) VALUES (550, 'Art History         ', 'History         ', 3);


--
-- Data for Name: enrolls; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO enrolls (course_id, section_id, student_id, grade) VALUES (730, 1, 148, 3);
INSERT INTO enrolls (course_id, section_id, student_id, grade) VALUES (450, 2, 210, 3);
INSERT INTO enrolls (course_id, section_id, student_id, grade) VALUES (730, 1, 210, 1);
INSERT INTO enrolls (course_id, section_id, student_id, grade) VALUES (290, 1, 298, 3);
INSERT INTO enrolls (course_id, section_id, student_id, grade) VALUES (480, 2, 298, 3);
INSERT INTO enrolls (course_id, section_id, student_id, grade) VALUES (730, 1, 348, 2);
INSERT INTO enrolls (course_id, section_id, student_id, grade) VALUES (290, 1, 349, 4);
INSERT INTO enrolls (course_id, section_id, student_id, grade) VALUES (480, 1, 410, 2);
INSERT INTO enrolls (course_id, section_id, student_id, grade) VALUES (450, 1, 473, 2);
INSERT INTO enrolls (course_id, section_id, student_id, grade) VALUES (730, 1, 473, 3);
INSERT INTO enrolls (course_id, section_id, student_id, grade) VALUES (480, 2, 473, 0);
INSERT INTO enrolls (course_id, section_id, student_id, grade) VALUES (290, 1, 548, 2);
INSERT INTO enrolls (course_id, section_id, student_id, grade) VALUES (730, 1, 558, 3);
INSERT INTO enrolls (course_id, section_id, student_id, grade) VALUES (730, 1, 649, 4);
INSERT INTO enrolls (course_id, section_id, student_id, grade) VALUES (480, 1, 649, 4);
INSERT INTO enrolls (course_id, section_id, student_id, grade) VALUES (450, 1, 654, 4);
INSERT INTO enrolls (course_id, section_id, student_id, grade) VALUES (450, 2, 548, NULL);


--
-- Data for Name: sections; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO sections (course_id, section_id, teacher_id, num_students) VALUES (450, 1, 303, 2);
INSERT INTO sections (course_id, section_id, teacher_id, num_students) VALUES (730, 1, 290, 6);
INSERT INTO sections (course_id, section_id, teacher_id, num_students) VALUES (290, 1, 430, 3);
INSERT INTO sections (course_id, section_id, teacher_id, num_students) VALUES (480, 1, 180, 3);
INSERT INTO sections (course_id, section_id, teacher_id, num_students) VALUES (450, 2, 560, 2);
INSERT INTO sections (course_id, section_id, teacher_id, num_students) VALUES (480, 2, 784, 2);


--
-- Data for Name: students; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO students (student_id, student_name, address, city, state, zip, gender) VALUES (148, 'Susan Powell      ', '534 East River Dr.  ', 'Haverford ', 'PA', '19041', 'F');
INSERT INTO students (student_id, student_name, address, city, state, zip, gender) VALUES (210, 'Bob Dawson        ', '120 South Jefferson ', 'Newport   ', 'RI', '02891', 'M');
INSERT INTO students (student_id, student_name, address, city, state, zip, gender) VALUES (298, 'Howard Mansfield  ', '290 Wynkoop Drive   ', 'Vienna    ', 'VA', '22180', 'M');
INSERT INTO students (student_id, student_name, address, city, state, zip, gender) VALUES (348, 'Susan Pugh        ', '534 East Hampton Dr.', 'Hartford  ', 'CT', '06107', 'F');
INSERT INTO students (student_id, student_name, address, city, state, zip, gender) VALUES (349, 'Joe Adams         ', '473 Emmerson Street ', 'Newark    ', 'DE', '19702', 'M');
INSERT INTO students (student_id, student_name, address, city, state, zip, gender) VALUES (354, 'Janet Ladd        ', '441 10th Street     ', 'Pennsburg ', 'PA', '18073', 'F');
INSERT INTO students (student_id, student_name, address, city, state, zip, gender) VALUES (410, 'Bill Jones        ', '120 South Harrison  ', 'Newport   ', 'CA', '92660', 'M');
INSERT INTO students (student_id, student_name, address, city, state, zip, gender) VALUES (473, 'Carol Dean        ', '983 Park Avenue     ', 'Boston    ', 'MA', '02169', 'F');
INSERT INTO students (student_id, student_name, address, city, state, zip, gender) VALUES (548, 'Allen Thomas      ', '238 West Ox Road    ', 'Chicago   ', 'IL', '60624', 'M');
INSERT INTO students (student_id, student_name, address, city, state, zip, gender) VALUES (558, 'Val Shipp         ', '238 Westport Road   ', 'Chicago   ', 'IL', '60556', 'F');
INSERT INTO students (student_id, student_name, address, city, state, zip, gender) VALUES (649, 'John Anderson     ', '473 Emmory Street   ', 'New York  ', 'NY', '10008', 'M');
INSERT INTO students (student_id, student_name, address, city, state, zip, gender) VALUES (654, 'Janet Thomas      ', '441 6th Street      ', 'Erie      ', 'PA', '16510', 'F');


--
-- Data for Name: teachers; Type: TABLE DATA; Schema: public; Owner: -
--

INSERT INTO teachers (teacher_id, teacher_name, phone, salary) VALUES (303, 'Dr. Horn          ', '257-3049  ', 27540.00);
INSERT INTO teachers (teacher_id, teacher_name, phone, salary) VALUES (290, 'Dr. Lowe          ', '257-2390  ', 31450.00);
INSERT INTO teachers (teacher_id, teacher_name, phone, salary) VALUES (430, 'Dr. Engle         ', '256-4621  ', 38200.00);
INSERT INTO teachers (teacher_id, teacher_name, phone, salary) VALUES (180, 'Dr. Cooke         ', '257-8088  ', 29560.00);
INSERT INTO teachers (teacher_id, teacher_name, phone, salary) VALUES (560, 'Dr. Olsen         ', '257-8086  ', 31778.00);
INSERT INTO teachers (teacher_id, teacher_name, phone, salary) VALUES (784, 'Dr. Scango        ', '257-3046  ', 32098.00);
INSERT INTO teachers (teacher_id, teacher_name, phone, salary) VALUES (213, 'Dr. Wright        ', '257-3393  ', 35000.00);


--
-- Name: courses courses_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE courses
    ADD CONSTRAINT courses_pkey PRIMARY KEY (course_id);


--
-- Name: enrolls enrolls_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE enrolls
    ADD CONSTRAINT enrolls_pkey PRIMARY KEY (course_id, section_id, student_id);


--
-- Name: sections sections_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE sections
    ADD CONSTRAINT sections_pkey PRIMARY KEY (course_id, section_id);


--
-- Name: students students_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE students
    ADD CONSTRAINT students_pkey PRIMARY KEY (student_id);


--
-- Name: teachers teachers_pkey; Type: CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE teachers
    ADD CONSTRAINT teachers_pkey PRIMARY KEY (teacher_id);


--
-- Name: enrolls enrolls_fkey_course; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE enrolls
    ADD CONSTRAINT enrolls_fkey_course FOREIGN KEY (course_id) REFERENCES courses(course_id) ON DELETE CASCADE;


--
-- Name: enrolls enrolls_fkey_section; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE enrolls
    ADD CONSTRAINT enrolls_fkey_section FOREIGN KEY (course_id, section_id) REFERENCES sections(course_id, section_id) ON DELETE CASCADE;


--
-- Name: enrolls enrolls_fkey_student; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE enrolls
    ADD CONSTRAINT enrolls_fkey_student FOREIGN KEY (student_id) REFERENCES students(student_id) ON DELETE CASCADE;


--
-- Name: sections sections_fkey_course; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE sections
    ADD CONSTRAINT sections_fkey_course FOREIGN KEY (course_id) REFERENCES courses(course_id) ON DELETE CASCADE;


--
-- Name: sections sections_fkey_teacher; Type: FK CONSTRAINT; Schema: public; Owner: -
--

ALTER TABLE sections
    ADD CONSTRAINT sections_fkey_teacher FOREIGN KEY (teacher_id) REFERENCES teachers(teacher_id) ON DELETE SET NULL;


--
COMMIT;
--

