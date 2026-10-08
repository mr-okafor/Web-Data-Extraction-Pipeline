/* To Do
column standardization done
missing values
numeric cleaning
duplicates
trims
*/

-- Ref. column

select *
from EpidemicData

SELECT [Ref.]
FROM EpidemicData 
WHERE [Ref.] IS NULL 
   OR TRIM([Ref.]) = ''; --blanks

UPDATE EpidemicData
SET [Ref.] = NULL
WHERE [Ref.] IS NULL 
   OR TRIM([Ref.]) = ''; -- fill blanks with null

UPDATE EpidemicData
SET [Ref.] = TRIM(REPLACE(REPLACE([Ref.], '[', ' '), ']', ' ')) -- remove squares


-- column trims
UPDATE EpidemicData 
SET 
    Event = TRIM(Event), 
    Years = TRIM(Years), 
    Location = TRIM(Location), 
    Disease = TRIM(Disease), 
    [Death toll (estimate)] = TRIM([Death toll (estimate)])
WHERE 
    Event LIKE ' %' OR Event LIKE '% '
    OR Years LIKE ' %' OR Years LIKE '% '
    OR Location LIKE ' %' OR Location LIKE '% '
    OR Disease LIKE ' %' OR Disease LIKE '% '
    OR [Death toll (estimate)] LIKE ' %' OR [Death toll (estimate)] LIKE '% ';

UPDATE EpidemicData
SET [Death toll (estimate)] = NULL
WHERE [Death toll (estimate)] = '?' -- replace ? with null

SELECT *
from EpidemicData 

UPDATE EpidemicData
SET [Death toll (estimate)] = LEFT([Death toll (estimate)], CHARINDEX('(', [Death toll (estimate)] + '(') - 1);

UPDATE EpidemicData
SET [Death toll (estimate)] = REPLACE([Death toll (estimate)], ',', '');

UPDATE EpidemicData
SET [Death toll (estimate)] = REPLACE([Death toll (estimate)], '+', '');

update EpidemicData
set [Death toll (estimate)] = Null
where [Death toll (estimate)] like 'Unknown%';

UPDATE EpidemicData
SET [Death toll (estimate)] = '1.4–9.3 million'
where [Death toll (estimate)] = '1.4-9.3 million ; 21000–143000 each year'
    AND Event = 'Seventh cholera pandemic';

ALTER TABLE EpidemicData
Add lower_death_limit varchar(250),
    upper_death_limit varchar(250);

SELECT
    [Death toll (estimate)],
    
    -- 1. FIRST VALUE: Cleaned, extracted, and text units handled
    LTRIM(RTRIM(REPLACE(
        CASE 
            WHEN CHARINDEX('–', [Death toll (estimate)]) > 0
            THEN LEFT([Death toll (estimate)], CHARINDEX('–', [Death toll (estimate)]) - 1)
            ELSE [Death toll (estimate)]
        END, 
        ',', '' -- Removes commas (e.g., 25,000 -> 25000)
    ))) + 
    -- If the first number doesn't have a unit but the second one does, append it here
    CASE 
        WHEN CHARINDEX('–', [Death toll (estimate)]) > 0 
         AND [Death toll (estimate)] LIKE '%million%' 
         AND NOT LEFT([Death toll (estimate)], CHARINDEX('–', [Death toll (estimate)]) - 1) LIKE '%million%'
        THEN ' million'
        ELSE ''
    END AS First_Value,

    -- 2. SEPARATOR
    CASE 
        WHEN CHARINDEX('–', [Death toll (estimate)]) > 0 THEN '–'
        ELSE NULL
    END AS Separator,

    -- 3. SECOND VALUE: Cleaned and isolated into just digits/units
    CASE 
        WHEN CHARINDEX('–', [Death toll (estimate)]) > 0
        THEN LTRIM(RTRIM(REPLACE(SUBSTRING(
            [Death toll (estimate)],
            CHARINDEX('–', [Death toll (estimate)]) + 1,
            LEN([Death toll (estimate)])
        ), ',', '')))
        ELSE NULL
    END AS Second_Value

FROM EpidemicData;

UPDATE EpidemicData
SET lower_death_limit = 
                        LTRIM(RTRIM(REPLACE(
        CASE 
            WHEN CHARINDEX('–', [Death toll (estimate)]) > 0
            THEN LEFT([Death toll (estimate)], CHARINDEX('–', [Death toll (estimate)]) - 1)
            ELSE [Death toll (estimate)]
        END, 
        ',', '' -- Removes commas (e.g., 25,000 -> 25000)
    ))) + 
    -- If the first number doesn't have a unit but the second one does, append it here
    CASE 
        WHEN CHARINDEX('–', [Death toll (estimate)]) > 0 
         AND [Death toll (estimate)] LIKE '%million%' 
         AND NOT LEFT([Death toll (estimate)], CHARINDEX('–', [Death toll (estimate)]) - 1) LIKE '%million%'
        THEN ' million'
        ELSE ''
    END ;

UPDATE EpidemicData
SET upper_death_limit =
    -- 3. SECOND VALUE: Cleaned and isolated into just digits/units
    CASE 
        WHEN CHARINDEX('–', [Death toll (estimate)]) > 0
        THEN LTRIM(RTRIM(REPLACE(SUBSTRING(
            [Death toll (estimate)],
            CHARINDEX('–', [Death toll (estimate)]) + 1,
            LEN([Death toll (estimate)])
        ), ',', '')))
        ELSE NULL
END; 

select *
from EpidemicData
WHERE upper_death_limit IS NOT NULL;


SELECT
    upper_death_limit,
    
    CASE
        WHEN LOWER(LTRIM(RTRIM(upper_death_limit))) LIKE '%million%' THEN
            TRY_CAST(
                LTRIM(RTRIM(
                    REPLACE(
                        LOWER(upper_death_limit),
                        'million',
                        ''
                    )
                )) AS DECIMAL(18,2)
            ) * 1000000

        ELSE
            TRY_CAST(
                LTRIM(RTRIM(upper_death_limit))
                AS DECIMAL(18,2)
            )
    END AS Death_Toll_Number

FROM EpidemicData;


SELECT
    lower_death_limit,
    
    CASE
        WHEN LOWER(LTRIM(RTRIM(lower_death_limit))) LIKE '%million%' THEN
            TRY_CAST(
                LTRIM(RTRIM(
                    REPLACE(
                        LOWER(lower_death_limit),
                        'million',
                        ''
                    )
                )) AS DECIMAL(18,2)
            ) * 1000000

        ELSE
            TRY_CAST(
                LTRIM(RTRIM(lower_death_limit))
                AS DECIMAL(18,2)
            )
    END AS Death_Toll_Number

FROM EpidemicData;

ALTER TABLE EpidemicData
ADD Min_Death_Toll DECIMAL(18,2),
    Max_Death_Toll DECIMAL(18,2);

UPDATE EpidemicData
SET Min_Death_Toll = 
    CASE
        WHEN LOWER(LTRIM(RTRIM(lower_death_limit))) LIKE '%million%' THEN
            TRY_CAST(
                LTRIM(RTRIM(
                    REPLACE(
                        LOWER(lower_death_limit),
                        'million',
                        ''
                    )
                )) AS DECIMAL(18,2)
            ) * 1000000

        ELSE
            TRY_CAST(
                LTRIM(RTRIM(lower_death_limit))
                AS DECIMAL(18,2)
            )
        END;

UPDATE EpidemicData
SET Max_Death_Toll = 
        CASE
        WHEN LOWER(LTRIM(RTRIM(upper_death_limit))) LIKE '%million%' THEN
            TRY_CAST(
                LTRIM(RTRIM(
                    REPLACE(
                        LOWER(upper_death_limit),
                        'million',
                        ''
                    )
                )) AS DECIMAL(18,2)
            ) * 1000000

        ELSE
            TRY_CAST(
                LTRIM(RTRIM(upper_death_limit))
                AS DECIMAL(18,2)
            )
    END

select 
    Event,
    Years,
    Location,
    Disease,
    [Death toll (estimate)],
    Min_Death_Toll,
    Max_Death_Toll,
    [Ref.]
INTO dbo.EpidemicData_Cleaned
FROM dbo.EpidemicData;

select *
from EpidemicData_Cleaned
