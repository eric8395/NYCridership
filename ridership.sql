use subway;

-- imported ridership data into ridershipdata table
-- pull table to see columns
select * from ridership;

-- 1. Whats the date range in this dataset?
select MAX(Date) as EndDate, MIN(Date) as StartDate
from ridership;

-- 2. Whats the total amount of rows, ie. count of days between the End and Start Dates?
select COUNT(*) as number_of_rows
from ridership;

-- 3. What was the subway ridership during those two dates(2020-03-01 & 2022-01-27)?
select Date, Subway_Total, Percent_Subway_PrePandemic 
from ridership
where Date = '2022-01-27' or Date = '2020-03-01';

-- 4. What was the average amount of subway riders during this time (2020-03-01 & 2022-01-27)??
select ROUND(AVG(Subway_Total),0) as AverageSubwayRidership
from ridership
where Date >= '2020-03-01';

-- 5. What was the subway ridership during the initial weeks of COVID? 
-- Select dates in March 2020 only
select Date, Subway_Total
from ridership
where Date >= '2020-03-01' and Date <= '2020-03-31'
Order by Date;

-- 6. Using the 2022-01-27 date, what was the total difference in subway riders from a year ago? 
select Date,
	(select Subway_Total from ridership where Date = '2022-01-27') as Ridership2022,
    (select Subway_Total from ridership where Date = '2021-01-27') as Ridership2021,
    (select Subway_Total from ridership where Date = '2021-01-27') - (select Subway_Total from ridership where Date = '2022-01-27') as difference
from ridership
where date = '2022-01-27';
    
-- 7. What was the total amount of riders for each method of transportation in 2020?
select SUM(Subway_Total) as Subway2020Total,
	SUM(Buses_Total) as Buses2020Total, 
	SUM(LIRR_Total) as LIRR2020Total, 
    SUM(MetroNorth_Total) as MetroNorth2020Total, 
    SUM(AccessARide_Total) as AccessARide2020Total,
    SUM(Bridges_Tunnels_Total) as BridgesTunnels2020Total
from ridership
where Date >= '2020-03-01' and Date <= '2020-12-31';

-- 8. What was the total amount of riders for each method of transportation in 2021?
select SUM(Subway_Total) as Subway2021Total,
	SUM(Buses_Total) as Buses2021Total, 
	SUM(LIRR_Total) as LIRR2021Total, 
    SUM(MetroNorth_Total) as MetroNorth2021Total, 
    SUM(AccessARide_Total) as AccessARide2021Total,
    SUM(Bridges_Tunnels_Total) as BridgesTunnels2021Total
from ridership
where Date >= '2021-01-01' and Date <= '2021-12-31';

-- import Average Weekday Subway Ridership Table
select *
from weekdaysubwayridership;

-- rename Station column
alter table weekdaysubwayridership rename column `Station (alphabetical by borough)` to Station;

-- 9. Select the top 5 busiest stations in 2019
select Station, Borough, `2019`
from weekdaysubwayridership
order by `2019` desc
limit 5;

-- 10. Select the 5 least busiest stations in 2019
select Station, Borough, `2019`
from weekdaysubwayridership
order by `2019` asc
limit 5;

-- 11. What were the 5 busiest stations in Queens in 2019?
select Station, Borough, `2019`
from weekdaysubwayridership
where Borough = 'Q'
order by `2019` desc
limit 5;

-- 12. Using the top 5 busiest stations in Queens, compare to ridership in 2020
select Station, Borough, `2019`, `2020`, `2020`-`2019` as Difference
from weekdaysubwayridership
where Borough = 'Q' and `2019` >= 25235 -- 5th busiest avg weekday ridership in 2019
order by `2020` desc
limit 5;

-- 13. What is the total amount of commuters for each borough in 2017? Sort by borough
select Borough, SUM(`2017`) as TotalRidersPerBoro2017
from weekdaysubwayridership
group by Borough
order by TotalRidersPerBoro2017 desc;

-- 14. What is the total amount of commuters for each borough for EACH year? Sort by borough
select Borough, 
	SUM(`2015`) as TotalRidersPerBoro2015,
    SUM(`2016`) as TotalRidersPerBoro2016,
	SUM(`2017`) as TotalRidersPerBoro2017,
    SUM(`2018`) as TotalRidersPerBoro2018,
    SUM(`2019`) as TotalRidersPerBoro2019,
    SUM(`2020`) as TotalRidersPerBoro2020
from weekdaysubwayridership
group by Borough
order by TotalRidersPerBoro2015 desc;

-- 15. What is the difference in total average ridership from 2019 to 2020 by boro? Determine percent change?
select Borough, 
	SUM(`2019`) as TotalAvgRidersPerBoro2019, 
    SUM(`2020`) as TotalAvgRidersPerBoro2020,
    SUM(`2020`) - SUM(`2019`) as RidershipDifference,
    ROUND((SUM(`2020`) - SUM(`2019`)) / SUM(`2019`), 2) as PercentChange
from weekdaysubwayridership
group by Borough;

-- 16. What is the difference in average ridership from 2019 to 2020 for the top 10 stations? Determine percent change?
select Station, Borough,
	SUM(`2019`) as AvgRidersPerStation2019, 
    SUM(`2020`) as AvgRidersPerStation2020,
    SUM(`2020`) - SUM(`2019`) as AvgRidershipDifference,
    ROUND((SUM(`2020`) - SUM(`2019`)) / SUM(`2019`), 2) as PercentChange
from weekdaysubwayridership
group by Station, Borough
order by PercentChange 
limit 10;


