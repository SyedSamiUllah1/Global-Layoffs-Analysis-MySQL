select * from layoffs_staging2;


SELECT company, SUM(total_laid_off) AS total_laid_off
FROM layoffs_staging2
WHERE company IS NOT NULL
GROUP BY company
HAVING SUM(total_laid_off) IS NOT NULL order by total_laid_off desc limit 5;

with company_year(company, `year` , total_laid_off) as (select company , Year(`date`) as `year`, sum(total_laid_off)
from layoffs_staging2
group by company, `year`),
 company_year_rank as (select *,
dense_rank() over(partition by `year` order by total_laid_off desc) as `rank`
from company_year)
select * from company_year_rank
where `rank`<=5
;


SELECT 
    industry, SUM(total_laid_off) total_laid_off
FROM
    layoffs_staging2
GROUP BY industry
having 
ORDER BY total_laid_off DESC
LIMIT 5;


SELECT 
    *
FROM
    layoffs_staging2
WHERE
    percentage_laid_off = 1
ORDER BY total_laid_off DESC limit 5;


SELECT 
    Year(`date`) `year`, SUM(total_laid_off) total_laid_off
FROM
    layoffs_staging2
GROUP BY `year`
having `year` is not null
ORDER BY total_laid_off DESC
LIMIT 5;


with Rolling_Total as (select substring(`date`, 1,7) as `date` , sum(total_laid_off) as total__off
from layoffs_staging2
where substring(`date`, 1,7) is not null
group by substring(`date`, 1,7)
having total__off is not null 
order by `date`)
select `date` ,sum(total__off) over(order by `date`) as rolling_total from Rolling_Total
;