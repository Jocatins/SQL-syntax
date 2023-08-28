

-- 3
select b.SecondName, count(distinct a.Id) as IDS 
 from Actors a 
 inner join Actors b 
 on a.SecondName = b.SecondName where a.Id != b.Id group by b.SecondName; 

 -- The code block below returns the same output as the one above, but it the distinct is not needed

 select distinct b.SecondName, count(distinct a.Id) as IDS 
 from Actors a 
 inner join Actors b 
 on a.SecondName = b.SecondName where a.Id != b.Id group by b.SecondName; 

-- 2
 -- Two actors share the same second Name

 select distinct concat(a.FirstName, "+" , b.SecondName) as SecondName
 from Actors a 
 inner join Actors b 
 on a.SecondName = b.SecondName 
 where a.Id != b.Id ;

--  4

 select distinct concat(FirstName, "-", SecondName) as Acts_Casted
 from Actors 
 inner join Cast 
 on Id = ActorId group by Id desc;

 -- 5
 select distinct concat(FirstName, "-", SecondName) as Acts_Not_Casted
 from Actors 
where Id not in (select Id from Actors inner join Cast on Id = ActorId);

Select concat(Id , " ", FirstName, " ", SecondName)
as Acts_Not_Casted 
from Actors a
left join Cast on Id = ActorId  
where MovieId is null;
