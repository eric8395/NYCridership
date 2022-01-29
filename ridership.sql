use subway;

-- imported ridership data into ridershipdata table
-- pull table to see columns
select * from ridership;

-- Whats the date range in this dataset?
select MAX(Date) as EndDate, MIN(Date) as StartDate
from ridership;

-- Whats the total amount of rows, ie. count of days between the End and Start Dates?
select COUNT(*) as number_of_rows
from ridership;

-- What was the subway ridership during those two dates(2020-03-01 & 2022-01-27)?
select Date, Subway_Total, Percent_Subway_PrePandemic 
from ridership
where Date = '2022-01-27' or Date = '2020-03-01';

-- What was the average amount of subway riders during this time (2020-03-01 & 2022-01-27)??
select ROUND(AVG(Subway_Total),0) as AverageSubwayRidership
from ridership
where Date >= '2020-03-01';

-- What was the subway ridership during the initial weeks of COVID? 
-- Select dates in March 2020 only
select Date, Subway_Total
from ridership
where Date >= '2020-03-01' and Date <= '2020-03-31'
Order by Date;

-- Using the 2022-01-27 date, what was the total difference in subway riders from a year ago? 
select Date,
	(select Subway_Total from ridership where Date = '2022-01-27') as Ridership2022,
    (select Subway_Total from ridership where Date = '2021-01-27') as Ridership2021,
    (select Subway_Total from ridership where Date = '2021-01-27') - (select Subway_Total from ridership where Date = '2022-01-27') as difference
from ridership
where date = '2022-01-27';
    
-- What was the total amount of riders for each method of transportation in 2020?
select SUM(Subway_Total) as Subway2020Total,
	SUM(Buses_Total) as Buses2020Total, 
	SUM(LIRR_Total) as LIRR2020Total, 
    SUM(MetroNorth_Total) as MetroNorth2020Total, 
    SUM(AccessARide_Total) as AccessARide2020Total,
    SUM(Bridges_Tunnels_Total) as BridgesTunnels2020Total
from ridership
where Date >= '2020-03-01' and Date <= '2020-12-31';

-- What was the total amount of riders for each method of transportation in 2021?
select SUM(Subway_Total) as Subway2021Total,
	SUM(Buses_Total) as Buses2021Total, 
	SUM(LIRR_Total) as LIRR2021Total, 
    SUM(MetroNorth_Total) as MetroNorth2021Total, 
    SUM(AccessARide_Total) as AccessARide2021Total,
    SUM(Bridges_Tunnels_Total) as BridgesTunnels2021Total
from ridership
where Date >= '2021-01-01' and Date <= '2021-12-31';


