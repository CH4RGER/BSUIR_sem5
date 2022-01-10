--1 Получить полную информацию обо всех преподавателях.
SELECT * FROM teacher;
--2 Получить полную информацию обо всех студенческих группах на специальности ЭВМ.
SELECT * FROM student_group WHERE specialty = 'ЭВМ';
--3 Получить личный номер преподавателя и номера аудиторий, в которых они преподают предмет с кодовым номером 18П.
SELECT DISTINCT personal_number, auditorium FROM teacher_student_group WHERE subject_number = '18П';
--4 Получить  номера предметов и названия предметов, которые ведет преподаватель Костин.
SELECT DISTINCT teacher_student_group.subject_number, subject.name FROM subject
    INNER JOIN teacher_student_group ON subject.code = teacher_student_group.subject_number
    WHERE personal_number = (SELECT personal_number FROM teacher WHERE surname = 'Костин');
--5 Получить номер группы, в которой ведутся предметы преподавателем Фроловым.
SELECT DISTINCT tsg.group_number FROM teacher
    INNER JOIN teacher_student_group tsg ON teacher.personal_number = tsg.personal_number
    WHERE teacher.surname = 'Фролов';
--6 Получить информацию о предметах, которые ведутся на специальности АСОИ.
SELECT * FROM subject WHERE specialty = 'АСОИ';
--7 Получить информацию о преподавателях, которые ведут предметы на специальности АСОИ.
SELECT * FROM teacher WHERE specialty LIKE '%АСОИ%';
--8 Получить фамилии преподавателей, которые ведут предметы в 210 аудитории.
SELECT DISTINCT teacher.surname FROM teacher
    INNER JOIN teacher_student_group tsg on teacher.personal_number = tsg.personal_number
    WHERE auditorium = '210';
--9 Получить названия предметов и названия групп, которые ведут занятия в аудиториях с 100 по 200.
SELECT DISTINCT subject.name, tsg.group_number FROM subject
    INNER JOIN teacher_student_group tsg on subject.code = tsg.subject_number
    WHERE auditorium BETWEEN 100 AND 200;
--10 Получить пары номеров групп с одной специальности.
SELECT DISTINCT first_group.code, second_group.code FROM student_group first_group
    INNER JOIN student_group second_group ON first_group.specialty = second_group.specialty
    WHERE first_group.code < second_group.code;
--11 Получить общее количество студентов, обучающихся на специальности ЭВМ.
SELECT sum(size) FROM student_group WHERE student_group.specialty = 'ЭВМ';
--12 Получить номера преподавателей, обучающих студентов по специальности ЭВМ.
SELECT DISTINCT personal_number FROM teacher_student_group
    INNER JOIN student_group  ON teacher_student_group.group_number = student_group.code
    WHERE specialty LIKE '%ЭВМ%';
-- 13 Получить номера предметов, изучаемых всеми студенческими группами.
SELECT subject_schedule.code
FROM (SELECT subject.code, count(*) as gr_count
        FROM subject
        INNER JOIN teacher_student_group
        ON subject.code = teacher_student_group.subject_number
        GROUP BY subject.code) as subject_schedule
WHERE gr_count = (SELECT count(*) FROM student_group);
-- 14 Получить фамилии преподавателей, преподающих те же предметы, что и преподаватель преподающий предмет с номером 14П.
SELECT teacher.surname FROM teacher WHERE specialty LIKE (SELECT DISTINCT specialty FROM teacher_student_group
    INNER JOIN teacher t ON t.personal_number = teacher_student_group.personal_number
    WHERE subject_number = '14П');
-- 15 Получить информацию о предметах, которые не ведет преподаватель с личным номером 221П.
CREATE VIEW specialities AS SELECT result.specialty FROM teacher result WHERE personal_number = '221Л';
SELECT * FROM subject WHERE (SELECT specialty FROM specialities) NOT LIKE concat('%', subject.specialty,'%');
-- 16 Получить информацию о предметах, которые не изучаются в группе М-6.
CREATE VIEW m6_studied_subjects AS (SELECT DISTINCT s.name from student_group INNER JOIN teacher_student_group tsg on student_group.code = tsg.group_number
    INNER JOIN subject s on s.code = tsg.subject_number WHERE student_group.name = 'М-6');
CREATE VIEW all_subjects AS SELECT DISTINCT name from subject;
SELECT * from all_subjects where name NOT IN (select name from m6_studied_subjects);
-- 17 Получить информацию о доцентах, преподающих в группах 3Г и 8Г.
CREATE VIEW personal_numbers_of_3g_and_8g AS SELECT DISTINCT personal_number FROM teacher_student_group
    WHERE group_number = '3Г' OR group_number = '8Г';
SELECT * FROM teacher WHERE position='Доцент' and personal_number IN (SELECT personal_number FROM personal_numbers_of_3g_and_8g);
--18 Получить номера предметов, номера преподавателей, номера групп, в которых ведут занятия преподаватели с кафедры ЭВМ, имеющих специальность АСОИ.
CREATE VIEW personal_numbers_evm_and_asoi AS SELECT DISTINCT personal_number from teacher
    WHERE department = 'ЭВМ' AND specialty like '%АСОИ%';
SELECT DISTINCT subject_number, group_number, personal_number from teacher_student_group
where personal_number in (select personal_number from personal_numbers_evm_and_asoi);
--19 Получить номера групп с такой же специальностью, что и специальность преподавателей.
CREATE VIEW teachers_specialities AS SELECT specialty FROM teacher;
SELECT code FROM subject WHERE specialty IN(SELECT * FROM teachers_specialities);
--20 Получить номера преподавателей с кафедры ЭВМ, преподающих предметы по специальности, совпадающей со специальностью студенческой группы.
CREATE VIEW students_group_specialities AS SELECT specialty FROM student_group;
SELECT personal_number FROM teacher WHERE  department = 'ЭВМ' AND specialty IN (SELECT * FROM students_group_specialities);
--21 Получить специальности студенческой группы, на которых работают преподаватели кафедры АСУ.
SELECT DISTINCT sg.specialty FROM student_group sg
    INNER JOIN teacher_student_group tsg ON sg.code = tsg.group_number
    INNER JOIN teacher t ON t.personal_number = tsg.personal_number
    WHERE t.department = 'АСУ';
--22 Получить номера предметов, изучаемых группой АС-8.
SELECT DISTINCT subject_number FROM teacher_student_group
    WHERE group_number IN (SELECT code from student_group where name = 'АС-8');
--23 Получить номера студенческих групп, которые изучают те же предметы, что и студенческая группа АС-8.
CREATE VIEW as_8_studied_subject_numbers AS SELECT subject_number from teacher_student_group
    inner join student_group sg on sg.code = teacher_student_group.group_number
    where sg.name = 'АС-8';
SELECT DISTINCT group_number FROM teacher_student_group
    WHERE subject_number in (SELECT * FROM as_8_studied_subject_numbers);
--24 Получить номера студенческих групп, которые не изучают предметы, преподаваемых в студенческой группе АС-8.
SELECT DISTINCT tsg.group_number FROM teacher_student_group tsg  WHERE subject_number
    NOT IN (SELECT group_number FROM teacher_student_group INNER JOIN student_group sg ON sg.code = teacher_student_group.group_number
        WHERE specialty NOT IN (SELECT specialty FROM student_group WHERE sg.name = 'АС-8'));
--25 Получить номера студенческих групп, которые не изучают предметы, преподаваемых преподавателем 430Л.
CREATE VIEW teacher_430_lessons as select subject.code FROM subject
    INNER JOIN teacher_student_group tsg on subject.code = tsg.subject_number
    INNER JOIN teacher ON tsg.personal_number = teacher.personal_number
    WHERE teacher.personal_number = '430Л';
SELECT * FROM teacher_430_lessons;
--26 Получить номера преподавателей, работающих с группой Э-15, но не преподающих предмет 12П.
CREATE VIEW teachers_working_wth_e15 AS SELECT personal_number FROM teacher_student_group
    WHERE  group_number IN (SELECT code FROM student_group WHERE name = 'Э-15');
SELECT DISTINCT personal_number FROM teacher_student_group WHERE personal_number
    NOT IN (SELECT * FROM teachers_working_wth_e15);

--13 15 20 25
