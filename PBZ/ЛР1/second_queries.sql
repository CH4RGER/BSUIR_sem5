-- 6 9 10 15 16 22 24 27 30 35

--6
SELECT supplier_id,detail_id,project_id FROM supplier_project_part_number
    INNER JOIN supplier s on s.id = supplier_project_part_number.supplier_id
    INNER JOIN part p on p.id = supplier_project_part_number.detail_id
    INNER JOIN project p2 on p2.id = supplier_project_part_number.project_id
    WHERE s.city = p.city AND s.city = p2.city;
--9
SELECT detail_id FROM supplier_project_part_number
    INNER JOIN supplier s on s.id = supplier_project_part_number.supplier_id
    WHERE s.city = 'Лондон';
--10
SELECT detail_id FROM supplier_project_part_number
    INNER JOIN supplier s on s.id = supplier_project_part_number.supplier_id
    INNER JOIN project p on p.id = supplier_project_part_number.project_id
    WHERE s.city = 'Лондон' AND p.city = 'Лондон';
--15
SELECT DISTINCT count(*) FROM supplier_project_part_number
    WHERE supplier_id = 'П1';
--16
SELECT DISTINCT count(*) FROM supplier_project_part_number
    WHERE supplier_id = 'П1' AND detail_id = 'Д1';
--22
SELECT DISTINCT project_id FROM supplier_project_part_number
    WHERE supplier_id = 'П1';
--24
SELECT id FROM supplier WHERE status < (SELECT status FROM supplier WHERE id = 'П1');
--27
SELECT project_id FROM supplier_project_part_number as sppn
    WHERE sppn.detail_id = 'Д1' AND ((SELECT AVG(quantity) FROM supplier_project_part_number AS sppn2 WHERE (sppn.detail_id = sppn2.detail_id)) < sppn.quantity);
--30
SELECT detail_id FROM supplier_project_part_number
    INNER JOIN project p on p.id = supplier_project_part_number.project_id
    WHERE P.city = 'Лондон';
--35
SELECT DISTINCT sppn.supplier_id AS "Not a provider", sppn2.detail_id AS ITEM
    FROM supplier_project_part_number AS sppn, supplier_project_part_number AS sppn2
    WHERE sppn.detail_id NOT IN (SELECT sppn3.detail_id
                                 FROM supplier_project_part_number AS sppn3
                                WHERE sppn3.supplier_id = sppn2.supplier_id)
                                ORDER BY sppn.supplier_id;

