--*****PLEASE ENTER YOUR DETAILS BELOW*****
--T3-mns-json.sql

--Student ID: 32533888
--Student Name: Sara Alana Hopkins
--Unit Code: FIT3171
--Applied Class No: Applied02 Wednesday 10am


/* Comments for your marker:




*/

/*3(a)*/
-- PLEASE PLACE REQUIRED SQL SELECT STATEMENT TO GENERATE 
-- THE COLLECTION OF JSON DOCUMENTS HERE
-- ENSURE that your query is formatted and has a semicolon
-- (;) at the end of this answer
set pagesize 200
select json_object(
    '_id' value a.appt_no,
    'datetime' value to_char(a.appt_datetime, 'dd/mm/yyyy hh24:mi'),
    'provider_code' value p.provider_code,
    'provider_name' value p.provider_fname || ' ' || p.provider_lname,
    'item_totalcost' value sum(i.item_stdcost),
    'no_of_items' value count(i.item_id),
    'items' value json_arrayagg(
      json_object(
        'id' value i.item_id,
        'desc' value i.item_desc,
        'standardcost' value i.item_stdcost,
        'quantity' value i.item_stock
      ) format json
    )
  ) || ',' AS json
from mns.appointment a
join mns.provider p on a.provider_code = p.provider_code
join mns.apptservice_item ai on a.appt_no = ai.appt_no
join mns.item i on i.item_id = ai.item_id
group by a.appt_no, a.appt_datetime, p.provider_code, p.provider_fname, p.provider_lname
order by a.appt_no;