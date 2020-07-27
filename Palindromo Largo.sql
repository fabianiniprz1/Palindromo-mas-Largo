use bdTemporal


declare @palabra varchar(150), @palabra_inversa varchar(150), @palabra_en_revision varchar(150),
		@palabra_mas_larga varchar(150),

		@inicio_uno int, @inicio_dos int,
		@fin_uno int, @contador_uno int


set		@palabra			= '121aaabbaajgggg'
set		@palabra_inversa	= REVERSE(@palabra)
set		@contador_uno		= 1
set		@inicio_uno			= 1
set		@inicio_dos			= 1
set		@fin_uno			= len(@palabra)

if exists(select 1 from tempdb.sys.objects where name = '##tmpPalin')
begin
drop table ##tmpPalin;
end

create table ##tmpPalin (	palindromo varchar(150),
							longitud	int)

while(@inicio_uno<=@fin_uno)
begin

	while (@contador_uno <= @fin_uno)
	begin

		set @palabra_en_revision = SUBSTRING(@palabra_inversa,@inicio_uno,@contador_uno)
		print @palabra_en_revision

			while(@inicio_dos<=@fin_uno)

			begin
			if (SUBSTRING(@palabra,@inicio_dos,@contador_uno)= @palabra_en_revision)
			begin
			insert into ##tmpPalin (	palindromo,longitud)
			select @palabra_en_revision,len(@palabra_en_revision)
			end
			set @inicio_dos +=1 
			end
		
		set @inicio_dos =1
		set @contador_uno += 1

	end
	set @inicio_uno += 1
	set @contador_uno = 1

end


select 'El palindromo más largo de la palabra '+ @palabra +' es: '+ palindromo
from ##tmpPalin
where longitud =  (select max(longitud) from ##tmpPalin)
order by longitud desc