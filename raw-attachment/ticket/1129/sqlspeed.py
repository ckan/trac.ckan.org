import sys
from sqlalchemy import create_engine
from package_ids import package_ids
from sqlalchemy.sql import text

#engine = create_engine('postgres://david:ytrewq@localhost/dgu', echo=True)
engine = create_engine('postgres://david:password@localhost/dgu')
conn = engine.connect()

test ='''select package_extra_revision.* from package_extra_revision where package_extra_revision.package_id = '%s' '''

self_join ='''
select 
package_extra_revision.* 
from 
    package_extra_revision join revision on revision.id = package_extra_revision.revision_id 
join 
    (select 
         pr.id,
         max(timestamp) ts 
     from 
          package_extra_revision pr 
     join 
          revision r on pr.revision_id = r.id 
     where 
        r.timestamp < current_date - 100 and pr.package_id = '%s' 
     group by pr.id) sub
 
on sub.ts = revision.timestamp and sub.id = package_extra_revision.id;
'''

self_join2 ='''
select 
package_extra_revision.* 
from 
    package_extra_revision 
join 
    (select 
         pr.id,
         max(timestamp) ts 
     from 
          package_extra_revision pr 
     where 
        pr.timestamp < current_date - 100 and pr.package_id = '%s' 
     group by pr.id) sub
 
on sub.ts = package_extra_revision.timestamp and sub.id = package_extra_revision.id;
'''


distinct ='''
select 
    distinct on (per.id) 
    per.* 
from 
   package_extra_revision per 
join 
revision r on per.revision_id = r.id where timestamp < current_date - 100 and per.package_id = '%s' 
order by 
   per.id, timestamp desc;
'''

distinct2 ='''
select 
    distinct on (per.id) 
    per.* 
from 
   package_extra_revision per 
where 
   timestamp < current_date - 100 and per.package_id = '%s' 
order by 
   per.id, timestamp desc;
'''

window ='''
select foo.* from 
    (select 
     per.*,
     row_number() over (partition by per.id order by timestamp desc) as ord
     from
        package_extra_revision per 
     join 
         revision r on r.id = per.revision_id 
     where 
         timestamp < current_date - 100 and  per.package_id = '%s'
      ) as foo
where 
     ord = 1;
'''

window2 ='''
select foo.* from 
    (select 
     per.*,
     row_number() over (partition by per.id order by timestamp desc) as ord
     from
        package_extra_revision per 
     where 
         timestamp < current_date - 100 and  per.package_id = '%s'
      ) as foo
where 
     ord = 1;
'''


if __name__ == '__main__':
    import datetime
    statement = locals()[sys.argv[1]]

    start = datetime.datetime.now()

    for num, package in enumerate(package_ids):
        conn.execute(text(statement % package)).fetchall()
            

    print datetime.datetime.now() - start

   
