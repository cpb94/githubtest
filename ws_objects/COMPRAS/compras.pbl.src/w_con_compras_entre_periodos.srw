$PBExportHeader$w_con_compras_entre_periodos.srw
$PBExportComments$Nuevo Sin Acabar
forward
global type w_con_compras_entre_periodos from w_int_con_empresa
end type
type pb_2 from upb_salir within w_con_compras_entre_periodos
end type
type dw_1 from u_datawindow_consultas within w_con_compras_entre_periodos
end type
type em_fechadesde from u_em_campo within w_con_compras_entre_periodos
end type
type st_7 from statictext within w_con_compras_entre_periodos
end type
type cb_2 from commandbutton within w_con_compras_entre_periodos
end type
type pb_imprimir_preli from upb_imprimir within w_con_compras_entre_periodos
end type
type cb_3 from commandbutton within w_con_compras_entre_periodos
end type
type gb_1 from groupbox within w_con_compras_entre_periodos
end type
type em_fechahasta from u_em_campo within w_con_compras_entre_periodos
end type
type em_fechadesde2 from u_em_campo within w_con_compras_entre_periodos
end type
type st_2 from statictext within w_con_compras_entre_periodos
end type
type em_fechahasta2 from u_em_campo within w_con_compras_entre_periodos
end type
type cbx_detalle from checkbox within w_con_compras_entre_periodos
end type
type cbx_consumos from checkbox within w_con_compras_entre_periodos
end type
type dw_seleccion from u_seleccion2 within w_con_compras_entre_periodos
end type
end forward

global type w_con_compras_entre_periodos from w_int_con_empresa
integer x = 55
integer y = 24
integer width = 5294
integer height = 3156
string title = "Estadística comparativa de Compras por Productos y Familias"
string icon = "Application!"
pb_2 pb_2
dw_1 dw_1
em_fechadesde em_fechadesde
st_7 st_7
cb_2 cb_2
pb_imprimir_preli pb_imprimir_preli
cb_3 cb_3
gb_1 gb_1
em_fechahasta em_fechahasta
em_fechadesde2 em_fechadesde2
st_2 st_2
em_fechahasta2 em_fechahasta2
cbx_detalle cbx_detalle
cbx_consumos cbx_consumos
dw_seleccion dw_seleccion
end type
global w_con_compras_entre_periodos w_con_compras_entre_periodos

type variables
String	is_codigo,ante_articulo,var_calidad,var_tipo_pallet,var_cliente,var_envio
Integer   var_tono,var_calibre
String  devolver
String var_moneda,var_mascara
string productos_marcados[]
end variables

forward prototypes
public subroutine f_cargar (datawindow data)
public function decimal f_stock_valorado (string familia, datetime fecha_hasta1, integer registro)
public function decimal f_stock_valorado_maximo (string familia, string materia, datetime fecha1, datetime fecha2, integer registro)
end prototypes

public subroutine f_cargar (datawindow data);string filtro_familias, filtro_productos, sel, efectiva, mp
long   indice, productos_selecionados, familias_seleccionadas, i, donde, anyo, mes, dia, total_regs, metros1, metros2, consumo1, consumo2, total_materias
dec    v_unidades1, v_importe1, v_unidades2, v_importe2, valorprod1, valorprod2, prueba, stock_valorado1, stock_valorado2
datetime fecha_desde1, fecha_hasta1, fecha_desde2, fecha_hasta2
string tipo_materia, familia, des_tipo_materia, des_familia
String a,m
Date fecha
DataStore registros, materias
str_res_consumo resultado

data.Reset()

fecha_desde1 = DateTime(Date("01-"+em_fechadesde.text))
a = mid(em_fechahasta.text,4)
m = String(Long(mid(em_fechahasta.text,1,2)) + 1)
if Long(m) > 12 then 
	fecha = Date("31-12-"+a)
else
	fecha = Date("01-"+m+"-"+a)
	fecha = RelativeDate(fecha,-1)
end if
fecha_hasta1 = DateTime(fecha,time(0))
//fecha_hasta1 = DateTime(Date(em_fechahasta.text))
fecha_desde2 = DateTime(Date("01-"+em_fechadesde2.text))
a = mid(em_fechahasta2.text,4)
m = String(Long(mid(em_fechahasta2.text,1,2)) + 1)
if Long(m) > 12 then 
	fecha = Date("31-12-"+a)
else
	fecha = Date("01-"+m+"-"+a)
	fecha = RelativeDate(fecha,-1)
end if
fecha_hasta2 = DateTime(fecha,time(0))
//fecha_hasta2 = DateTime(Date(em_fechahasta2.text))
//MessageBox("Desde ",String(fecha_desde1)+" hasta "+String(fecha_hasta1)+ " - " +String(fecha_desde2)+" hasta "+String(fecha_hasta2))
data.object.t_p1.text = "Del "+string (date(fecha_desde1))+" al "+string (date(fecha_hasta1))
data.object.t_p2.text = "Del "+string (date(fecha_desde2))+" al "+string (date(fecha_hasta2))


//CALCULOS METROS PRODUCIDOS (Encajado sin control de las mermas acumuladas)
f_mensaje_proceso ("Calculando Metros", 1, 3)
metros1 = 0
metros2 = 0

SELECT sum (((prodpartes_ot.buenas + prodpartes_ot.malas) * formatos.ancho * formatos.largo)/10000) into :metros1 
FROM prodpartes_ot LEFT OUTER JOIN formatos ON prodpartes_ot.empresa = formatos.empresa AND prodpartes_ot.formato = formatos.codigo 
WHERE prodpartes_ot.empresa = :codigo_empresa AND 
		prodpartes_ot.fecha >= :fecha_desde1 AND
		prodpartes_ot.fecha <= :fecha_hasta1 AND 
		prodpartes_ot.seccion = 9; //Operaciones de encajado solo

f_mensaje_proceso ("Calculando Metros", 2, 3)

SELECT sum (((prodpartes_ot.buenas + prodpartes_ot.malas) * formatos.ancho * formatos.largo)/10000) into :metros2 
FROM   prodpartes_ot LEFT OUTER JOIN formatos ON prodpartes_ot.empresa = formatos.empresa AND prodpartes_ot.formato = formatos.codigo 
WHERE  prodpartes_ot.empresa = :codigo_empresa AND 
		 prodpartes_ot.fecha >= :fecha_desde2 AND
		 prodpartes_ot.fecha <= :fecha_hasta2 AND 
		 prodpartes_ot.seccion = 9; //Operaciones de encajado solo

f_mensaje_proceso ("Calculando Metros", 3, 3)
		 
//CALCULOS VALOR DE LA PRODUCCION
Decimal variacion_existencias_pt1, variacion_existencias_st1, ventas_brutas_pt1, devoluciones1
Decimal variacion_existencias_pt2, variacion_existencias_st2, ventas_brutas_pt2, devoluciones2

Int anyo11, anyo21, anyo12, anyo22
anyo11 = year(Date(fecha_desde1))
anyo12 = year(Date(fecha_hasta1))
anyo21 = year(Date(fecha_desde2))
anyo22 = year(Date(fecha_hasta2))

f_mensaje_proceso ("Calculando Valor Prod.", 1, 5)

//VARIACION EXISTENCIAS PT
SELECT SUM(haber - debe) INTO :variacion_existencias_pt1 
FROM 	 contaapun
WHERE	 empresa = :codigo_empresa 
		 and ejercicio IN (:anyo11,:anyo21)
		 and ( cuenta like '7120%' or cuenta like '7930%' )
		 and fapunte >= :fecha_desde1 and fapunte <= :fecha_hasta1 
		 and origen <> '102';
		 
SELECT SUM(haber - debe) INTO :variacion_existencias_pt2 
FROM 	 contaapun
WHERE	 empresa = :codigo_empresa 
		 and ejercicio IN (:anyo12,:anyo22)
		 and ( cuenta like '7120%' or cuenta like '7930%' )
		 and fapunte >= :fecha_desde2 and fapunte <= :fecha_hasta2 
		 and origen <> '102';
		 
f_mensaje_proceso ("Calculando Valor Prod.", 2, 5)

//VARIACION EXISTENCIAS ST
Select sum (haber - debe) INTO :variacion_existencias_st1 
from contaapun 
where empresa = :codigo_empresa 
		and ejercicio IN (:anyo11,:anyo21) 
		and cuenta like '7110%'  
		and fapunte >= :fecha_desde1 and fapunte <= :fecha_hasta1 
		and origen <> '102';
		
Select sum (haber - debe) INTO :variacion_existencias_st2 
from contaapun 
where empresa = :codigo_empresa 
		and ejercicio IN (:anyo12,:anyo22) 
		and cuenta like '7110%'  
		and fapunte >= :fecha_desde2 and fapunte <= :fecha_hasta2 
		and origen <> '102';

f_mensaje_proceso ("Calculando Valor Prod.", 3, 5)

//VENTAS BRUTAS PT

select sum (haber - debe) INTO :ventas_brutas_pt1 
from contaapun 
where empresa = :codigo_empresa 
		and ejercicio IN (:anyo11,:anyo21) 
		and cuenta like '701%' 
		and fapunte >= :fecha_desde1 and fapunte <= :fecha_hasta1 
		and origen <> '102';
		
select sum (haber - debe) INTO :ventas_brutas_pt2 
from contaapun 
where empresa = :codigo_empresa 
		and ejercicio IN (:anyo12,:anyo22) 
		and cuenta like '701%' 
		and fapunte >= :fecha_desde2 and fapunte <= :fecha_hasta2 
		and origen <> '102';

f_mensaje_proceso ("Calculando Valor Prod.", 4, 5)

//DEVOLUCIONES
select sum (haber - debe) INTO :devoluciones1 
from contaapun 
where empresa = :codigo_empresa 
		and ejercicio IN (:anyo11,:anyo21) 
		and cuenta like '708%' 
		and fapunte >= :fecha_desde1 and fapunte <= :fecha_hasta1 
		and origen <> '102';
		
select sum (haber - debe) INTO :devoluciones2 
from contaapun 
where empresa = :codigo_empresa 
		and ejercicio IN (:anyo12,:anyo22) 
		and cuenta like '708%' 
		and fapunte >= :fecha_desde2 and fapunte <= :fecha_hasta2 
		and origen <> '102';
		
		
valorprod1 = variacion_existencias_pt1 + variacion_existencias_st1 + ventas_brutas_pt1 + devoluciones1
valorprod2 = variacion_existencias_pt2 + variacion_existencias_st2 + ventas_brutas_pt2 + devoluciones2

//CALCULOS DE PARÁMETROS DEL INFORME POR FAMILIAS

sel = " select venfamilias.tipo_materia, venfamilias.familia, venfamilias.descripcion, venmateria.descripcion "+&
		" from venfamilias, venmateria "+&
		" where venfamilias.empresa = '"+codigo_empresa+"'"+&
		" and venfamilias.empresa = venmateria.empresa "+&
		" and venfamilias.tipo_materia = venmateria.codigo AND "+ dw_seleccion.devolver_resultado()+&
		" order by venmateria.descripcion asc "

f_mensaje_proceso ("Calculando Valor Prod.", 5, 5)

f_cargar_cursor_nuevo (sel, registros)
total_regs = registros.RowCount()
for i = 1 to total_regs
	f_mensaje_proceso ("Registro: "+string(i)+" de "+string(total_regs), i, total_regs + 1)
	
	tipo_materia = registros.object.venfamilias_tipo_materia[i]
	familia = registros.object.venfamilias_familia[i]
	des_tipo_materia = registros.object.venmateria_descripcion[i]
	des_familia = registros.object.venfamilias_descripcion[i]		
	
	//PERIODO 1
	consumo1 = 0
	v_unidades1 = 0
	v_importe1 = 0	
	
	select venmprima.tipo_materia, venmprima.familia, sum (comlinfac.cantidad) cantidad, sum (comlinfac.importe) importe 
	into :tipo_materia, :familia, :v_unidades1, :v_importe1
	from comlinfac, venmprima,  comcabfac 
 	where comlinfac.empresa = :codigo_empresa
	and comlinfac.empresa = venmprima.empresa 
	and comlinfac.empresa = comcabfac.empresa  
	and comlinfac.anyo = comcabfac.anyo 
	and comlinfac.factura = comcabfac.factura
	and comlinfac.proveedor = comcabfac.proveedor 
	and comlinfac.mprima = venmprima.codigo 
	and venmprima.tipo_materia = :tipo_materia
	and venmprima.familia = :familia
	and comcabfac.fecha_fac >= :fecha_desde1
	and comcabfac.fecha_fac <= :fecha_hasta1
	group by venmprima.tipo_materia, venmprima.familia;
	
	//STOCK VALORADO (SISTEMA APROXIMACIÓN)
	/*
	if cbx_consumos.checked = true then
		consumo1 = v_importe1 - (f_stock_valorado_maximo(familia, tipo_materia, Datetime(Date("01-01-2001")), fecha_hasta1, i) - f_stock_valorado_maximo(familia, tipo_materia, Datetime(Date("01-01-2001")), fecha_desde1, i))
	else
		consumo1 = 0
	end if
	*/
	
	//SISTEMA FIFO
	if cbx_consumos.checked = true then
		sel = "SELECT venmprima.codigo "+&
			"FROM venmprima "+&
			"WHERE venmprima.tipo_materia = '"+tipo_materia+"' AND venmprima.familia = '"+familia+"'"
	
		f_cargar_cursor_nuevo(sel, materias)
		total_materias = materias.rowcount()
		
		stock_valorado1 = 0
		stock_valorado2 = 0
		for indice = 1 to total_materias
			//Para cada materia prima hay que calcular su stock valorado y restarlo al del principio del periodo (para sacar la variación)
			mp        = materias.object.codigo[indice]

			//	resultado  = ftc_calculo_consumo_mp(fecha_desde1, mp)
			resultado  = ftc_calculo_consumo_mp( DateTime (RelativeDate ( date(fecha_desde1), - 1) ), mp)
			stock_valorado1 = stock_valorado1 + resultado.valor		
			
			resultado  = ftc_calculo_consumo_mp(fecha_hasta1, mp)
			stock_valorado2 = stock_valorado2 + resultado.valor		
		
		next		
		
		consumo1 = v_importe1 - (stock_valorado2 - stock_valorado1)
	else
		consumo1 = 0
	end if
	
	//PERIODO2
	v_unidades2 = 0
	v_importe2 = 0
	consumo2 = 0
	select venmprima.tipo_materia, venmprima.familia, sum (comlinfac.cantidad) cantidad, sum (comlinfac.importe) importe 
	into :tipo_materia, :familia, :v_unidades2, :v_importe2
	from comlinfac, venmprima,  comcabfac 
 	where comlinfac.empresa = :codigo_empresa
	and comlinfac.empresa = venmprima.empresa 
	and comlinfac.empresa = comcabfac.empresa  
	and comlinfac.anyo = comcabfac.anyo 
	and comlinfac.factura = comcabfac.factura
	and comlinfac.proveedor = comcabfac.proveedor 
	and comlinfac.mprima = venmprima.codigo 
	and venmprima.tipo_materia = :tipo_materia
	and venmprima.familia = :familia
	and comcabfac.fecha_fac >= :fecha_desde2
	and comcabfac.fecha_fac <= :fecha_hasta2
	group by venmprima.tipo_materia, venmprima.familia ;
	
	//STOCK
	/*
	if cbx_consumos.checked = true then
		consumo2 = v_importe2 - (f_stock_valorado_maximo(familia, tipo_materia, Datetime(Date("01-01-2001")), fecha_hasta2, i) - f_stock_valorado_maximo(familia, tipo_materia, Datetime(Date("01-01-2001")), fecha_desde2, i))
	else
		consumo2 = 0
	end if
	*/
	
	//SISTEMA FIFO
	if cbx_consumos.checked = true then
		sel = "SELECT venmprima.codigo "+&
			"FROM venmprima "+&
			"WHERE venmprima.tipo_materia = '"+tipo_materia+"' AND venmprima.familia = '"+familia+"'"
	
		f_cargar_cursor_nuevo(sel, materias)
		total_materias = materias.rowcount()
		
		stock_valorado1 = 0
		stock_valorado2 = 0
		for indice = 1 to total_materias
			//Para cada materia prima hay que calcular su stock valorado y restarlo al del principio del periodo (para sacar la variación)
			mp        = materias.object.codigo[indice]
			
		//	resultado  = ftc_calculo_consumo_mp(fecha_desde2, mp)
			resultado  = ftc_calculo_consumo_mp ( DateTime ( RelativeDate ( date( fecha_desde2 ), - 1) ), mp)
			stock_valorado1 = stock_valorado1 + resultado.valor		
			
			resultado  = ftc_calculo_consumo_mp(fecha_hasta2, mp)
			stock_valorado2 = stock_valorado2 + resultado.valor		
		
		next		
		
		consumo2 = v_importe2 - (stock_valorado2 - stock_valorado1)
	else
		consumo2 = 0
	end if
	
	donde = data.insertrow(0)
	data.object.producto[donde]              	= des_tipo_materia
	data.object.familia[donde]           		= des_familia
	data.object.unidades1[donde]            	= v_unidades1
	data.object.importe1[donde]             	= v_importe1
	
	data.object.consumo1[donde]             	= consumo1
	data.object.metros1a[donde] 					= metros1
	data.object.valorprod1[donde]					= valorprod1
	
	data.object.unidades2[donde]            	= v_unidades2
	data.object.importe2[donde]             	= v_importe2
	
	data.object.consumo2[donde]               = consumo2
	data.object.metros2a[donde]					= metros2
	data.object.valorprod2[donde]					= valorprod2

next

f_mensaje_proceso ("Completado", total_regs+1, total_regs+1)

//data.setsort("producto ASC, importe2 desc")
data.sort()		
data.GroupCalc()

destroy registros
destroy materias	


end subroutine

public function decimal f_stock_valorado (string familia, datetime fecha_hasta1, integer registro);string proveedor1,moneda_proveedor1, mp1
dec    stock1,precio1,stock_facturas1,importe_total1, cantidad1, cantidad_total1, stock_valorado1
dec    importe1,cambio_moneda_proveedor1
datetime fecha_ultimo_albaran1,fecha_stock1,ultima_fecha_albaran1
String sel
Boolean salir
Decimal numero_mp
Int indice
Datastore movimientos

//STOCK
sel = "select mp,"+&
	"sum(cantidade) - sum(cantidads) stock "+&
	"from commovhis "+&
	"where empresa = '"+codigo_empresa+"' "+&
	"and fechmov <= '"+String(fecha_hasta1)+"' "+&
	"and situacion <> 'A' and mp in(select codigo "+&
						 " from venmprima "+&
						 " where empresa = '"+codigo_empresa+"' and "+f_reemplazar(f_reemplazar(dw_seleccion.devolver_resultado(),"venfamilias.familia","venmprima.familia"),"venmateria.codigo","venmprima.tipo_materia")+") "+&
	"group by mp"

f_cargar_cursor_nuevo(sel, movimientos)
numero_mp = movimientos.rowcount()
stock_valorado1 = 0
for indice = 1 to numero_mp
	f_mensaje_proceso2 ("Registro "+String(registro),"Calculando stock valorado "+f_reemplazar(String(fecha_hasta1)," 00:00:00",""), indice, numero_mp+1)
	stock1 = movimientos.object.stock[indice]
	
	if stock1 <> 0 then
		mp1        = movimientos.object.mp[indice]
		ultima_fecha_albaran1 = fecha_hasta1
		salir = false
		importe_total1 = 0
		cantidad_total1 = 0
		precio1 = 0
		importe1 = 0
		cantidad1 = 0
		
		// Si la materia prima no tiene precio en la ficha de materias primas, no debe valorar el stock
		select max(precio)
		into   :precio1
		from   comartpro
		where  empresa = :codigo_empresa
		and    mprima  = :mp1;
		if isnull(precio1) then precio1 = 0
			
		if precio1 > 0 then
			DO
				setnull(fecha_ultimo_albaran1)
				select max(fecha_albaran)
				into   :fecha_ultimo_albaran1
				from   comlinfac
				where  empresa = :codigo_empresa
				and    mprima  = :mp1
				and    fecha_albaran <= :ultima_fecha_albaran1;
		
				if not(isnull(fecha_ultimo_albaran1)) &
					and year(date(fecha_ultimo_albaran1)) <> 1900 then//& David 11-11-03
	//				and sqlca.sqlcode <> 0 then
	
					select sum((comlinfac.cantidad * comlinfac.precio)/comcabfac.cambio)
							,sum(comlinfac.cantidad)
					into   :importe1,:cantidad1
					from   comlinfac,comcabfac
					where  comlinfac.empresa = :codigo_empresa
					and    comlinfac.mprima  = :mp1
					and    comlinfac.fecha_albaran = :fecha_ultimo_albaran1
					and    comcabfac.empresa   = comlinfac.empresa
					and    comcabfac.anyo      = comlinfac.anyo   
					and    comcabfac.proveedor = comlinfac.proveedor
					and    comcabfac.factura   = comlinfac.factura;
					
					ultima_fecha_albaran1 = datetime(relativedate(date(fecha_ultimo_albaran1), -1))
					
					importe_total1  = importe_total1 + importe1
					if isnull(importe_total1) then importe_total1 = 0
					cantidad_total1 = cantidad_total1 + cantidad1
					if isnull(cantidad_total1) then cantidad_total1 = 0
					if cantidad_total1 >= stock1 then
						salir = true
					end if
				else
					salir = true
				end if
			LOOP WHILE NOT(salir)
		end if
			
		if cantidad_total1 > 0 then
			precio1 = importe_total1 / cantidad_total1
		end if
		if precio1 <= 0 then
			//select min(precio)  David 10-11-03
			select max(precio)
			into   :precio1
			from   comartpro
			where  empresa = :codigo_empresa
			and    mprima  = :mp1;
			
			if isnull(precio1) then precio1 = 0
			if precio1 > 0 then
				select min(proveedor)
				into   :proveedor1
				from   comartpro
				where  empresa = :codigo_empresa
				and    mprima  = :mp1
				and    precio  = :precio1;
				
				if isnull(proveedor1) then proveedor1 = ""
				
				if trim(proveedor1) <> "" then
					moneda_proveedor1 = f_moneda_genter(codigo_empresa,"P",proveedor1)
					
					cambio_moneda_proveedor1 = f_cambio_moneda(moneda_proveedor1)
					
					if cambio_moneda_proveedor1 > 0 then
						precio1 = precio1 / cambio_moneda_proveedor1
					end if
				end if
			end if			
		end if
		stock_valorado1 = stock_valorado1 + stock1 * precio1
	end if
next
f_mensaje_proceso2 ("Registro "+String(registro),"Fin cálculo stock valorado "+f_reemplazar(String(fecha_hasta1)," 00:00:00",""), numero_mp+1, numero_mp+1)

return stock_valorado1
end function

public function decimal f_stock_valorado_maximo (string familia, string materia, datetime fecha1, datetime fecha2, integer registro);Decimal stock_valorado
String sel
Decimal stock, precio1, precio2, stockv
Int indice, numero_mp

Datastore movimientos

//STOCK
sel = "select a1.mp,"+&
		"sum(a1.cantidade) - sum(a1.cantidads) stock, "+&
		"(select (sum((c2.cantidad * c2.precio)/c3.cambio)/sum(c2.cantidad))	"+&			
					"from   comlinfac c2,comcabfac c3 "+&	
					"where  c2.empresa = '"+codigo_empresa+"' "+&	
					"and    c2.mprima  = a1.mp "+&	
					"and    c2.fecha_albaran >= '"+String(fecha1)+"' "+&	
					"and    c2.fecha_albaran <= '"+String(fecha2)+"' "+&	
					"and    c3.empresa   = c2.empresa "+&	
					"and    c3.anyo      = c2.anyo   "+&	
					"and    c3.proveedor = c2.proveedor "+&	
					"and    c3.factura   = c2.factura) precio1, "+&
		"(select max(c4.precio)"+&
					"from   comartpro c4 "+&
					"where  c4.empresa = '"+codigo_empresa+"' "+&
					"and    c4.mprima  = a1.mp) precio2 "+&
		"from commovhis a1 "+&
		"where a1.empresa = '"+codigo_empresa+"' "+&
		"and a1.fechmov >= '"+String(fecha1)+"' "+&
		"and a1.fechmov <= '"+String(fecha2)+"' "+&
		"and a1.situacion <> 'A' "+&
		"and a1.mp in(select v1.codigo "+&
							 " from venmprima v1 "+&
							 " where v1.empresa = '"+codigo_empresa+"' and v1.familia = '"+familia+"' and v1.tipo_materia = '"+materia+"') "+&
					 		 " group by a1.mp"
//							 " where v1.empresa = '"+codigo_empresa+"' and "+f_reemplazar(f_reemplazar(dw_seleccion.devolver_resultado(),"venfamilias.familia","v1.familia"),"venmateria.codigo","v1.tipo_materia")+") "+&
//familia

f_cargar_cursor_nuevo(sel, movimientos)
numero_mp = movimientos.rowcount()
stock_valorado = 0
for indice = 1 to numero_mp
	f_mensaje_proceso2 ("Registro "+String(registro),"Calculando stock valorado "+f_reemplazar(String(fecha1)," 00:00:00","")+" a "+f_reemplazar(String(fecha2)," 00:00:00",""), indice, numero_mp+1)
	stock = movimientos.object.stock[indice]
	precio1 = movimientos.object.precio1[indice]
	precio2 = movimientos.object.precio2[indice]
	if not isnull(precio1) then
		//Si la materia prima no tiene precio en la ficha de materias primas (comartpro), no debe valorar el stock
		if not isnull(precio2) then
			stockv = stock * precio1
		else
			stockv = 0
		end if
	elseif not isnull(precio2) then
		stockv = stock * precio2
	else
		stockv = 0
	end if
	
	stock_valorado = stock_valorado + stockv
next

f_mensaje_proceso2 ("Registro "+String(registro),"Stock valorado calculado: "+f_reemplazar(String(fecha1)," 00:00:00","")+" a "+f_reemplazar(String(fecha2)," 00:00:00",""), numero_mp+1, numero_mp+1)

return stock_valorado
end function

event open;call super::open;long indice
int anyo, mes, dia


This.title = "ESTADÍSTICA COMPARATIVA DE COMPRAS"

dw_1.SetTransObject(sqlca)
//dw_listado.SetTransObject(sqlca)

anyo = year(Today())
mes = month (today())
dia = day (today())

/*
em_fechadesde.text = string(dia)+'-'+string(mes)+'-'+string(anyo)
em_fechahasta.text = String(DateTime(Today()),"dd-mm-yy")
em_fechadesde2.text = string(dia)+'-'+string(mes)+'-'+string(anyo)
em_fechahasta2.text = String(DateTime(Today()),"dd-mm-yy")
*/
em_fechadesde.text = '01-01-'+string(anyo - 1)
em_fechahasta.text = string(dia)+'-'+string(mes)+'-'+string(anyo - 1)
em_fechadesde2.text = '01-01-'+string(anyo)
em_fechahasta2.text =string(dia)+'-'+string(mes)+'-'+string(anyo)


f_activar_campo(em_fechadesde)

//NUEVO Objeto Selección
Long numero_filas, maximo_largo, largo_total, largo_cabecera, largo_cab_grupo, largo_detalles
String consulta_seleccion 

dw_seleccion.visible = false
dw_seleccion.SetTransObject(SQLCA)
consulta_seleccion =   "SELECT venmateria.codigo,   "+&
							  "       venmateria.descripcion,   "+&
	 						  "       venfamilias.familia,  "+&
						     "	    venfamilias.descripcion,   "+&
							  "       0 as seleccionado   "+&
							  "FROM  venfamilias,   "+&
							  "       venmateria  "+&
							  "WHERE ( venfamilias.empresa = venmateria.empresa ) and  "+&
							  "      ( venfamilias.tipo_materia = venmateria.codigo ) "+&
							  "ORDER BY CONVERT(Integer,venmateria.codigo) ASC, CONVERT(Integer,venfamilias.familia) ASC"

dw_seleccion.SetSQLSelect(consulta_seleccion)
numero_filas = dw_seleccion.retrieve()

/*
String consulta, error_syntaxfromSQL, error_create, new_syntax, pres
dw_seleccion.SetTransObject(SQLCA)
dw_seleccion.retrieve()
consulta =	"SELECT desmodelo.modelo,   "+&
         	"		desmodelo.observaciones,   "+&
        		"		destrabajo2.trabajo,   "+&
         	"		destrabajo2.fecha_solicitud  "+&
    			"FROM desmodelo,   "+&
			   "		destrabajo2  "+&
   			"WHERE "+&
				"		(desmodelo.empresa = destrabajo2.empresa) and  "+&
         	"		(desmodelo.modelo = destrabajo2.modelo )"+&
				"ORDER BY desmodelo.modelo ASC"
dw_seleccion.SetSQLSelect(consulta)
dw_seleccion.Retrieve()
pres = dw_seleccion.Object.DataWindow.Syntax
pres = ""
*/
/*
//NUEVO
//Creación de treeview dinámico
String consulta, error_syntaxfromSQL, error_create, new_syntax, pres
Long total_filas

consulta =	"SELECT venmprima.codigo,    "+&
				"		venmprima.descripcion,  "+&
         	"		venfamilias.descripcion,   "+&
        		"		venfamilias.familia  "+&
    			"FROM venmprima,   "+&
			   "		venfamilias  "+&
   			"WHERE "+&
				"		(venfamilias.empresa = venmprima.empresa) and  "+&
         	"		(venfamilias.tipo_materia = venmprima.codigo )"+&
				"ORDER BY venmprima.codigo ASC"

pres = 'Style(Type=Group) Group (1)'
//pres = 'Style(Type=Grid)'

new_syntax = SQLCA.SyntaxFromSQL(consulta, pres, error_syntaxfromSQL)

IF Len(error_syntaxfromSQL) > 0 THEN
   // Display errors
	MessageBox("Error","Error en la creación del DW de parámetros de consulta. Avise al administrador."+error_syntaxfromSQL)
	Close(this)
	return
ELSE
   // Generate new DataWindow
   dw_seleccion.Create(new_syntax, error_create)
   IF Len(error_create) > 0 THEN
		MessageBox("Error","Error en la creación del DW de búsqueda. Avise al administrador."+error_create)
		Close(this)
		return
   END IF
END IF

dw_seleccion.SetTransObject(SQLCA)
total_filas = dw_seleccion.Retrieve()

dw_seleccion.Object.DataWindow.Detail.height = 70
dw_seleccion.Object.DataWindow.Header.Color = rgb(243, 71, 84) //rgb(252, 141, 156)
dw_seleccion.Object.DataWindow.Detail.Color = rgb(239, 239, 239)
dw_seleccion.bringtotop = true

MessageBox("Debug","Que cambio...")

consulta =	"SELECT desmodelo.modelo,   "+&
         	"		desmodelo.observaciones,   "+&
        		"		destrabajo2.trabajo,   "+&
         	"		destrabajo2.fecha_solicitud  "+&
    			"FROM desmodelo,   "+&
			   "		destrabajo2  "+&
   			"WHERE "+&
				"		(desmodelo.empresa = destrabajo2.empresa) and  "+&
         	"		(desmodelo.modelo = destrabajo2.modelo )"+&
				"ORDER BY desmodelo.modelo ASC"
dw_seleccion.SetSQLSelect(consulta)
total_filas = dw_seleccion.Retrieve()


*/
end event

on w_con_compras_entre_periodos.create
int iCurrent
call super::create
this.pb_2=create pb_2
this.dw_1=create dw_1
this.em_fechadesde=create em_fechadesde
this.st_7=create st_7
this.cb_2=create cb_2
this.pb_imprimir_preli=create pb_imprimir_preli
this.cb_3=create cb_3
this.gb_1=create gb_1
this.em_fechahasta=create em_fechahasta
this.em_fechadesde2=create em_fechadesde2
this.st_2=create st_2
this.em_fechahasta2=create em_fechahasta2
this.cbx_detalle=create cbx_detalle
this.cbx_consumos=create cbx_consumos
this.dw_seleccion=create dw_seleccion
iCurrent=UpperBound(this.Control)
this.Control[iCurrent+1]=this.pb_2
this.Control[iCurrent+2]=this.dw_1
this.Control[iCurrent+3]=this.em_fechadesde
this.Control[iCurrent+4]=this.st_7
this.Control[iCurrent+5]=this.cb_2
this.Control[iCurrent+6]=this.pb_imprimir_preli
this.Control[iCurrent+7]=this.cb_3
this.Control[iCurrent+8]=this.gb_1
this.Control[iCurrent+9]=this.em_fechahasta
this.Control[iCurrent+10]=this.em_fechadesde2
this.Control[iCurrent+11]=this.st_2
this.Control[iCurrent+12]=this.em_fechahasta2
this.Control[iCurrent+13]=this.cbx_detalle
this.Control[iCurrent+14]=this.cbx_consumos
this.Control[iCurrent+15]=this.dw_seleccion
end on

on w_con_compras_entre_periodos.destroy
call super::destroy
if IsValid(MenuID) then destroy(MenuID)
destroy(this.pb_2)
destroy(this.dw_1)
destroy(this.em_fechadesde)
destroy(this.st_7)
destroy(this.cb_2)
destroy(this.pb_imprimir_preli)
destroy(this.cb_3)
destroy(this.gb_1)
destroy(this.em_fechahasta)
destroy(this.em_fechadesde2)
destroy(this.st_2)
destroy(this.em_fechahasta2)
destroy(this.cbx_detalle)
destroy(this.cbx_consumos)
destroy(this.dw_seleccion)
end on

type ole_cont_pro from w_int_con_empresa`ole_cont_pro within w_con_compras_entre_periodos
integer taborder = 50
end type

type sle_opcion_orden from w_int_con_empresa`sle_opcion_orden within w_con_compras_entre_periodos
end type

type st_empresa from w_int_con_empresa`st_empresa within w_con_compras_entre_periodos
integer y = 20
integer width = 5015
integer height = 84
end type

type pb_2 from upb_salir within w_con_compras_entre_periodos
integer x = 5093
integer y = 16
integer width = 110
integer height = 96
integer taborder = 0
boolean originalsize = true
end type

on clicked;IF devolver = "S" THEN
CloseWithReturn(Parent,-1)
ELSE
  CALL Super::clicked
END IF
end on

type dw_1 from u_datawindow_consultas within w_con_compras_entre_periodos
integer x = 78
integer y = 248
integer width = 5125
integer height = 2692
integer taborder = 0
string dataobject = "dw_con_compras_entre_periodos2"
boolean vscrollbar = true
boolean livescroll = false
end type

type em_fechadesde from u_em_campo within w_con_compras_entre_periodos
integer x = 1051
integer y = 128
integer width = 370
integer height = 80
integer taborder = 10
maskdatatype maskdatatype = datemask!
string mask = "mm-yyyy"
boolean dropdowncalendar = true
end type

type st_7 from statictext within w_con_compras_entre_periodos
integer x = 677
integer y = 132
integer width = 347
integer height = 76
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Periodo 1:"
alignment alignment = right!
boolean focusrectangle = false
end type

type cb_2 from commandbutton within w_con_compras_entre_periodos
event clicked pbm_bnclicked
integer x = 4658
integer y = 124
integer width = 361
integer height = 96
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Consulta"
end type

event clicked;
if Long(dw_seleccion.devolver_seleccionados()) <= 0 then
	messagebox ("Aviso", "Debe Introducir, al menos, una familia en el filtro.")
else
	dw_seleccion.visible = false
	f_cargar(dw_1)
end if

end event

type pb_imprimir_preli from upb_imprimir within w_con_compras_entre_periodos
event clicked pbm_bnclicked
integer x = 5093
integer y = 124
integer taborder = 0
boolean originalsize = false
end type

event clicked;//f_cargar(dw_1)
f_imprimir_datawindow(dw_1)

	


end event

type cb_3 from commandbutton within w_con_compras_entre_periodos
integer x = 9
integer y = 132
integer width = 562
integer height = 92
boolean bringtotop = true
integer textsize = -8
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
string text = "Productos / Familias"
end type

event clicked;//uo_productos.visible = not(uo_productos.visible)
//uo_familias.visible = false

dw_seleccion.visible = not(dw_seleccion.visible)

end event

type gb_1 from groupbox within w_con_compras_entre_periodos
integer y = 92
integer width = 585
integer height = 140
integer textsize = -10
integer weight = 400
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 67108864
borderstyle borderstyle = styleraised!
end type

type em_fechahasta from u_em_campo within w_con_compras_entre_periodos
integer x = 1481
integer y = 128
integer width = 361
integer height = 80
integer taborder = 20
boolean bringtotop = true
maskdatatype maskdatatype = datemask!
string mask = "mm-yyyy"
boolean dropdowncalendar = true
end type

type em_fechadesde2 from u_em_campo within w_con_compras_entre_periodos
integer x = 2245
integer y = 128
integer width = 357
integer height = 80
integer taborder = 30
boolean bringtotop = true
maskdatatype maskdatatype = datemask!
string mask = "mm-yyyy"
boolean dropdowncalendar = true
end type

type st_2 from statictext within w_con_compras_entre_periodos
integer x = 1893
integer y = 132
integer width = 311
integer height = 76
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 33554432
long backcolor = 12632256
boolean enabled = false
string text = "Periodo 2:"
alignment alignment = right!
boolean focusrectangle = false
end type

type em_fechahasta2 from u_em_campo within w_con_compras_entre_periodos
integer x = 2647
integer y = 128
integer width = 361
integer height = 80
integer taborder = 40
boolean bringtotop = true
maskdatatype maskdatatype = datemask!
string mask = "mm-yyyy"
boolean dropdowncalendar = true
end type

type cbx_detalle from checkbox within w_con_compras_entre_periodos
integer x = 3177
integer y = 128
integer width = 402
integer height = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 12632256
string text = "Detalle"
boolean checked = true
end type

event clicked;if cbx_detalle.checked then
	dw_1.Object.DataWindow.Detail.height = 60
else
	dw_1.Object.DataWindow.Detail.height = 0
end if

end event

type cbx_consumos from checkbox within w_con_compras_entre_periodos
integer x = 3630
integer y = 128
integer width = 603
integer height = 80
boolean bringtotop = true
integer textsize = -10
integer weight = 700
fontcharset fontcharset = ansi!
fontpitch fontpitch = variable!
fontfamily fontfamily = swiss!
string facename = "Arial"
long textcolor = 128
long backcolor = 12632256
string text = "Mostrar consumos"
end type

event clicked;if cbx_detalle.checked then
	dw_1.Object.DataWindow.Detail.height = 60
else
	dw_1.Object.DataWindow.Detail.height = 0
end if

end event

type dw_seleccion from u_seleccion2 within w_con_compras_entre_periodos
integer y = 228
integer height = 948
integer taborder = 70
end type

