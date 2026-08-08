select * from layoffs_staging2;

insert into layoffs_staging2
select *, 
row_number() 
over(Partition By company,
 location,
 industry,
 total_laid_off, percentage_laid_off,
 `date`,
 stage,
 country,
 funds_raised_millions)  as row_num
from layoffs_staging;

select * from layoffs_staging2
where row_num>1;

Delete from layoffs_staging2
where row_num>1;

update layoffs_staging2
set company = trim(company);


select industry from layoffs_staging2
where industry like 'Crypto%';


update layoffs_staging2
set industry ='Crypto'
where industry like 'Crypto%';





select * from layoffs_staging2
where country like 'UNITED%';


update layoffs_staging2
set country = trim(trailing '.' from country);



select country from layoffs_staging
where country like '%.';


SELECT 
    `date`, STR_TO_DATE(`date`, '%m/%d/%Y')
FROM
    layoffs_staging2;
    
update layoffs_staging2
set `date` = STR_TO_DATE(`date`, '%m/%d/%Y');

select `date` from layoffs_staging2;


alter table layoffs_staging2
modify column `date`  date;


SELECT 
    *
FROM
    layoffs_staging2
WHERE
    total_laid_off IS NULL
        AND percentage_laid_off IS NULL;


update layoffs_staging2
set industry= Null
where industry ='';


select industry from layoffs_staging2 where industry is null;


select t1.industry, t2.industry 
from layoffs_staging2 t1 join layoffs_staging2 t2
on t1.company = t2.company
where t1.industry is null
and t2.industry is not null
;


update layoffs_staging2 t1 join layoffs_staging2 t2
on t1.company = t2.company
set t1.industry = t2.industry
where t1.industry is null
and t2.industry is not null
;


SELECT 
    *
FROM
    layoffs_staging2
WHERE
    total_laid_off IS NULL

        AND percentage_laid_off IS NULL;

DELETE
FROM
    layoffs_staging2
WHERE
    total_laid_off IS NULL
        AND percentage_laid_off IS NULL;



alter table layoffs_staging2
drop column row_num;

SELECT 
    *
FROM
    layoffs_staging2;
    
    
