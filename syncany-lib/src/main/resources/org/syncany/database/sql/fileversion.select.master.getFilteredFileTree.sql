select *
from fileversion 
where 
	status<>'DELETED'
	and (filehistory_id, version) in (
		select filehistory_id, max(version) maxversion
		from fileversion_master
		where 
			path like ?
			and substr_count(path, '/')>=?
			and substr_count(path, '/')<=?			
			and updated<?
			and type in (unnest(?))			
		group by filehistory_id
	)
